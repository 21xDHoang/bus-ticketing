# 02 — Hiểu về dự án

> **Mục tiêu:** sau khi đọc file này, bạn biết dự án làm ra cái gì, dùng công nghệ gì, và code của mình nằm ở đâu trong bức tranh chung.

---

## 1. Dự án làm ra cái gì?

### Vấn đề hiện tại

Đi xe buýt ở Việt Nam vẫn theo cách thủ công:

| Vấn đề | Hậu quả |
|---|---|
| Phải ra bến mua vé, không biết giờ xe chạy | Hành khách chờ đợi, bỏ lỡ chuyến |
| Không biết xe đang ở đâu | Đứng chờ ở trạm mà không biết bao giờ xe tới |
| Vé giấy dễ mất, dễ làm giả | Nhà xe thất thoát doanh thu |
| Không có số liệu thống kê | Không biết tuyến nào đông, giờ nào cao điểm |

### Giải pháp

Xây dựng **hệ thống bán vé xe buýt thông minh** cho phép:

1. **Hành khách** — tìm tuyến, chọn ghế, thanh toán online, nhận vé QR, theo dõi xe realtime trên bản đồ
2. **Nhà xe** — quản lý tuyến/trạm/xe/tài xế, xếp lịch chạy, soát vé bằng QR, xem báo cáo doanh thu

**Điểm nhấn của đồ án:** vé điện tử QR có **chữ ký số chống làm giả**, và **theo dõi xe realtime** trên bản đồ.

---

## 2. Hệ thống có 4 loại người dùng

| Vai trò | Là ai | Được làm gì |
|---|---|---|
| **Admin** | Quản trị viên hệ thống | Tạo/xoá tài khoản, phân quyền, xem toàn bộ báo cáo |
| **Quản lý** | Nhân viên nhà xe | Quản lý tuyến, trạm, xe, lịch trình, giá vé, duyệt hủy/đổi vé |
| **Tài xế** | Người lái xe | Chia sẻ vị trí xe, quét QR soát vé của hành khách |
| **Hành khách** | Người đi xe | Tìm chuyến, đặt vé, thanh toán, xem vé, theo dõi xe |

> Sprint 1 làm phần **tài khoản + phân quyền** cho cả 4 vai trò này.

---

## 3. Các nhóm chức năng chính

| Nhóm | Nội dung |
|---|---|
| **Quản lý đặt vé & Vé điện tử** | Tra cứu tuyến, chọn ghế, giữ chỗ tạm 10 phút, vé QR, hủy/đổi vé |
| **Thanh toán & Tích hợp** | MoMo, VNPay, ZaloPay, thẻ ngân hàng · hoá đơn email · hoàn tiền tự động |
| **Định vị & Theo dõi realtime** | Bản đồ GPS, thông báo xe sắp tới trạm |
| **Quản lý vận hành** | Tuyến, trạm, xe, tài xế, lịch trình, phân công chuyến |
| **Báo cáo & Phân tích** | Doanh thu theo tuyến/thời gian, mật độ hành khách, dự báo nhu cầu |

---

## 4. Lộ trình 5 Sprint

Team làm **5 Sprint**, mỗi Sprint là một tầng chồng lên Sprint trước:

| Sprint | Mục tiêu | Kết quả |
|---|---|---|
| **1** | Nền tảng: Tài khoản, Phân quyền & Tuyến đường | Đăng nhập được, CRUD tuyến/trạm/giá vé, **hệ thống chạy online** |
| **2** | Chuyến xe, Tìm kiếm & Nhật ký | Tìm được chuyến, lập lịch trình, phân công xe |
| **3** | Sơ đồ ghế, Giữ chỗ & Định vị | Chọn ghế, giữ chỗ 10 phút, **theo dõi xe realtime** |
| **4** | Thanh toán & Vé điện tử | Thanh toán sandbox, **vé QR chữ ký số**, hoá đơn, hoàn tiền |
| **5** | Hủy/Đổi vé, Soát vé QR, Vé tháng & Báo cáo | Khép kín vòng đời vé, có số liệu **báo cáo + demo** |

> 🔴 **Đây là đường găng, không phải 5 phần rời nhau.** Sprint sau **không bắt đầu được** nếu Sprint trước chưa xong phần nền.
>
> **Sprint 1 trễ 1 tuần = cả đồ án trễ 1 tuần.** Vì vậy Sprint 1 là Sprint quan trọng nhất.

**File này chỉ hướng dẫn Sprint 1.** Sprint 2–5 sẽ có tài liệu riêng khi tới lúc.

---

## 5. Dự án dùng công nghệ gì?

### Ngôn ngữ lập trình

