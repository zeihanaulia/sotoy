---
id: w4ptpcefqr98mej5hjhs3m9
title: 'Notes: Resolving Connection Issues from WSL to Windows'
desc: ''
updated: 1734422343008
created: 1732271049414
tags:
  - wsl2
---

## Steps to Resolve "Connection Refused" from WSL to Windows

### 1. Check Windows IP Address from WSL
Use the following command inside WSL to find the IP address used by Windows:
```bash
cat /etc/resolv.conf | grep nameserver
```
The IP address shown is the Windows IP address accessible from WSL.

### 2. Access Service Using Windows IP Address
Try accessing the service running on Windows from WSL using the IP address obtained earlier. Example:
```bash
curl http://10.255.255.254:1234
```

### 3. Check Firewall Settings
Ensure the Windows firewall does not block connections from WSL to Windows. Temporarily disable the firewall to check if it is the cause of the issue:
- Open "Windows Defender Firewall with Advanced Security".
- Temporarily disable the firewall for Domain, Private, and Public Network.

### 4. Ensure Services in Windows Listen on All Interfaces
Ensure the service running on Windows listens on all interfaces (`0.0.0.0`) and not just `127.0.0.1`.

### 5. Use Port Forwarding with `netsh`
Run the following command in PowerShell with Administrator rights to forward traffic from localhost to the Windows IP accessible from WSL:
```powershell
netsh interface portproxy add v4tov4 listenaddress=127.0.0.1 listenport=1234 connectaddress=10.255.255.254 connectport=1234
```

### 6. Create or Edit `.wslconfig` File
Create or edit the `.wslconfig` file in the `%UserProfile%` directory with the `networkingMode=mirrored` setting.

#### PowerShell Script to Create/Edit `.wslconfig`
```powershell
# Define the path to the .wslconfig file in the User Profile directory
$wslConfigPath = "$env:UserProfile\.wslconfig"

# Content to be added to the .wslconfig file
$newContent = "networkingMode=mirrored"

# Check if the .wslconfig file exists
if (Test-Path $wslConfigPath) {
    # Read the content of the .wslconfig file
    $content = Get-Content $wslConfigPath

    # Check if the [wsl2] section exists
    if ($content -match '\[wsl2\]') {
        # If the [wsl2] section exists, add the new setting below it
        Add-Content -Path $wslConfigPath -Value $newContent
    } else {
        # If the [wsl2] section does not exist, add the entire [wsl2] section and the new setting
        Add-Content -Path $wslConfigPath -Value "[wsl2]`n$newContent"
    }
} else {
    # If the file does not exist, create a new file with the entire [wsl2] section and the setting
    Set-Content -Path $wslConfigPath -Value "[wsl2]`n$newContent"
}

Write-Output "Setting has been added to $wslConfigPath:"
Get-Content $wslConfigPath
```

### 7. Restart Services in Windows and WSL
Restart the services running in Windows and the WSL distribution:
```powershell
wsl --shutdown
wsl
```

### 8. Use `localhost` in WSL
Try accessing `localhost` directly from WSL:
```bash
curl http://localhost:1234
```

By following these steps, you should be able to resolve the connection issue from WSL to Windows and get the desired response.

I hope these notes are helpful! If you have any further questions or need additional assistance, feel free to ask.

## Drawbacks

in wsl ubuntu cannot access internet