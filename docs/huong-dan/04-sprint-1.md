# 04 — Sprint 1: Phân công & tiến độ

> **Mục tiêu:** biết chính xác bạn làm task nào, tạo file nào, ở thư mục nào — và ai đang chờ bạn.

---

## 1. Mục tiêu Sprint 1

> **Nền tảng: Tài khoản, Phân quyền & Tuyến đường** — có hệ thống chạy online, đăng nhập được, CRUD tuyến/trạm/giá vé; cả nhóm thành thạo stack qua vertical slice.

**Kết quả phải đạt cuối Sprint:**

| # | Kết quả | Ai chịu trách nhiệm chính |
|---|---|---|
| 1 | Hệ thống **chạy online** (có link truy cập được) | Thịnh |
| 2 | **Đăng nhập được** bằng 4 loại tài khoản | Hoàng · Hiếu · Dăm |
| 3 | **CRUD tuyến / trạm / giá vé** hoạt động | Hiếu · Kiên · Dăm |
| 4 | Giao diện đăng nhập + danh sách + form hoạt động | Băng · Hạnh · Thịnh · Vàng |

---

## 2. Tổng quan

**30 task — 132 giờ — 8 người**

| Người | Số task | Giờ | Mảng |
|---|---|---|---|
| Trần Trung Hiếu | 5 | 23 | Backend API |
| Vàng Thị Dăm | 5 | 21 | Database |
| Hoàng Văn Thịnh | 5 | 21 | Frontend + Deploy |
| Nguyễn Đình Băng | 4 | 20 | Frontend + Bản đồ |
| **Phùng Duy Hoàng** | 3 | 15 | Backend Auth |
| Dương Thị Hạnh | 3 | 14 | Frontend |
| Giàng A Vàng | 3 | 11 | Frontend + Test |
| Nguyễn Duy Kiên | 2 | 7 | Backend |

> 💡 **Kiên nhẹ nhất (7 giờ), Hiếu nặng nhất (23 giờ).** Nếu Hiếu bị kẹt, điều Kiên sang hỗ trợ CRUD.

---

## 3. Thứ tự làm — 4 nhóm

Sprint 1 chia thành 4 nhóm. **Nhóm A phải xong trước, nhóm B và D chạy song song, nhóm C chạy sau cùng.**

```
NHÓM A ─ Nền móng (CSDL + khung)
   │
   ├──► NHÓM B ─ Xác thực (đăng nhập, phân quyền)
   │
   └──► NHÓM D ─ Nghiệp vụ tuyến đường (chạy song song với B)
             │
             └──► NHÓM C ─ Giao diện (chờ B hoặc D có API)
```

---

## 4. Phân công chi tiết từng người

### 🟦 NHÓM A — Nền móng

#### Vàng Thị Dăm

| Task | Giờ | Tạo/sửa file |
|---|---|---|
| Migrate bảng Users, Roles, UserRoles + seed 4 vai trò mặc định | 4 | `Models/User.cs` · `Models/Role.cs` · `Models/UserRole.cs` · `Data/AppDbContext.cs` · `Data/Migrations/` |
| Migrate bảng Routes, Stops, RouteStops, Fares | 5 | `Models/Route.cs` · `Models/Stop.cs` · `Models/RouteStop.cs` · `Models/Fare.cs` |

#### Phùng Duy Hoàng

| Task | Giờ | Trạng thái |
|---|---|---|
| Khởi tạo solution + EF Core + Swagger + CORS + biến môi trường | 6 | ✅ **ĐÃ XONG** — repo đã dựng sẵn |

> ⚠️ Task ghi "3 project" nhưng thực tế là **2 project** (đã gộp theo yêu cầu nhóm). Khi đánh dấu Done, ghi chú lý do để hội đồng đối chiếu không thấy lệch.

---

### 🟩 NHÓM B — Xác thực

#### Trần Trung Hiếu

| Task | Giờ | Tạo/sửa file |
|---|---|---|
| API POST /auth/register — đăng ký hành khách, validate SĐT/email/mật khẩu | 5 | `Controllers/AuthController.cs` · `Services/AuthService.cs` |
| Mã hóa mật khẩu BCrypt + rate-limit chống brute-force | 3 | `Services/PasswordService.cs` · `Services/RateLimitService.cs` |

#### Phùng Duy Hoàng

| Task | Giờ | Tạo/sửa file |
|---|---|---|
| API POST /auth/login — cấp JWT access token + refresh token | 5 | `Controllers/AuthController.cs` · `Services/AuthService.cs` · `Services/TokenService.cs` |
| API POST /auth/refresh-token và /auth/logout — thu hồi refresh token | 4 | `Controllers/AuthController.cs` · `Services/TokenService.cs` |

> ⚠️ **Hiếu và Hoàng cùng viết `AuthController.cs`** → phải thống nhất trước: ai viết phần nào, đặt tên hàm ra sao. **Tốt nhất: Hiếu làm `register`, Hoàng làm `login`/`refresh`/`logout` — hai vùng khác nhau trong cùng file.**

