# WinFind
WinFind is meant to look at places in a Windows Machine that tend to hide malicious binaries.
WinFind will enumerate registry keys, binaries residing in common directories by TTP, and startup services/tasks to warn of potential threats.

## Things on the TODO list
- Binaries that reside inside of
  - C:\Windows\
  - C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp
  - C:\Users\\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
- Startup Services
