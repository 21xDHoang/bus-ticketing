# 01 — Cài đặt môi trường

> **Mục tiêu:** sau khi làm hết file này, máy bạn chạy được dự án và sẵn sàng nhận task.
> **Thời gian:** 30–60 phút (chủ yếu là chờ tải).

---

## Bạn cần cài 5 thứ

| # | Công cụ | Bắt buộc | Dùng để làm gì |
|---|---|---|---|
| 1 | **Git** | ✅ | Kéo code về, đẩy code lên GitHub |
| 2 | **.NET SDK 10** | ✅ | Chạy backend (C#) |
| 3 | **Node.js 22+** | ✅ | Chạy frontend (React) |
| 4 | **VS Code** | ✅ | Viết code |
| 5 | **SQL Server Express** | ✅ | Chạy cơ sở dữ liệu |

> `dotnet-ef` (công cụ tạo bảng CSDL) **không cần cài tay** — script `setup.ps1` ở Bước 7 sẽ tự cài.

---

## Bước 1 — Cài Git

1. Vào https://git-scm.com/download/win → tải bản **64-bit**
2. Chạy file vừa tải → bấm **Next** liên tục → **Install**
3. **Mở PowerShell mới** rồi gõ:

```powershell
git --version
```

✅ Ra `git version 2.x.x` là xong.

---

## Bước 2 — Cài .NET SDK 10

> ⚠️ **QUAN TRỌNG NHẤT:** phải chọn **SDK**, **KHÔNG** chọn **Runtime**.
> Runtime chỉ để *chạy* phần mềm có sẵn. SDK mới *viết code* được. Chọn nhầm thì build không được.

1. Vào https://dotnet.microsoft.com/download/dotnet/10.0
2. Kéo xuống mục **SDK** → chọn **Windows x64** → tải
3. Chạy file → **Install**
4. **Mở PowerShell mới** rồi gõ:

```powershell
dotnet --version
```

✅ Ra `10.0.xxx` là xong. Nếu ra `8.x` hoặc `9.x` → bạn đã cài nhầm bản cũ, cài thêm bản 10.

**Cách khác (nhanh hơn):** mở PowerShell gõ `winget install Microsoft.DotNet.SDK.10`

---

## Bước 3 — Cài Node.js

1. Vào https://nodejs.org
2. Tải bản **LTS** (chữ to bên trái, KHÔNG phải "Current")
3. Chạy file → **Next** liên tục → **Install**
4. **Mở PowerShell mới** rồi gõ:

```powershell
node --version
npm --version
```

✅ Ra `v22.x` trở lên và `10.x` trở lên là xong.

---

## Bước 4 — Cài VS Code

1. Vào https://code.visualstudio.com → **Download for Windows**
2. Chạy file → **Next** → **Install**

**Chưa cần cài extension.** Khi mở dự án, VS Code sẽ tự hỏi và cài giúp bạn (xem Bước 9).

---

## Bước 5 — Cài SQL Server Express

> Nếu máy bạn đã có sẵn SQL Server (do học môn Cơ sở dữ liệu) → **bỏ qua bước này**.

1. Vào https://www.microsoft.com/en-us/download/details.aspx?id=104781
2. Tải **SQL Server Express** → chạy → chọn **Basic** → **Accept** → **Install**
3. Cài xong, mở **SSMS** (SQL Server Management Studio) để kiểm tra kết nối được

> 💡 Chưa cần tạo database vội. Task migrate bảng ở Sprint 1 sẽ tự tạo.

---

## Bước 6 — Tạo SSH key cho GitHub

SSH key giống như **chìa khoá nhà** — giúp bạn đẩy code lên GitHub mà không phải gõ mật khẩu mỗi lần.

### Kiểm tra đã có chưa

Mở PowerShell gõ:

```powershell
ssh -T git@github.com
```

| Kết quả | Nghĩa là | Làm gì |
|---|---|---|
| `Hi <tên>! You've successfully authenticated` | ✅ Đã có key | **Bỏ qua bước này**, sang Bước 7 |
| `Permission denied (publickey)` | ❌ Chưa có key | Làm tiếp bên dưới |

### Tạo key mới

```powershell
ssh-keygen -t ed25519 -C "email-cua-ban@gmail.com"
```

> Nhấn **Enter 3 lần** (chấp nhận đường dẫn mặc định, **không đặt passphrase**). Đặt passphrase thì mỗi lần push phải gõ — phiền.

### Copy key lên GitHub

```powershell
cat $HOME\.ssh\id_ed25519.pub
```

1. **Bôi đen toàn bộ** dòng vừa hiện ra → `Ctrl` + `C`
2. Mở https://github.com/settings/keys
3. Bấm **New SSH key**
4. **Title:** điền `Laptop cua <tên bạn>`
5. **Key type:** để nguyên `Authentication Key`
6. **Key:** dán đoạn vừa copy vào
7. Bấm **Add SSH key**

### Kiểm tra lại

```powershell
ssh -T git@github.com
```

✅ Ra `Hi <tên>! You've successfully authenticated` là xong.

---

## Bước 7 — Clone code về máy

Mở PowerShell, gõ **đúng 2 dòng**:

```powershell
cd "$HOME\Desktop"
git clone git@github.com:21xDHoang/bus-ticketing.git
```

✅ Trong `Desktop` xuất hiện thư mục `bus-ticketing`.

---

## Bước 8 — Chạy script cài đặt

```powershell
cd "$HOME\Desktop\bus-ticketing"
powershell -ExecutionPolicy Bypass -File setup.ps1
```

Script tự làm 5 việc, chờ **2–5 phút**:

| Bước | Việc |
|---|---|
| 1 | Kiểm tra .NET SDK |
| 2 | Kiểm tra Node.js |
| 3 | Cài `dotnet-ef` (công cụ tạo Migration) |
| 4 | `dotnet restore` — tải thư viện backend |
| 5 | `npm install` — tải thư viện frontend |

✅ Cuối cùng hiện **"XONG! MOI TRUONG DA SAN SANG"** là thành công.

> ❌ Nếu báo `running scripts is disabled` → bạn gõ thiếu phần `-ExecutionPolicy Bypass`. Gõ lại y hệt dòng lệnh trên.

---

## Bước 9 — Mở bằng VS Code

```powershell
code .
```

VS Code mở ra và hiện thông báo góc dưới phải:

> **"This workspace has extension recommendations"**

→ Bấm **Install All**

Nó sẽ cài 9 extension cả nhóm dùng chung: C# Dev Kit, Prettier, oxlint, Thunder Client, GitLens... Chờ 1–2 phút.

---

## Bước 10 — Chạy thử cả dự án

Nhấn **`Ctrl` + `Shift` + `B`** → chọn **`dev`** → **Enter**

Đợi khoảng 20–30 giây. Khi thành công:

| Mở link này | Thấy gì |
|---|---|
| https://localhost:7000/swagger | Giao diện Swagger (danh sách API) |
| http://localhost:5173 | Trang web (hiện là trang mẫu Vite) |

> ⚠️ Lần đầu chạy HTTPS, trình duyệt/Windows sẽ hỏi chứng chỉ → bấm **Yes** / **Trust**.

Để tắt: bấm vào ô Terminal rồi nhấn `Ctrl` + `C`.

---

## ✅ Checklist hoàn thành

Đánh dấu khi làm xong:

- [ ] `git --version` chạy được
- [ ] `dotnet --version` ra `10.0.xxx`
- [ ] `node --version` ra `v22.x` trở lên
- [ ] `ssh -T git@github.com` báo `successfully authenticated`
- [ ] Đã clone được repo về `Desktop\bus-ticketing`
- [ ] `setup.ps1` chạy xong không lỗi
- [ ] VS Code đã cài **Install All** extension
- [ ] `Ctrl+Shift+B` → `dev` chạy được, mở được **cả** Swagger và trang web

> 🎉 **Xong hết 8 mục trên = môi trường bạn đã sẵn sàng.** Sang file [`02-hieu-du-an.md`](02-hieu-du-an.md).

---

## Lỗi thường gặp

| Lỗi | Nguyên nhân | Cách sửa |
|---|---|---|
| `git : command not found` | Chưa cài Git, hoặc chưa mở PowerShell mới | Cài Git → **đóng hết PowerShell** → mở lại |
| `dotnet : command not found` | Chưa cài .NET SDK | Cài lại, nhớ chọn **SDK** không phải Runtime |
| `dotnet --version` ra `8.x` | Cài nhầm bản cũ | Cài thêm .NET SDK 10, không cần gỡ bản cũ |
| `Permission denied (publickey)` | Chưa thêm SSH key lên GitHub | Làm lại Bước 6 |
| `running scripts is disabled` | Thiếu `-ExecutionPolicy Bypass` | Gõ lại đúng dòng lệnh ở Bước 8 |
| `npm install` chạy mãi không xong | Mạng chậm | Đợi 5–10 phút. Vẫn không xong → đổi sang mạng khác |
| `Ctrl+Shift+B` không hiện gì | Chưa mở đúng thư mục gốc | Trong VS Code: **File → Open Folder** → chọn `bus-ticketing` |
| Cổng 7000 hoặc 5173 bị chiếm | Còn tiến trình cũ đang chạy | Đóng hết Terminal trong VS Code, chạy lại |
| Chạy `dev` báo lỗi chứng chỉ HTTPS | Chưa tin cậy chứng chỉ dev | Terminal: `dotnet dev-certs https --trust` → bấm **Yes** |

**Vẫn không được?** Chụp màn hình lỗi → gửi vào nhóm chat → tag **Hoàng (Scrum Master)**.
