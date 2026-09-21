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

# PHẦN 1 — Cài đặt (làm 1 lần)

## 1.1. Cài công cụ

| Công cụ | Link | Ghi chú |
|---|---|---|
| Git | https://git-scm.com | |
| .NET SDK 10 | https://dotnet.microsoft.com/download/dotnet/10.0 | ⚠️ Chọn **SDK**, **KHÔNG** chọn Runtime |
| Node.js 22+ | https://nodejs.org | Chọn bản **LTS** |
| VS Code | https://code.visualstudio.com | |
| SQL Server Express | — | Bản Express là đủ |

Kiểm tra — mở PowerShell gõ 3 lệnh:

```powershell
git --version
dotnet --version     # phải hiện 10.0.xxx
node --version       # phải hiện v22.x trở lên
```

## 1.2. Cài SSH key cho GitHub

Gõ `ssh -T git@github.com`. Nếu hiện `successfully authenticated` → **bỏ qua mục này**.

Nếu báo `Permission denied (publickey)` → làm 3 bước sau:

```powershell
# Bước 1: tạo key (nhấn Enter 3 lần, không đặt passphrase)
ssh-keygen -t ed25519 -C "email-cua-ban@gmail.com"

# Bước 2: in key ra màn hình
cat $HOME\.ssh\id_ed25519.pub
```

**Bước 3:** Copy dòng vừa hiện → vào https://github.com/settings/keys → **New SSH key** → dán vào → **Add SSH key**.

Thử lại `ssh -T git@github.com` → thấy `successfully authenticated` là xong.

## 1.3. Clone code về máy

```powershell
cd "$HOME\Desktop"
git clone git@github.com:21xDHoang/bus-ticketing.git
```

## 1.4. Chạy script cài đặt

```powershell
cd "$HOME\Desktop\bus-ticketing"
powershell -ExecutionPolicy Bypass -File setup.ps1
```

Script tự làm 5 việc: kiểm tra công cụ → cài `dotnet-ef` → `dotnet restore` → `npm install` → báo kết quả. Chờ 2–5 phút.

## 1.5. Mở bằng VS Code

```powershell
code .
```

