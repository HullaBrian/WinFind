function Get-RegistryValues {
    param (
        [string[]]$registryPaths
    )

    foreach ($registryPath in $registryPaths) {
        try {
            $registryKey = Get-Item -LiteralPath $registryPath
            $registryValues = @()

            foreach ($valueName in $registryKey.GetValueNames()) {
                $valueType = $registryKey.GetValueKind($valueName)
                $valueData = $registryKey.GetValue($valueName)

                # Handle REG_EXPAND_SZ values by expanding environment variables
                if ($valueType -eq 'ExpandString') {
                    $valueData = [System.Environment]::ExpandEnvironmentVariables($valueData)
                }

                $registryValue = @{
                    'Name' = $valueName
                    'Type' = $valueType
                    'Data' = $valueData
                }
                $registryValues += New-Object PSObject -Property $registryValue
            }

            Write-Host "Values under registry path '$registryPath':"
            $registryValues | Format-Table -AutoSize
        } catch {
            Write-Error "Error accessing registry key '$registryPath': $_"
        }
    }
}

$registryPaths = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run",
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run",
    "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run",
    "HKCU:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run"
)
Get-RegistryValues -registryPaths $registryPaths