#### Vàng Thị Dăm

| Task | Giờ | Tạo/sửa file |
|---|---|---|
| Middleware xác thực JWT — verify token, gắn user/role, xử lý 401 | 4 | `Services/JwtMiddleware.cs` · `Program.cs` (đăng ký) |
| Middleware phân quyền RBAC `[Authorize(Roles)]` + trả 403 | 4 | `Services/RbacMiddleware.cs` |

#### Trần Trung Hiếu *(tiếp)*

| Task | Giờ | Tạo/sửa file |
|---|---|---|
| API CRUD tài khoản nội bộ `/admin/users` (lọc, tìm kiếm, phân trang) | 6 | `Controllers/AdminUserController.cs` |

#### Nguyễn Duy Kiên

| Task | Giờ | Tạo/sửa file |
|---|---|---|
| API khóa/mở khóa tài khoản + gán/thu hồi vai trò | 3 | `Controllers/AdminUserController.cs` |

> ⚠️ **Hiếu và Kiên cùng viết `AdminUserController.cs`** → Hiếu làm CRUD, Kiên làm khóa/mở + gán vai trò.

---

### 🟨 NHÓM D — Nghiệp vụ tuyến đường *(chạy song song với nhóm B)*

#### Trần Trung Hiếu

| Task | Giờ | Tạo/sửa file |
|---|---|---|
| API CRUD Tuyến đường `/routes` + validate | 5 | `Controllers/RouteController.cs` · `Services/RouteService.cs` |
| API CRUD Trạm dừng `/stops` kèm toạ độ lat/lng + địa chỉ | 4 | `Controllers/StopController.cs` · `Services/StopService.cs` |

#### Vàng Thị Dăm

| Task | Giờ | Tạo/sửa file |
|---|---|---|
| API gán trạm vào tuyến + sắp xếp lại thứ tự `/routes/{id}/stops` | 4 | `Controllers/RouteController.cs` |

#### Nguyễn Duy Kiên

| Task | Giờ | Tạo/sửa file |
|---|---|---|
| API cấu hình bảng giá vé theo tuyến và theo đối tượng ưu đãi | 4 | `Controllers/FareController.cs` · `Services/FareService.cs` |

---

### 🟥 NHÓM C — Giao diện *(chờ nhóm B/D có API)*

#### Nguyễn Đình Băng

| Task | Giờ | Tạo/sửa file |
|---|---|---|
| Cấu hình axios interceptor tự động refresh token + Context đăng nhập | 4 | `frontend/src/api/axios.ts` · `frontend/src/contexts/AuthContext.tsx` |
| Màn hình Đăng nhập / Đăng ký (form + validate + xử lý lỗi API) | 7 | `frontend/src/pages/LoginPage.tsx` · `frontend/src/pages/RegisterPage.tsx` |
| Màn hình quản lý Trạm dừng + chọn toạ độ trên bản đồ (Leaflet) | 6 | `frontend/src/pages/StopManagePage.tsx` |
| Tài liệu hợp đồng API (Swagger + README) | 3 | `docs/api-contract.md` — ✅ đã có sẵn, chỉ cần bổ sung endpoint mới |

> 🔴 **Băng làm `axios.ts` ĐẦU TIÊN** — vì các màn hình khác đều cần nó để gọi API.

#### Dương Thị Hạnh

| Task | Giờ | Tạo/sửa file |
|---|---|---|
| Màn hình Admin – Danh sách người dùng (Table, lọc vai trò, tìm kiếm, phân trang) | 5 | `frontend/src/pages/AdminUserListPage.tsx` |
| Màn hình danh sách Tuyến (Table, tìm kiếm, lọc trạng thái, phân trang) | 5 | `frontend/src/pages/RouteListPage.tsx` |
| Màn hình cấu hình bảng giá vé theo tuyến và đối tượng ưu đãi | 4 | `frontend/src/pages/FareConfigPage.tsx` |

#### Hoàng Văn Thịnh

| Task | Giờ | Tạo/sửa file |
|---|---|---|
| Modal Thêm/Sửa người dùng + gán vai trò + khóa/mở khóa | 4 | `frontend/src/components/UserFormModal.tsx` |
| Form Thêm/Sửa tuyến đường + xác nhận xoá | 5 | `frontend/src/components/RouteForm.tsx` |
| Cấu hình `.vscode`, `global.json`, `.editorconfig` | 3 | ✅ **ĐÃ XONG** |
| Deploy lần đầu: MonsterASP.NET + Cloudflare Pages + R2 + Tunnel | 5 | *(không có thư mục — thao tác trên web)* |
| Artifact Sprint 1: Sprint Backlog, Burn-down, Review, Retrospective | 4 | `docs/sprint/` |

#### Giàng A Vàng

