function Get-RegistryValues {
    param (
        [string[]]$registryPaths
    )

    foreach ($registryPath in $registryPaths) {
        try {
            # Get the registry key
            $registryKey = Get-Item -LiteralPath $registryPath

            # Create an array to store hashtable objects
            $registryValues = @()

            # Enumerate values
            foreach ($valueName in $registryKey.GetValueNames()) {
                $valueType = $registryKey.GetValueKind($valueName)
                $valueData = $registryKey.GetValue($valueName)

                # Handle REG_EXPAND_SZ values by expanding environment variables
                if ($valueType -eq 'ExpandString') {
                    $valueData = [System.Environment]::ExpandEnvironmentVariables($valueData)
                }

                # Create a hashtable object for each value
                $registryValue = @{
                    'Name' = $valueName
                    'Type' = $valueType
                    'Data' = $valueData
                }

                # Add the hashtable object to the array
                $registryValues += New-Object PSObject -Property $registryValue
            }

            # Display the table
            Write-Host "Values under registry path '$registryPath':"
            $registryValues | Format-Table -AutoSize
        } catch {
            Write-Error "Error accessing registry key '$registryPath': $_"
        }
    }
}

# Example: Pass an array of registry paths
$registryPaths = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run",
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run",
    "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run",
    "HKCU:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run"
)
Get-RegistryValues -registryPaths $registryPaths