| Phần | Ngôn ngữ | Ghi chú |
|---|---|---|
| **Backend** (máy chủ) | **C#** | Chạy trên nền .NET 10 |
| **Frontend** (giao diện) | **TypeScript** | Giống JavaScript nhưng có kiểu dữ liệu, báo lỗi sớm hơn |
| **Database** | **SQL** | Câu lệnh truy vấn CSDL |

### Thư viện & framework

| Tầng | Công nghệ | Dùng để làm gì |
|---|---|---|
| Backend | **ASP.NET Core Web API** (.NET 10) | Tạo các API để frontend gọi |
| Backend | **Entity Framework Core** | Viết C# thay vì viết SQL — nó tự sinh bảng |
| Backend | **JWT** | Đăng nhập, phân quyền |
| Backend | **SignalR** | Đẩy dữ liệu realtime (vị trí xe) — Sprint 3 |
| Backend | **Swagger** | Tự sinh trang web liệt kê + thử được mọi API |
| Frontend | **React 19** | Xây giao diện |
| Frontend | **Vite** | Chạy frontend, tự reload khi sửa code |
| Frontend | **Ant Design (AntD)** | Bộ component có sẵn: Table, Form, Modal, Button... |
| Frontend | **Axios** | Gọi API từ frontend |
| Frontend | **React Router** | Chuyển trang |
| Frontend | **Leaflet** | Bản đồ — Sprint 3 |
| Database | **SQL Server** | Lưu dữ liệu |
| Database | **SSMS** | Xem dữ liệu trong bảng |

### Tại sao chọn mấy cái này?

- **C# + .NET** — miễn phí, mã nguồn mở, chạy được trên Windows/Linux, doanh nghiệp Việt Nam dùng nhiều
- **React + AntD** — AntD có sẵn bảng biểu, form, modal → tiết kiệm hàng chục giờ so với tự viết CSS
- **Entity Framework Core** — không phải viết tay hàng trăm câu SQL

---

## 6. Kiến trúc — hiểu trong 5 phút

### Ví dụ: chuyện gì xảy ra khi hành khách bấm "Đăng nhập"?

```
    Hành khách bấm nút Đăng nhập trên web
                   │
                   ▼
    ┌──────────────────────────────────────┐
    │  ①  FRONTEND  (React - TypeScript)   │
    │  LoginPage.tsx  thu số điện thoại   │
    │  và mật khẩu, rồi gọi:               │
    │  POST /api/auth/login                │
    └──────────────┬───────────────────────┘
                   │  dữ liệu gửi qua mạng
                   ▼
    ┌──────────────────────────────────────┐
    │  ②  CONTROLLER  (C#)                 │
    │  AuthController.cs                   │
    │  Nhận request, KIỂM TRA dữ liệu vào  │
    │  (thiếu số điện thoại? → trả lỗi)    │
    │  KHÔNG chứa logic nghiệp vụ          │
    └──────────────┬───────────────────────┘
                   │  gọi xuống
                   ▼
    ┌──────────────────────────────────────┐
    │  ③  SERVICE  (C#)                    │
    │  AuthService.cs                      │
    │  ĐÂY LÀ NƠI CHỨA LOGIC:              │
    │   - Tìm user trong CSDL              │
    │   - So mật khẩu bằng BCrypt          │
    │   - Sinh JWT token                   │
    └──────────────┬───────────────────────┘
                   │  cần dữ liệu
                   ▼
    ┌──────────────────────────────────────┐
    │  ④  DbContext + MODELS  (C#)         │
    │  AppDbContext.cs  +  User.cs         │
    │  Dịch thao tác C# thành câu SQL      │
    └──────────────┬───────────────────────┘
                   │
                   ▼
    ┌──────────────────────────────────────┐
    │  ⑤  SQL SERVER                       │
    │  Bảng Users, Roles, UserRoles        │
    └──────────────────────────────────────┘

    Kết quả chạy ngược lên trên:
    SQL → C# → JSON  →  Frontend hiện "Đăng nhập thành công"
```

### Bốn khái niệm bạn PHẢI nhớ

| Khái niệm | Nằm ở đâu | Nhiệm vụ | Ví dụ |
|---|---|---|---|
| **Model** | `Models/` | Mô tả **1 bảng trong CSDL**. Chỉ có thuộc tính, không có logic | `User.cs` → bảng `Users` |
| **DbContext** | `Data/` | "Cầu nối" giữa C# và SQL Server. Biết bảng nào tồn tại | `AppDbContext.cs` |
| **Controller** | `Controllers/` | Nhận request từ frontend, **kiểm tra dữ liệu vào**, trả kết quả. **Không chứa logic nghiệp vụ** | `AuthController.cs` |
| **Service** | `Services/` | **Chứa logic nghiệp vụ**. Controller gọi Service, Service gọi DbContext | `AuthService.cs` |

