# Hợp đồng API — Hệ thống bán vé xe buýt

> ## 🔴 QUY TẮC SỐ 1
>
> **Không ai được viết code gọi API trước khi endpoint đó có trong file này.**
>
> Muốn đổi API? **Sửa file này trước** → báo cho người còn lại → **rồi mới code.**
>
> Đây là thứ duy nhất giữ cho 4 người BE và 4 người FE không đập vào nhau.

---

## Thông tin chung

| | |
|---|---|
| **Base URL (dev)** | `/api` — đi qua proxy của Vite |
| **Base URL (prod)** | Biến môi trường `VITE_API_URL` |
| **Xác thực** | Bearer JWT ở header `Authorization` |
| **Định dạng** | JSON, `camelCase` |

---

## Quy ước chung

### Response thành công

```json
{
  "success": true,
  "data": { },
  "message": null
}
```

### Response lỗi

```json
{
  "success": false,
  "data": null,
  "message": "Email đã tồn tại"
}
```

### Mã HTTP

| Mã | Khi nào dùng |
|---|---|
| `200` | Lấy / cập nhật thành công |
| `201` | Tạo mới thành công |
| `400` | Dữ liệu gửi lên sai định dạng |
| `401` | Chưa đăng nhập / token hết hạn |
| `403` | Đã đăng nhập nhưng không đủ quyền |
| `404` | Không tìm thấy |
| `409` | **Xung đột** — ví dụ ghế đã có người đặt |
| `500` | Lỗi server |

---

## 1. Xác thực & Tài khoản

### `POST /api/auth/register` — Đăng ký tài khoản

- **Story:** #22 | **Sprint:** 1
- **Quyền:** Không cần đăng nhập

**Request:**

```json
{
  "fullName": "Nguyễn Văn A",
  "email": "a@gmail.com",
  "phone": "0912345678",
  "password": "Abc@1234"
}
```

**Response `201`:**

```json
{
  "success": true,
  "data": {
    "userId": 1,
    "email": "a@gmail.com"
  },
  "message": null
}
```

**Lỗi:**

| Mã | `message` |
|---|---|
| `400` | `"Email không đúng định dạng"` |
| `400` | `"Mật khẩu phải có ít nhất 8 ký tự"` |
| `409` | `"Email đã được đăng ký"` |

---

### `POST /api/auth/login` — Đăng nhập

- **Story:** #22 | **Sprint:** 1
- **Quyền:** Không cần đăng nhập

**Request:**

```json
{
  "email": "a@gmail.com",
  "password": "Abc@1234"
}
```

**Response `200`:**

```json
{
  "success": true,
  "data": {
    "accessToken": "eyJhbGciOiJIUzI1NiIs...",
    "expiresIn": 3600,
    "user": {
      "id": 1,
      "fullName": "Nguyễn Văn A",
      "role": "Passenger"
    }
  },
  "message": null
}
```

**Lỗi:**

| Mã | `message` |
|---|---|
| `401` | `"Email hoặc mật khẩu không đúng"` |

---

### `GET /api/users/me` — Lấy thông tin bản thân

- **Story:** #22 | **Sprint:** 1
- **Quyền:** Đã đăng nhập

**Response `200`:**

```json
{
  "success": true,
  "data": {
    "id": 1,
    "fullName": "Nguyễn Văn A",
    "email": "a@gmail.com",
    "phone": "0912345678",
    "role": "Passenger"
  },
  "message": null
}
```

---

## 2. Vai trò trong hệ thống

| Role | Mô tả |
|---|---|
| `Passenger` | Hành khách — đặt vé, mua vé tháng |
| `Driver` | Tài xế — xem chuyến được phân công |
| `Staff` | Nhân viên bán vé — soát vé |
| `Admin` | Quản trị viên — toàn quyền |

---

<!-- ============================================================
     MẪU ĐỂ COPY KHI THÊM ENDPOINT MỚI

### `METHOD /api/duong-dan` — Tên chức năng

- **Story:** # | **Sprint:**
- **Quyền:**

**Request:**

```json
{

}
```

**Response `200`:**

```json
{

}
```

**Lỗi:**

| Mã | `message` |
|---|---|
|  |  |

============================================================ -->
