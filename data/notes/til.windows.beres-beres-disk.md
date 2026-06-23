
Oke, gue ubah ya—lebih naratif, lebih ngalir, dan gak ada bullet point yang kaku.

---

### 📌 TIL – Bersihin Sampah Digital Biar C Drive Gak Nanggung

Hari ini gue iseng ngecek isi `C:\` karena udah mulai mepet space-nya. Pas liat di file explorer sih keliatannya bersih-bersih aja, tapi pas gue breakdown lebih dalam, ternyata banyak banget file sampah kayak `.log`, `.tmp`, `.bak`, sama `.dmp` yang ukurannya bisa sampe ratusan MB. Beberapa dari file itu diem-diem makan space tapi gak keliatan jelas dari UI biasa.

Akhirnya gue nulis skrip PowerShell buat bersihin itu semua. Gue set filter biar cuma ngambil file yang size-nya di atas 1MB, karena yang kecil-kecil mah gak ngaruh. Gue juga exclude folder-foler sensitif kayak `System32`, `WinSxS`, `Program Files`, dan lain-lain—takutnya malah bikin sistem jadi berantakan. Supaya prosesnya gak macet kalau ada file yang nge-lock atau lama dihapus, gue bungkus proses penghapusan pakai `Start-Job` dan kasih timeout 5 detik. Jadi kalau file itu ngeyel, ya gue skip dan taruh di list `$skipped` buat dicek nanti.

Skrip ini gue jalanin dari PowerShell biasa, gak butuh admin mode kecuali lo mau bersihin file di folder yang protected. Overall, ini cara bersih-bersih yang aman, bisa dipantau, dan bisa lo jalankan berkala kayak nyapu kamar setiap minggu.

Berikut skripnya:

```powershell
$deletedCount = 0
$checkedCount = 0
$skipped = @()
$excludedRoots = @(
    "C:\Windows\System32",
    "C:\Windows\WinSxS",
    "C:\Windows\Installer",
    "C:\Program Files",
    "C:\Program Files (x86)",
    "C:\$Recycle.Bin"
)

Write-Host ""
Write-Host "🧹 Starting cleanup at $(Get-Date -Format 'HH:mm:ss')..." -ForegroundColor Cyan

$files = Get-ChildItem -Path C:\ -Recurse -Force -ErrorAction SilentlyContinue | 
    Where-Object { $_.Extension -in '.log', '.tmp', '.bak', '.dmp' }

foreach ($file in $files) {
    $checkedCount++

    if ($checkedCount % 100 -eq 0) {
        Write-Host "Checked $checkedCount files..." -ForegroundColor Yellow
    }

    if ($file.Length -lt 1MB) { continue }

    $fileRoot = $file.DirectoryName
    if ($excludedRoots -contains $fileRoot -or $excludedRoots | Where-Object { $file.FullName.StartsWith($_) }) {
        continue
    }

    $timestamp = Get-Date -Format "HH:mm:ss"
    Write-Host "[$timestamp] 🗑 Attempting: $($file.FullName) ($([math]::Round($file.Length / 1MB, 2)) MB)" -ForegroundColor Gray

    $job = Start-Job { param($f) Remove-Item $f -Force -ErrorAction SilentlyContinue } -ArgumentList $file.FullName
    if (Wait-Job $job -Timeout 5) {
        Receive-Job $job | Out-Null
        Write-Host "[$timestamp] ✅ Deleted: $($file.FullName)" -ForegroundColor Green
        $deletedCount++
    } else {
        Stop-Job $job | Out-Null
        Write-Host "[$timestamp] ⚠️ Timeout: $($file.FullName)" -ForegroundColor DarkYellow
        $skipped += $file.FullName
    }
    Remove-Job $job | Out-Null
}

Write-Host ""
Write-Host "✅ Done. Deleted $deletedCount files over 1MB." -ForegroundColor Green
if ($skipped.Count -gt 0) {
    Write-Host "⚠️ Skipped $($skipped.Count) files due to timeout:" -ForegroundColor Yellow
    $skipped | ForEach-Object { Write-Host "- $_" -ForegroundColor DarkGray }
} else {
    Write-Host "🎉 No skipped files!" -ForegroundColor Cyan
}
```

Sekarang setiap kali lo ngerasa "kok C makin sempit ya padahal gak install apa-apa", tinggal run ini aja. Gak usah repot cari aplikasi cleaner pihak ketiga yang kadang malah naruh bloat baru. Mau gue buatin versi task scheduler biar auto jalan tiap Senin pagi juga bisa.