# 📘 Hướng dẫn thành viên — Hệ thống bán vé xe buýt thông minh

> **Dành cho:** 8 thành viên nhóm · **Cập nhật:** Sprint 1

Bộ tài liệu này giúp bạn từ **chưa cài gì** → **code được** → **đẩy code lên GitHub**.

---

## Đọc theo thứ tự này

| # | File | Nội dung | Thời gian đọc |
|---|---|---|---|
| **1** | [01-cai-dat.md](01-cai-dat.md) | Cài Git, .NET, Node.js, VS Code, SQL Server, SSH key, clone code | 30 phút |
| **2** | [02-hieu-du-an.md](02-hieu-du-an.md) | Dự án làm gì, dùng công nghệ gì, kiến trúc, từ điển thuật ngữ | 20 phút |
| **3** | [03-lam-viec-nhom.md](03-lam-viec-nhom.md) | Git pull/push, quy trình 6 bước, **code xong thì làm gì**, lỗi thường gặp | 25 phút |
| **4** | [04-sprint-1.md](04-sprint-1.md) | **Bạn làm task nào, tạo file nào, ở thư mục nào** | 15 phút |

> 🔴 **Bắt buộc đọc hết 4 file trước khi nhận task.** Mất 90 phút, tiết kiệm hàng chục giờ mò mẫm.

---

## Tôi cần gì thì mở file nào?

| Tôi đang... | Mở file |
|---|---|
| Mới vào nhóm, chưa cài gì | [01-cai-dat.md](01-cai-dat.md) |
| Cài rồi mà chạy không được | [01-cai-dat.md](01-cai-dat.md) → mục **Lỗi thường gặp** |
| Không hiểu dự án làm gì | [02-hieu-du-an.md](02-hieu-du-an.md) |
| Không hiểu từ "middleware", "migration", "JWT"... | [02-hieu-du-an.md](02-hieu-du-an.md) → mục **Từ điển thuật ngữ** |
| Không biết code nên đặt ở đâu | [02-hieu-du-an.md](02-hieu-du-an.md) → mục **Kiến trúc** |
| Muốn biết task của mình tạo file nào | [04-sprint-1.md](04-sprint-1.md) |
| Code xong, không biết làm gì tiếp | [03-lam-viec-nhom.md](03-lam-viec-nhom.md) → mục **5** |
| Git báo lỗi đỏ | [03-lam-viec-nhom.md](03-lam-viec-nhom.md) → mục **6** |
| Bị conflict khi tạo PR | [03-lam-viec-nhom.md](03-lam-viec-nhom.md) → mục **7** |
| Không biết khi nào task được coi là xong | [03-lam-viec-nhom.md](03-lam-viec-nhom.md) → mục **9** |
| Cần biết API trả về gì | [api-contract.md](../api-contract.md) |

---

## Bản đồ tổng thể — 4 tài liệu liên kết với nhau

```
   BẠN MỚI VÀO NHÓM
          │
          ▼
   ① 01-cai-dat.md ──────► Cài xong, chạy được dự án
          │
          ▼
   ② 02-hieu-du-an.md ───► Hiểu dự án, biết code đặt ở đâu
          │
          ▼
   ③ 03-lam-viec-nhom.md ► Biết cách pull / push / tạo PR
          │
          ▼
   ④ 04-sprint-1.md ─────► Biết CHÍNH XÁC mình làm gì
          │
          ▼
      BẮT ĐẦU CODE
```

---

## Ba việc phải làm NGAY khi mới vào nhóm

- [ ] **1.** Đọc hết 4 file trên
- [ ] **2.** Cài xong môi trường, chạy được `Ctrl+Shift+B` → `dev`
- [ ] **3.** Tạo SSH key, thử `ssh -T git@github.com` thấy `successfully authenticated`

Xong 3 việc này → báo vào nhóm chat → nhận task Sprint 1.

---

## Quy tắc vàng của nhóm

| # | Quy tắc |
|---|---|
| 🔴 1 | **Không push thẳng lên `main`** — mọi thay đổi phải qua Pull Request |
| 🔴 2 | **Không commit bí mật** — repo PUBLIC, lỡ commit API key thì phải **đổi key ngay** |
| 🔴 3 | **Đọc `api-contract.md` trước khi code** — không tự bịa tên API |
| 🔴 4 | **Không sửa file của người khác** — cần dùng chung thì hỏi trước |
| 🔴 5 | **Bị chặn thì nói ra** trong Daily Standup — im lặng là cả nhóm trễ theo |

---

## Liên hệ

| Vai trò | Người | Việc gì |
|---|---|---|
| **Scrum Master** | Phùng Duy Hoàng | Không chạy được dự án · Git lỗi · Không hiểu task |
| **Chủ CSDL** | Vàng Thị Dăm | Câu hỏi về bảng, Model, Migration |
| **Chủ API** | Trần Trung Hiếu | Câu hỏi về Controller, endpoint |
| **Chủ giao diện** | Nguyễn Đình Băng | Câu hỏi về React, AntD, gọi API từ frontend |

> **Gặp lỗi thì chụp màn hình gửi nhóm chat.** Đừng tự mò — mò sai có thể làm mất code của người khác.

---

## Còn tài liệu nào khác?

| File | Nội dung |
|---|---|
| [`../api-contract.md`](../api-contract.md) | 🔴 Hợp đồng API — mọi endpoint, ai gọi gì trả về gì |
| `../sprint/` | Artifact từng Sprint: burn-down chart, biên bản review, retrospective |

> 📄 **Bản DOCX:** bộ tài liệu này cũng có bản `.docx` trong thư mục [`docx/`](docx/) để in hoặc gửi cho mentor.
