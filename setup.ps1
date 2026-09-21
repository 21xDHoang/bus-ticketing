# ============================================================
#  setup.ps1 - Cai dat moi truong cho thanh vien nhom
#  Chay:  powershell -ExecutionPolicy Bypass -File setup.ps1
#
#  LUU Y: Cac dong Write-Host co tinh viet KHONG DAU,
#  vi console PowerShell mac dinh dung bang ma cp1252
#  se in tieng Viet co dau thanh ky tu rac.
# ============================================================

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "  SETUP MOI TRUONG - BUS TICKETING" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan

# ---------- 1. Kiem tra .NET SDK ----------
Write-Host ""
Write-Host "[1/5] Kiem tra .NET SDK..." -ForegroundColor Yellow

if (-not (Get-Command dotnet -ErrorAction SilentlyContinue)) {
    Write-Host "  LOI: Chua cai .NET SDK." -ForegroundColor Red
    Write-Host "  Tai tai : https://dotnet.microsoft.com/download/dotnet/10.0" -ForegroundColor Red
    Write-Host "  Hoac chay: winget install Microsoft.DotNet.SDK.10" -ForegroundColor Red
    Write-Host "  CHU Y: Phai chon SDK, KHONG phai Runtime!" -ForegroundColor Red
    exit 1
}

$sdkList = dotnet --list-sdks
Write-Host "  Da cai:" -ForegroundColor Green
$sdkList | ForEach-Object { Write-Host "    $_" -ForegroundColor Gray }

if (-not ($sdkList -match "^10\.")) {
    Write-Host "  CANH BAO: Khong tim thay .NET SDK 10.x" -ForegroundColor Red
    Write-Host "  Du an dung SDK 10. Tai tai: https://dotnet.microsoft.com/download/dotnet/10.0" -ForegroundColor Red
}

# ---------- 2. Kiem tra Node.js ----------
Write-Host ""
Write-Host "[2/5] Kiem tra Node.js..." -ForegroundColor Yellow

if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "  LOI: Chua cai Node.js." -ForegroundColor Red
    Write-Host "  Tai tai: https://nodejs.org (chon ban LTS)" -ForegroundColor Red
    exit 1
}

Write-Host "  Node: $(node -v)" -ForegroundColor Green
Write-Host "  npm : $(npm -v)" -ForegroundColor Green

# ---------- 3. Cai EF Core tools ----------
Write-Host ""
Write-Host "[3/5] Cai dotnet-ef (cong cu tao Migration)..." -ForegroundColor Yellow

dotnet tool install --global dotnet-ef 2>&1 | Out-Null
dotnet tool update  --global dotnet-ef 2>&1 | Out-Null

if (Get-Command dotnet-ef -ErrorAction SilentlyContinue) {
    Write-Host "  Xong" -ForegroundColor Green
} else {
    Write-Host "  CANH BAO: Cai dotnet-ef that bai. Thu chay lai sau." -ForegroundColor Red
}

# ---------- 4. Restore backend ----------
Write-Host ""
Write-Host "[4/5] Restore backend..." -ForegroundColor Yellow

dotnet restore backend/BusTicketing.sln
if ($LASTEXITCODE -ne 0) {
    Write-Host "  LOI: restore that bai. Bao ngay cho Hoang." -ForegroundColor Red
    exit 1
}
Write-Host "  Xong" -ForegroundColor Green

# ---------- 5. Cai frontend ----------
Write-Host ""
Write-Host "[5/5] npm install..." -ForegroundColor Yellow

Push-Location frontend
npm install
$npmExit = $LASTEXITCODE
Pop-Location

if ($npmExit -ne 0) {
    Write-Host "  LOI: npm install that bai." -ForegroundColor Red
    exit 1
}
Write-Host "  Xong" -ForegroundColor Green

# ---------- Hoan tat ----------
Write-Host ""
Write-Host "=====================================" -ForegroundColor Green
Write-Host "  XONG! MOI TRUONG DA SAN SANG" -ForegroundColor Green
Write-Host "=====================================" -ForegroundColor Green
Write-Host ""
Write-Host "Buoc tiep theo:" -ForegroundColor Cyan
Write-Host "  1. Mo VS Code:  code ." -ForegroundColor White
Write-Host "  2. Bam Ctrl+Shift+B, chon 'dev'" -ForegroundColor White
Write-Host "  3. Backend : https://localhost:7000/swagger" -ForegroundColor White
Write-Host "  4. Frontend: http://localhost:5173" -ForegroundColor White
Write-Host ""