| Task | Giờ | Tạo/sửa file |
|---|---|---|
| Route guard phía client + xử lý lỗi 401/403 | 3 | `frontend/src/components/RouteGuard.tsx` |
| UI gán trạm vào tuyến bằng kéo-thả sắp xếp thứ tự trạm | 4 | `frontend/src/components/StopDragDrop.tsx` |
| Viết test API CRUD tuyến/trạm/giá vé (xUnit) | 4 | `backend/BusTicketing.Tests/RouteApiTests.cs` |

---

## 5. Ai đang chờ ai? (bảng phụ thuộc)

| Người | Chờ ai | Chờ cái gì |
|---|---|---|
| Hiếu, Hoàng, Dăm (nhóm B) | **Dăm** | Bảng `Users`, `Roles`, `UserRoles` phải có trước |
| Hiếu, Kiên, Dăm (nhóm D) | **Dăm** | Bảng `Routes`, `Stops`, `RouteStops`, `Fares` phải có trước |
| Băng, Hạnh, Thịnh, Vàng (nhóm C) | **Hiếu, Hoàng, Kiên** | API phải có trước mới gọi được |
| Tất cả | **Băng** | `axios.ts` phải có trước khi màn hình nào gọi API |

> 🔴 **Dăm là điểm nghẽn của cả Sprint 1.** Hai task migrate của Dăm chặn 6 người còn lại.
> **Dăm nên làm migrate TRƯỚC, làm xong đẩy lên sớm** để cả nhóm bắt đầu được.

> 💡 **Nhóm C không cần ngồi chờ API thật.** Đọc [`api-contract.md`](../api-contract.md) để biết response trả về gì, tự tạo dữ liệu giả để code giao diện trước. Khi API xong chỉ đổi chỗ gọi.

---

## 6. Ba task đã xong sẵn — tiết kiệm 12 giờ

| Task | Người | Giờ tiết kiệm | Ghi chú |
|---|---|---|---|
| Khởi tạo solution + EF Core + Swagger + CORS | Hoàng | 6 | Repo đã dựng sẵn, chạy được |
| Cấu hình `.vscode`, `global.json`, `.editorconfig` | Thịnh | 3 | Cả nhóm dùng chung được ngay |
| Tài liệu hợp đồng API | Băng | 3 | `docs/api-contract.md` đã có, chỉ cần bổ sung endpoint mới |

→ **Ba người này có thêm thời gian hỗ trợ người khác.** Đặc biệt Thịnh (21 giờ) và Hoàng (15 giờ) nên san sẻ cho Dăm.

---

## 7. Checklist cuối Sprint 1

Sprint 1 được coi là **thành công** khi:

- [ ] Hệ thống **chạy online**, có link truy cập được
- [ ] Đăng nhập được bằng **cả 4 vai trò**: Admin, Quản lý, Tài xế, Hành khách
- [ ] Vào được trang Admin, thấy **danh sách người dùng**
- [ ] **Thêm / sửa / xoá tuyến đường** hoạt động
- [ ] **Thêm / sửa trạm dừng** có chọn toạ độ trên bản đồ
- [ ] **Gán trạm vào tuyến** và sắp xếp thứ tự được
- [ ] **Cấu hình giá vé** theo tuyến hoạt động
- [ ] Trang Swagger hiện **đủ API đã làm**
- [ ] `docs/api-contract.md` khớp với API thật
- [ ] CI trên GitHub **xanh**
- [ ] Không có ai push thẳng lên `main`
- [ ] Đã họp **Sprint Review** (demo cho mentor) + **Retrospective**
- [ ] Đã nộp artifact vào `docs/sprint/`

---

## 8. Việc đầu tiên mỗi người cần làm — ngay hôm nay

| Người | Việc đầu tiên |
|---|---|
| **Dăm** | Tạo `Models/User.cs`, `Role.cs`, `UserRole.cs` → chạy migration đầu tiên → **đẩy lên sớm nhất có thể** |
| **Hiếu** | Đọc `api-contract.md` phần `/auth/register` → viết `AuthController.cs` |
| **Hoàng** | Đọc `api-contract.md` phần `/auth/login` → viết `AuthService.cs` |
| **Băng** | Tạo `frontend/src/api/axios.ts` trước tiên — 3 người khác đang chờ file này |
| **Kiên** | Đọc `api-contract.md` → chuẩn bị `FareController.cs` (chờ Dăm migrate xong) |
| **Hạnh** | Tạo `frontend/src/pages/` → làm khung `AdminUserListPage.tsx` với dữ liệu giả |
| **Thịnh** | Tạo `UserFormModal.tsx` với dữ liệu giả |
| **Vàng** | Tạo `RouteGuard.tsx` — cần `AuthContext.tsx` của Băng |

> 🔴 **Nhớ tạo GitHub Issue cho mỗi task trước khi bắt đầu** — để mọi người nhìn bảng Projects biết ai đang làm gì.

---

✅ **Đọc xong?** Quay lại [`README.md`](README.md) nếu cần tra cứu nhanh, hoặc bắt đầu code.
