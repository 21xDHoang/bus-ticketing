#!/usr/bin/env bash
# ============================================================
#  setup.sh - Cai dat moi truong (ban Git Bash / Linux / macOS)
#  Chay:  bash setup.sh
# ============================================================

set -e

echo "====================================="
echo "  SETUP MOI TRUONG - BUS TICKETING"
echo "====================================="

# ---------- 1. Kiem tra .NET SDK ----------
echo ""
echo "[1/5] Kiem tra .NET SDK..."

if ! command -v dotnet >/dev/null 2>&1; then
    echo "  LOI: Chua cai .NET SDK."
    echo "  Tai tai: https://dotnet.microsoft.com/download/dotnet/10.0"
    echo "  CHU Y: Phai chon SDK, KHONG phai Runtime!"
    exit 1
fi

dotnet --list-sdks

if ! dotnet --list-sdks | grep -q "^10\."; then
    echo "  CANH BAO: Khong tim thay .NET SDK 10.x"
    echo "  Du an dung SDK 10."
fi

# ---------- 2. Kiem tra Node.js ----------
echo ""
echo "[2/5] Kiem tra Node.js..."

if ! command -v node >/dev/null 2>&1; then
    echo "  LOI: Chua cai Node.js. Tai tai: https://nodejs.org"
    exit 1
fi

echo "  Node: $(node -v)"
echo "  npm : $(npm -v)"

# ---------- 3. Cai EF Core tools ----------
echo ""
echo "[3/5] Cai dotnet-ef (cong cu tao Migration)..."

dotnet tool install --global dotnet-ef 2>/dev/null || dotnet tool update --global dotnet-ef 2>/dev/null || true
echo "  Xong"

# ---------- 4. Restore backend ----------
echo ""
echo "[4/5] Restore backend..."
dotnet restore backend/BusTicketing.sln
echo "  Xong"

# ---------- 5. Cai frontend ----------
echo ""
echo "[5/5] npm install..."
(cd frontend && npm install)
echo "  Xong"

# ---------- Hoan tat ----------
echo ""
echo "====================================="
echo "  XONG! MOI TRUONG DA SAN SANG"
echo "====================================="
echo ""
echo "Buoc tiep theo:"
echo "  1. Mo VS Code:  code ."
echo "  2. Bam Ctrl+Shift+B, chon 'dev'"
echo "  3. Backend : https://localhost:7000/swagger"
echo "  4. Frontend: http://localhost:5173"
echo ""
