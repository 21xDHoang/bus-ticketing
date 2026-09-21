# Hệ thống bán vé xe buýt thông minh

Đồ án nhóm — Khoa Công nghệ thông tin

---

## Thành viên

| Tên | Vai trò | Mảng chính |
|---|---|---|
| Phùng Duy Hoàng | Scrum Master | Backend, Database |
| Nguyễn Đình Băng | Developer | Frontend |
| Trần Trung Hiếu | Developer | Backend, Database |
| Nguyễn Duy Kiên | Developer | Backend |
| Dương Thị Hạnh | Developer | Frontend, Database |
| Vàng Thị Dăm | Developer | Backend, Database |
| Giàng A Vàng | Developer | Backend |
| Hoàng Văn Thịnh | Developer | Backend |

---

## Công nghệ sử dụng

| Tầng | Công nghệ |
|---|---|
| Frontend | React + TypeScript + Vite + Ant Design |
| Backend | ASP.NET Core Web API (.NET 10) |
| Database | SQL Server + Entity Framework Core |
| Xác thực | JWT |
| Realtime | SignalR |
| PWA | Service Worker + IndexedDB |

---

## Chạy dự án

### Yêu cầu

- **.NET SDK 10** — https://dotnet.microsoft.com/download/dotnet/10.0
  > ⚠️ Chọn **SDK**, **KHÔNG** chọn **Runtime**
- **Node.js 22+** — https://nodejs.org
- **SQL Server** (bản Express là đủ)
- **VS Code** + extension **C# Dev Kit**

### Cài đặt

```bash
git clone git@github.com:21xDHoang/bus-ticketing.git
cd bus-ticketing

# Windows (PowerShell)
powershell -ExecutionPolicy Bypass -File setup.ps1

# Git Bash / Linux / macOS
bash setup.sh
```

### Chạy

Mở VS Code tại thư mục dự án → bấm **`Ctrl` + `Shift` + `B`** → chọn **`dev`**

| Dịch vụ | Địa chỉ |
|---|---|
| Backend (Swagger) | https://localhost:7000/swagger |
| Frontend | http://localhost:5173 |

> 💡 Frontend đã cấu hình **proxy** sang backend. Gọi `/api/...` là tự chuyển tiếp — **không bao giờ gặp lỗi CORS**.

---

## Cấu trúc thư mục

```
bus-ticketing/
├── .github/
│   ├── workflows/ci.yml          ← CI tự động build khi có Pull Request
│   └── PULL_REQUEST_TEMPLATE.md  ← Mẫu điền khi tạo PR
├── .vscode/                      ← Cấu hình VS Code dùng chung
├── backend/
│   ├── BusTicketing.Api/         ← Controllers, Program.cs (KHÔNG chứa logic nghiệp vụ)
│   ├── BusTicketing.Domain/      ← Entity, Enum (không phụ thuộc gì)
│   ├── BusTicketing.Infrastructure/ ← DbContext, Migrations, gọi API ngoài
│   └── BusTicketing.Tests/       ← Unit test
├── frontend/                     ← React + TypeScript + Vite
├── docs/
│   ├── api-contract.md           ← 🔴 HỢP ĐỒNG API — đọc trước khi code
│   ├── definition-of-ready.md
│   ├── definition-of-done.md
│   └── sprint/                   ← Kế hoạch 5 sprint
├── .editorconfig
├── .gitignore
├── global.json
└── setup.ps1 / setup.sh
```

---

## 🔴 Quy tắc bắt buộc

### 1. Không push thẳng lên `main`

```bash
git checkout main && git pull origin main
git checkout -b feature/s1-ten-task
# ... code ...
git push -u origin feature/s1-ten-task
# → mở Pull Request trên GitHub
```

### 2. Không bao giờ commit bí mật

Repo này là **PUBLIC**. Nếu lỡ commit API key, **xoá file cũng không cứu được** — phải **đổi key ngay**.

Đọc key từ cấu hình, đừng viết vào code:

```csharp
// ❌ SAI
var key = "sk_live_abc123";

// ✅ ĐÚNG
var key = config["MoMo:SecretKey"];
```

- Lúc code ở máy → dùng `dotnet user-secrets`
- Lúc deploy → dùng Environment Variables

### 3. Đọc hợp đồng API trước khi code

Không ai được viết code gọi API trước khi endpoint đó có trong
[`docs/api-contract.md`](docs/api-contract.md).

Muốn đổi API? **Sửa file đó trước** → báo cho người còn lại → rồi mới code.

---

## Tài liệu

- [Hợp đồng API](docs/api-contract.md)
- [Definition of Ready](docs/definition-of-ready.md)
- [Definition of Done](docs/definition-of-done.md)