VS Code sẽ hiện **"This workspace has extension recommendations"** → bấm **Install All**.
(Đây là các extension cả nhóm dùng chung: C# Dev Kit, Prettier, oxlint, Thunder Client, GitLens)

---

# PHẦN 2 — Chạy dự án

Nhấn **`Ctrl` + `Shift` + `B`** → chọn **`dev`** → Enter.

Task này chạy **cả backend lẫn frontend cùng lúc**.

| Dịch vụ | Địa chỉ |
|---|---|
| Backend (Swagger) | https://localhost:7000/swagger |
| Frontend | http://localhost:5173 |

> 💡 Lần đầu chạy HTTPS sẽ hỏi chứng chỉ → bấm **Yes** / **Trust**.
>
> 💡 Frontend đã cấu hình **proxy** sang backend. Gọi `/api/...` là tự chuyển tiếp — **không bao giờ gặp lỗi CORS**.

---

# PHẦN 3 — Cấu trúc dự án

## 3.1. Cây thư mục

```
bus-ticketing/
│
├── backend/
│   ├── BusTicketing.sln              ← mở file này bằng VS Code
│   ├── BusTicketing.Api/             ← TOÀN BỘ code backend nằm ở đây
│   │   ├── Controllers/              ← API endpoint        (VD: AuthController.cs)
│   │   ├── Models/                   ← Entity = bảng CSDL  (VD: User.cs, Route.cs)
│   │   ├── Data/                     ← DbContext + Migrations
│   │   ├── Services/                 ← Logic nghiệp vụ     (VD: AuthService.cs)
│   │   ├── Program.cs                ← Điểm khởi động (đã cấu hình sẵn)
│   │   ├── appsettings.json          ← Cấu hình chung
│   │   └── appsettings.Development.json ← Cấu hình riêng khi code ở máy
│   └── BusTicketing.Tests/           ← Viết unit test (xUnit)
│
├── frontend/                         ← TOÀN BỘ code giao diện
│   └── src/
│       ├── api/                      ← Hàm gọi API backend
│       ├── pages/                    ← Các màn hình  (tự tạo khi cần)
│       ├── components/               ← Thành phần dùng lại (tự tạo khi cần)
│       ├── App.tsx                   ← Màn hình gốc (hiện là demo Vite)
│       └── main.tsx                  ← Điểm khởi động
│
├── docs/
│   ├── api-contract.md               ← 🔴 HỢP ĐỒNG API — đọc trước khi code
│   ├── quy-trinh.md                  ← 🔴 Quy trình làm việc — đọc trước khi nhận task
│   └── sprint/                       ← Artifact từng Sprint (burn-down, retro...)
│
├── .github/workflows/ci.yml          ← CI tự động build khi có Pull Request
└── setup.ps1                         ← Script cài đặt môi trường
```

## 3.2. Các file cấu hình — để làm gì?

Nhìn thấy nhiều file lạ thì đừng lo. **Hầu hết các bạn không bao giờ phải mở chúng.**

| File | Việc nó làm | Bạn có phải sửa? |
|---|---|---|
| `.gitignore` | Chặn không cho Git đẩy `bin/`, `obj/`, `node_modules/` và **mọi file bí mật** lên GitHub | Không |
| `global.json` | Bắt buộc dùng .NET SDK 10 — cả 8 máy chạy giống nhau | Không |
| `.editorconfig` | Tự chỉnh thụt lề, kiểu xuống dòng theo từng loại file | Không |
| `.vscode/extensions.json` | Danh sách extension VS Code → hiện nút **Install All** | Không |
| `.vscode/settings.json` | Format code tự động khi `Ctrl+S` | Không |
| `.vscode/tasks.json` | Tạo nút `Ctrl+Shift+B` → chạy `dev` | Không |
| `.vscode/launch.json` | Cho phép bấm **F5** để debug backend (đặt breakpoint) | Không |
| `.github/workflows/ci.yml` | Tự build + test mỗi khi có Pull Request | Không |
| `.github/PULL_REQUEST_TEMPLATE.md` | Mẫu điền sẵn khi bạn tạo PR | Không |
| `setup.ps1` | Cài môi trường 1 lệnh | Không |
| `frontend/.oxlintrc.json` | Luật kiểm tra lỗi code frontend | Không |

> **Chỉ 1 người sửa các file này: Hoàng (Scrum Master).** Các bạn khác cứ code bình thường.

## 3.3. Muốn làm X thì mở file nào?

| Tôi muốn... | Mở file |
|---|---|
| Thêm API mới | `backend/BusTicketing.Api/Controllers/` → tạo `XxxController.cs` |
| Thêm bảng mới vào CSDL | `backend/BusTicketing.Api/Models/` → tạo `Xxx.cs`, rồi tạo Migration |
| Tạo Migration | Terminal: `dotnet ef migrations add TenMigration` (chạy trong `backend/BusTicketing.Api`) |
| Viết logic nghiệp vụ | `backend/BusTicketing.Api/Services/` |
| Làm màn hình mới | `frontend/src/pages/` → tạo `XxxPage.tsx` |
| Gọi API từ giao diện | `frontend/src/api/` |
| Viết test | `backend/BusTicketing.Tests/` |
| Đổi cổng chạy | `backend/BusTicketing.Api/Properties/launchSettings.json` |

---

# PHẦN 4 — Quy tắc bắt buộc

### 1. Không push thẳng lên `main`

Mọi thay đổi phải qua Pull Request. Quy trình 6 bước nằm ở **[`docs/quy-trinh.md`](docs/quy-trinh.md)** — làm đúng theo đó, không cần nhớ gì thêm.

### 2. Không bao giờ commit bí mật

Repo này là **PUBLIC**. Nếu lỡ commit API key, **xoá file cũng không cứu được** — phải **đổi key ngay**.

```csharp
// ❌ SAI
var key = "sk_live_abc123";

// ✅ ĐÚNG
var key = config["MoMo:SecretKey"];
```

- Lúc code ở máy → dùng `dotnet user-secrets`
- Lúc deploy → dùng Environment Variables

### 3. Đọc hợp đồng API trước khi code

Không ai được viết code gọi API trước khi endpoint đó có trong [`docs/api-contract.md`](docs/api-contract.md).

Muốn đổi API? **Sửa file đó trước** → báo cho người còn lại → rồi mới code.

---

## Tài liệu

- 🔴 [Hợp đồng API](docs/api-contract.md) — đọc trước khi code
- 🔴 [Quy trình làm việc](docs/quy-trinh.md) — đọc trước khi nhận task
