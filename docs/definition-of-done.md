# Definition of Done — Task đủ điều kiện để ĐÓNG

> Một task **chỉ được coi là HOÀN THÀNH** khi qua hết các mục dưới đây.
> Không có ngoại lệ. Không có "chắc là chạy được".

---

## 1. Code

- [ ] Build không lỗi (`dotnet build` / `npm run build` chạy sạch)
- [ ] CI trên GitHub báo xanh ✅
- [ ] Không còn comment `TODO` trong code đã viết
- [ ] Đã xoá code debug / `console.log` thừa

## 2. Kiểm thử

- [ ] Đã tự chạy thử và thấy nó hoạt động
- [ ] Có ít nhất 1 unit test cho logic nghiệp vụ chính (nếu là backend)
- [ ] Đã thử **cả trường hợp lỗi** (nhập sai, thiếu dữ liệu) — không chỉ trường hợp thành công

## 3. Quy trình

- [ ] Đã tạo Pull Request (không push thẳng lên `main`)
- [ ] Đã có ít nhất 1 người review và approve
- [ ] Đã merge vào `main`
- [ ] Issue trên GitHub Projects đã chuyển sang **Done**

## 4. An toàn & Tài liệu

- [ ] **KHÔNG** hardcode API key / connection string / mật khẩu
- [ ] Swagger đã cập nhật (nếu là API mới)
- [ ] `docs/api-contract.md` đã cập nhật (nếu có đổi hợp đồng API)

---

## Định nghĩa "Done" của cả Sprint

Sprint được coi là xong khi:

- [ ] Tất cả story trong Sprint Goal đạt Definition of Done ở trên
- [ ] Sản phẩm **chạy được thật** (không phải chỉ code xong)
- [ ] Đã demo được cho mentor
- [ ] Đã tổ chức Sprint Review + Retrospective