### Quy tắc vàng phân biệt Controller vs Service

> **Controller** = lễ tân. Nhận yêu cầu, kiểm tra giấy tờ hợp lệ, chuyển cho bộ phận chuyên môn, rồi trả kết quả về. **Không tự làm chuyên môn.**
>
> **Service** = bộ phận chuyên môn. Làm việc thật: tính toán, truy vấn, xử lý nghiệp vụ.

**Ví dụ cụ thể:**

```csharp
// ❌ SAI — Controller tự làm logic
[HttpPost("login")]
public async Task<IActionResult> Login(LoginRequest req)
{
    var user = await _db.Users.FirstOrDefaultAsync(u => u.Phone == req.Phone);
    if (user == null) return Unauthorized();
    if (!BCrypt.Verify(req.Password, user.PasswordHash)) return Unauthorized();
    var token = GenerateJwt(user);        // ← logic nhét trong Controller
    return Ok(new { token });
}

// ✅ ĐÚNG — Controller chỉ kiểm tra, Service làm logic
[HttpPost("login")]
public async Task<IActionResult> Login(LoginRequest req)
{
    if (!ModelState.IsValid) return BadRequest(ModelState);   // kiểm tra
    var result = await _authService.LoginAsync(req);          // giao chuyên môn
    return result.Success ? Ok(result) : Unauthorized(result);
}
```

---

## 7. Cấu trúc thư mục

```
bus-ticketing/
│
├── backend/
│   ├── BusTicketing.sln              ← mở file này bằng VS Code
│   └── BusTicketing.Api/             ← TOÀN BỘ code backend nằm ở đây
│       ├── Controllers/              ← API endpoint
│       ├── Models/                   ← Bảng CSDL
│       ├── Data/                     ← DbContext + Migrations
│       ├── Services/                 ← Logic nghiệp vụ
│       ├── Program.cs                ← Điểm khởi động (đã cấu hình sẵn)
│       └── appsettings.json          ← Cấu hình
│
├── frontend/                         ← TOÀN BỘ code giao diện
│   └── src/
│       ├── api/                      ← Hàm gọi API
│       ├── pages/                    ← Các màn hình
│       ├── components/               ← Component dùng lại
│       └── App.tsx                   ← Màn hình gốc
│
├── docs/                             ← Tài liệu
└── setup.ps1                         ← Script cài đặt
```

> **`pages/` và `components/` chưa tồn tại** — sẽ được tạo khi có người làm màn hình đầu tiên (Sprint 1, Băng làm).

---

## 8. Từ điển thuật ngữ

Gặp từ lạ trong task thì tra ở đây:

| Từ | Nghĩa dễ hiểu |
|---|---|
| **API** | Cách để frontend "gọi" backend. Ví dụ: `POST /api/auth/login` |
| **Endpoint** | Một API cụ thể. Ví dụ: `POST /api/auth/register` là 1 endpoint |
| **CRUD** | Create – Read – Update – Delete = Thêm – Xem – Sửa – Xoá |
| **Migration** | Lệnh biến Model trong C# thành **bảng thật** trong SQL Server |
| **Seed** | Tạo sẵn dữ liệu mẫu (ví dụ: 4 vai trò mặc định) khi mới tạo CSDL |
| **JWT** | Chuỗi ký tự backend cấp sau khi đăng nhập. Frontend giữ nó và gửi kèm mỗi lần gọi API |
| **Token** | Xem JWT |
| **Middleware** | Đoạn code chạy **trước** mọi request. Dùng để kiểm tra đăng nhập |
| **RBAC** | Phân quyền theo vai trò — Admin làm được, Hành khách thì không |
| **Interceptor** | Đoạn code tự động chạy trước/sau mỗi lần gọi API (ví dụ: tự gắn token vào) |
| **Payload** | Dữ liệu gửi kèm request |
| **Validate** | Kiểm tra dữ liệu đầu vào hợp lệ chưa |
| **Swagger** | Trang web tự sinh liệt kê mọi API, bấm là gọi thử được |
| **Migration Conflict** | 2 người cùng tạo migration → lỗi. Báo ngay cho Dăm |
| **PR (Pull Request)** | Yêu cầu gộp code của bạn vào nhánh chính. Xem [`03-lam-viec-nhom.md`](03-lam-viec-nhom.md) |
| **CI** | Máy tự động build + test code mỗi khi bạn tạo PR |

---

✅ **Đọc xong?** Sang [`03-lam-viec-nhom.md`](03-lam-viec-nhom.md) để học cách làm việc nhóm.
