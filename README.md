# WinFind
WinFind is a personal project of mine meant to look at places in a Windows Machine that tend to hide malicious binaries.
WinFind will enumerate registry keys, binaries residing in common places, and startup services/tasks to warn of potential threats.

## Things on the TODO list
- Binaries that reside inside of
  - C:\Windows\
  - C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp
  - C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
- Startup Services
  ```powershell
  Get-Service | Where-Object { $_.StartType -eq 'Automatic' } | ForEach-Object {
  [pscustomobject]([ordered]@{
  "Service Name" = $($_.Name)
  "Start Type" = $($_.StartType)
  "Status" = $($_.Status)
  })
  }
  ```
