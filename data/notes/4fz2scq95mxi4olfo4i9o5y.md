
Lo pasti pernah ngerasa terminal bawaan Windows itu... meh. Hitam, polos, dan bosenin. Gue juga gitu. Tapi sekarang gue mau share perjalanan gue dari awal setup SSH key ke GitHub sampai akhirnya punya PowerShell yang bukan cuma enak diliat, tapi juga enak dipake. 

## SSH Key ke GitHub: Pondasi Awal

Semua berawal dari kebutuhan buat push-pull repo di GitHub tanpa harus ketik username dan password tiap saat. Solusinya? SSH key. Gue generate key pakai `ssh-keygen`, terus tambahin ke ssh-agent. Tapi kayak biasa, Windows nggak semulus itu. Service `ssh-agent` nggak bisa jalan, ternyata harus dijalanin secara manual dulu.

```powershell
Start-Service ssh-agent
```

Setelah itu gue add key-nya:

```powershell
ssh-add "C:\Users\Windows\.ssh\id_rsa"
```

Terus test koneksi:

```powershell
ssh -T git@github.com
```

Kalau muncul pesan "Hi username, you've successfully authenticated..." berarti aman.

## Upgrade PowerShell 7: Biar Gak Tertinggal Zaman

Ternyata PowerShell lama nggak bisa install module modern. Gue install PowerShell 7 pakai winget:

```powershell
winget install --id Microsoft.Powershell --source winget
```

Terus make sure jalanin pakai `pwsh`, bukan `powershell`. Bisa dicek versi juga:

```powershell
$PSVersionTable.PSVersion
```

## Error Lagi? Masalah Module & Path yang Nggak Terbaca

Pas gue coba install module `Terminal-Icons` atau `PowerShellGet`, error mulu. Setelah dicek-cek, ternyata module yang udah gue extract secara manual malah nggak bisa di-load. Gue kira karena path-nya salah atau PowerShell nggak nemu file `.psd1` yang jadi identitas modulnya.

Solusinya? Pastikan semua file module udah diekstrak ke folder:

```powershell
$env:USERPROFILE\Documents\PowerShell\Modules\PowerShellGet
```

Dan make sure file `PowerShellGet.psd1` emang beneran ada:

```powershell
Test-Path "$env:USERPROFILE\Documents\PowerShell\Modules\PowerShellGet\PowerShellGet.psd1"
```

Kalau udah, tinggal import ulang:

```powershell
Import-Module PowerShellGet -Force
```

## Oh My Posh: Biar Terminal Lo Kece

Sekarang bagian serunya. Gue install `oh-my-posh` biar prompt-nya warna-warni dan informatif:

```powershell
winget install JanDeDobbeleer.OhMyPosh -s winget
```

Terus gue pake theme `jandedobbeleer` yang udah built-in. Di `$PROFILE`, tambahin:

```powershell
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\jandedobbeleer.omp.json" | Invoke-Expression
```

Dan pastiin pake font Nerd Font seperti `MesloLGS NF`, karena tanpa ini icon bakal jadi tanda tanya semua.

## Git Alias biar Ngetik Cepet

Gue tambahin alias ala ZSH ke dalam `$PROFILE` juga:

```powershell
function ga  { git add @args }
function gc  { git commit @args }
function gcm { git commit -m @args }
function gp  { git push @args }
function gl  { git log @args }
function gst { git status }
function gcam { param($msg); git commit -am $msg }
```

Alias ini bener-bener ngebantu biar nggak perlu ketik panjang tiap kali commit.

## Issue di VSCode

Nyebelin banget entah kenapa vscode ngerefer ke `$PROFILE` yang berbeda. jadi mesti diakalin di profile dia buat dialigkan ke yang sama kaya di terminal

```powershell
# Forwarder: Redirect pwsh to use WindowsPowerShell profile
$winProfile = "$env:OneDrive\Dokumen\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
if (Test-Path $winProfile) {
    . $winProfile
} else {
    Write-Host "⚠️ Profile WindowsPowerShell tidak ditemukan."
}
```

Konyol baget, abis dialihin kaya gini, baru bisa.

## Penutup

Sekarang PowerShell gue nggak cuma enak dipake tapi juga enak diliat. Prompt-nya informatif, icon muncul semua, dan semua udah sinkron dengan baik. Mungkin keliatan ribet, tapi begitu semua kelar, rasanya puas banget.