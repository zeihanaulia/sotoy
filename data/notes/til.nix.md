
Nix adalah solusi kalau lo males buat setup development env dari 0, tiap ganti laptop lo harus instal satu persatu tools yang lo butuhin. dengan nix lo bisa mendeklarasikan konfigurasi yang lo mau.

ini adalah proses yang gw lakuin, ketika gw init os baru di wsl dengan os ubuntu


## instalasi ulang dengan 
awalnya gw setup dari zero to nix, tapi entah kenapa banyak error terjadi dan gw nemu instalasi tanpa daemo dengan cara ini [ https://github.com/NixOS/nix/issues/3435#issuecomment-859461593](https://github.com/NixOS/nix/issues/3435#issuecomment-1120488592)

`sh <(curl -L https://nixos.org/nix/install) --no-daemon`
  
## Build Nix

build nix dari repository

```bash
nix build github:zeihanaulia/nixpkgs#homeConfigurations.x86_64-linux.zeihanaulia.activationPackage
```
  
## Activate zsh  
karena gw menggunakan zsh, maka gw activate lewat command ini `chsh -s $(which zsh)`


selesai sih dengan kaya gini, gw udah bisa dapet semua env yang gw mau setup di setiap komputer yang gw pake.