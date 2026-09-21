# Quy trình làm việc

> Đọc 1 lần là làm được. Có 3 phần: **nhận task** → **làm task** → **đóng task**.

---

## PHẦN 1 — Trước khi nhận task

Task **chỉ được giao** khi có đủ 5 thứ này. Thiếu 1 thứ → **chưa nhận**, báo lại Scrum Master.

- [ ] Mô tả rõ ràng, người khác đọc hiểu được
- [ ] Có estimate bằng giờ
- [ ] Có **1 người** nhận cụ thể (không phải "cả nhóm")
- [ ] Nếu cần cả FE và BE làm song song → **hợp đồng API đã có trong [`api-contract.md`](api-contract.md)**
- [ ] Biết rõ nó phụ thuộc vào task nào khác (nếu có)

**Vì sao?** Nhận một task mơ hồ kiểu *"làm trang quản lý tuyến"* thì bạn sẽ mất 1–2 ngày đoán xem phải làm gì, làm xong mới biết hiểu sai, rồi làm lại từ đầu. **5 phút làm rõ tiết kiệm 2 ngày làm lại.**

---

## PHẦN 2 — Làm task (6 bước)

### Bước 1 — Lấy code mới nhất về

```bash
git checkout main
git pull
```

> Làm bước này **mỗi lần** bắt đầu task mới. Không làm → code bạn dựa trên bản cũ → tạo PR sẽ bị conflict.

### Bước 2 — Tạo nhánh riêng cho task

```bash
git checkout -b feature/22-thanh-toan
```

Đặt tên nhánh: `feature/<số-issue>-<mô-tả-ngắn>`

| Loại | Mẫu | Ví dụ |
|---|---|---|
| Tính năng | `feature/22-thanh-toan` | số 22 là số issue trên GitHub |
| Sửa lỗi | `fix/45-loi-refresh-token` | |
| Tài liệu | `docs/cap-nhat-api` | |

### Bước 3 — Viết code

Đây là việc của bạn. Nhớ xem [`api-contract.md`](api-contract.md) nếu task có gọi API.

### Bước 4 — Nộp bài (chỉ 3 lệnh)

```bash
git add .
git commit -m "feat: them API thanh toan"
git push -u origin HEAD
```

> `origin HEAD` nghĩa là "đẩy nhánh hiện tại lên" — bạn **không cần gõ lại tên nhánh**, tránh gõ sai.

Tiền tố commit: `feat:` (tính năng) · `fix:` (sửa lỗi) · `docs:` (tài liệu) · `test:` (test) · `refactor:` (dọn code)

### Bước 5 — Tạo Pull Request

Sau khi push, GitHub in ra một link dạng `https://github.com/.../pull/new/...`

**Cách 1:** `Ctrl` + bấm vào link đó.
**Cách 2:** Vào repo → sẽ thấy nút vàng **"Compare & pull request"** → bấm.

→ Điền theo mẫu có sẵn → bấm **Create pull request**

Đợi 1–2 phút cho CI chạy:
- ✅ **Xanh** → nhờ 1 bạn vào bấm **Approve**
- ❌ **Đỏ** → bấm vào chỗ đỏ để đọc lỗi, sửa ở máy rồi lặp lại **Bước 4**. CI tự chạy lại.

### Bước 6 — Merge và dọn nhánh

Có 1 approval rồi thì:

1. Bấm **Squash and merge** → **Confirm**
2. Bấm **Delete branch**

**Xong. Quay lại Bước 1 cho task tiếp theo.**

---

## PHẦN 3 — Trước khi đóng task

Task **chỉ được coi là XONG** khi qua hết. Không có "chắc là chạy được".

**Code**
- [ ] Build sạch (`Ctrl+Shift+B` → `build-backend`, hoặc `npm run build`)
- [ ] CI trên GitHub báo xanh ✅
- [ ] Đã xoá `console.log` / code debug / `TODO` thừa

**Kiểm thử**
- [ ] Đã tự chạy thử và thấy nó hoạt động
- [ ] Đã thử **cả trường hợp lỗi** (nhập sai, thiếu dữ liệu), không chỉ trường hợp thành công

**Quy trình**
- [ ] Đã tạo Pull Request (không push thẳng lên `main`)
- [ ] Đã có 1 người approve và đã merge
- [ ] Issue trên GitHub Projects đã chuyển sang **Done**

**An toàn**
- [ ] **KHÔNG** hardcode API key / mật khẩu / connection string vào code
- [ ] Nếu làm API mới → đã cập nhật [`api-contract.md`](api-contract.md)

### Cả Sprint xong khi nào?

- [ ] Mọi story trong Sprint Goal đều đạt checklist trên
- [ ] Sản phẩm **chạy được thật** (không phải chỉ code xong)
- [ ] Demo được cho mentor
- [ ] Đã họp Sprint Review + Retrospective

---

## Tra cứu nhanh khi gặp lỗi Git

| Lỗi | Nguyên nhân | Cách sửa |
|---|---|---|
| `Permission denied (publickey)` | Máy chưa cài SSH key | Xem mục SSH trong `README.md` |
| `Your branch is behind` | Chưa `git pull` | `git checkout main && git pull` rồi tạo lại nhánh |
| `CONFLICT` khi tạo PR | 2 người sửa cùng 1 file | Gọi người kia, sửa tay file bị conflict, `git add .` → `git commit` → `git push` |
| Push bị từ chối lên `main` | Đúng rồi! Phải tạo nhánh | `git checkout -b feature/...` rồi push lại |
| `git push` báo `no upstream` | Nhánh mới chưa có trên GitHub | Dùng `git push -u origin HEAD` |
