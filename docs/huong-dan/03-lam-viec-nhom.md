# 03 — Làm việc nhóm với Git & GitHub

> **Mục tiêu:** sau khi đọc file này, bạn biết cách kéo code về, đẩy code lên, và **code xong thì làm gì tiếp**.
> Đây là file bạn sẽ mở lại nhiều nhất. Lưu lại để tra.

---

## 1. Git là gì? Tại sao phải dùng?

**Git** giống như **Google Docs cho code** — nhưng có 3 điểm khác:

| | Google Docs | Git |
|---|---|---|
| Nhiều người sửa cùng lúc | Sửa đè lên nhau | Mỗi người sửa **bản riêng**, rồi gộp lại |
| Lịch sử | Xem được lịch sử sửa | Xem được **ai sửa dòng nào, lúc nào, vì sao** |
| Sai thì sao | Khó khôi phục | **Quay lại bản cũ bất cứ lúc nào** |

**GitHub** là trang web chứa bản code chung của cả nhóm.

---

## 2. Ba khái niệm bạn phải hiểu

### ① Repository (repo)

Là **thư mục dự án trên GitHub**. Của nhóm ta là `21xDHoang/bus-ticketing`.

### ② Branch (nhánh)

Hãy tưởng tượng quyển vở nhóm:
- **`main`** = bản chính, **luôn phải chạy được**, không ai được viết bẩn lên
- **`feature/...`** = bản nháp của riêng bạn, viết sai cũng không ảnh hưởng ai

```
main     ──●────●─────────────●────●──→   (luôn sạch, luôn chạy được)
             \               /
feature/22    ●───●───●───●──┘              (nháp của bạn, tự do thử)
```

**Bạn luôn code trên nhánh `feature/...` của mình. Không bao giờ code trực tiếp trên `main`.**

### ③ Pull Request (PR)

Khi code xong, bạn **xin phép gộp** nhánh của mình vào `main`. Cái "đơn xin phép" đó gọi là **Pull Request**.

Trong PR:
- **CI** (máy) tự build + test code của bạn → báo ✅ xanh hoặc ❌ đỏ
- **1 bạn khác** đọc code của bạn → bấm **Approve**
- Xong cả 2 → bấm **Merge** để gộp vào `main`

> **Tại sao phải rườm rà vậy?** Vì nếu ai cũng đẩy thẳng lên `main`, chỉ cần 1 người đẩy code lỗi là **cả 7 người còn lại không chạy được dự án**. PR là "cửa kiểm soát" chặn việc đó.

---

## 3. Kéo code về (pull)

**Làm mỗi sáng, và mỗi lần bắt đầu task mới.**

Mở Terminal trong VS Code (`Ctrl` + `` ` ``) rồi gõ:

```bash
git checkout main
git pull
```

| Lệnh | Nghĩa |
|---|---|
| `git checkout main` | Chuyển về nhánh chính |
| `git pull` | Tải code mới nhất của cả nhóm về máy bạn |

> **Tại sao phải pull?** Trong lúc bạn ngủ, 7 người khác có thể đã đẩy code lên. Không pull → bạn code trên bản cũ → tạo PR sẽ bị **conflict**.

✅ Kết quả đúng: `Already up to date.` hoặc danh sách file vừa được cập nhật.

---

## 4. Quy trình làm 1 task — 6 bước

### BƯỚC 1 — Lấy code mới nhất

```bash
git checkout main
git pull
```

### BƯỚC 2 — Tạo nhánh riêng cho task

```bash
git checkout -b feature/22-dang-ky-tai-khoan
```

**Cách đặt tên nhánh:**

```
feature/<số-issue>-<mô-tả-ngắn-không-dấu>
```

| Loại | Ví dụ |
|---|---|
| Làm tính năng | `feature/22-dang-ky-tai-khoan` |
| Sửa lỗi | `fix/45-loi-refresh-token` |
| Viết tài liệu | `docs/cap-nhat-api-contract` |

> Số issue là số trên GitHub (xem cột **Issue** trong bảng phân công Sprint 1).

✅ Kiểm tra đang ở nhánh nào:

```bash
git status
```
→ Phải thấy dòng `On branch feature/22-dang-ky-tai-khoan`

### BƯỚC 3 — Viết code

Đây là việc của bạn. Một số lưu ý:

- **Lưu file liên tục** — `Ctrl` + `S`. VS Code tự format code khi lưu
- Muốn xem thử giao diện → `Ctrl` + `Shift` + `B` → `dev`
- Muốn debug backend → bấm **F5**, đặt breakpoint bằng cách bấm vào lề trái số dòng
- **Không sửa file của người khác.** Cần dùng chung → hỏi trước

### BƯỚC 4 — Nộp bài

Code xong, tự chạy thử thấy hoạt động rồi thì:

```bash
git add .
git commit -m "feat: them API dang ky tai khoan"
git push -u origin HEAD
```

| Lệnh | Nghĩa |
|---|---|
| `git add .` | Chọn **tất cả** file bạn vừa sửa để chuẩn bị nộp |
| `git commit -m "..."` | Ghi lại "lần nộp này tôi làm gì" |
| `git push -u origin HEAD` | Đẩy lên GitHub. `HEAD` = nhánh hiện tại, **khỏi gõ lại tên nhánh** |

**Tiền tố commit — dùng đúng để dễ tra cứu sau này:**

| Tiền tố | Khi nào dùng |
|---|---|
| `feat:` | Thêm tính năng mới |
| `fix:` | Sửa lỗi |
| `docs:` | Sửa tài liệu |
| `test:` | Thêm/sửa test |
| `refactor:` | Dọn code, không đổi chức năng |
| `chore:` | Việc lặt vặt: cấu hình, cài thư viện |

✅ Kết quả đúng — GitHub in ra dòng có link:

```
remote: Create a pull request for 'feature/22-dang-ky-tai-khoan' on GitHub by visiting:
remote:      https://github.com/21xDHoang/bus-ticketing/pull/new/feature/22-dang-ky-tai-khoan
```

> ⚠️ **Nếu gõ `git add .` mà thấy danh sách có `node_modules/` hoặc `bin/`, `obj/`** → **DỪNG LẠI**, đừng commit. Báo ngay cho Hoàng — file `.gitignore` có vấn đề.

### BƯỚC 5 — Tạo Pull Request

**Cách 1:** Giữ `Ctrl` và bấm vào link GitHub vừa in ra.
**Cách 2:** Mở https://github.com/21xDHoang/bus-ticketing → sẽ thấy nút vàng **"Compare & pull request"** → bấm.

Trên trang tạo PR:

1. **Title** — điền giống commit, ví dụ `feat: thêm API đăng ký tài khoản`
2. **Description** — điền theo mẫu có sẵn:
   - `Issue:` điền `#22` (số issue)
   - `Đã làm gì:` 2–3 dòng
   - `Cách kiểm tra:` các bước để người review chạy thử
   - Tick các ô checklist
3. Bấm **Create pull request**

**Chờ CI chạy 1–2 phút.** Cuối trang PR sẽ hiện:

| Thấy gì | Nghĩa | Làm gì |
|---|---|---|
| ✅ **All checks have passed** | Code build + test OK | Nhờ 1 bạn vào **Approve** |
| ❌ **Some checks were not successful** | Code có lỗi | Bấm **Details** đọc lỗi → sửa ở máy → lặp lại **Bước 4** |
| 🟡 **Some checks haven't completed** | Đang chạy | Đợi thêm 1 phút, bấm `F5` tải lại trang |

**Nhờ review** — gửi vào nhóm chat:

> Mọi người review giúp mình PR #23 với ạ: `<dán link PR>`

**Khi có người Approve:**

1. Bấm nút xanh **Squash and merge**
2. Bấm **Confirm squash and merge**
3. Bấm **Delete branch** (nút hiện ra ngay sau đó)

### BƯỚC 6 — Quay lại Bước 1 cho task tiếp theo

```bash
git checkout main
git pull
git checkout -b feature/25-task-tiep-theo
```

> ⚠️ **Nhớ `git checkout main` TRƯỚC.** Nếu bạn còn đang ở nhánh cũ mà tạo nhánh mới, nhánh mới sẽ bị dính code cũ.

---

## 5. Code xong rồi — làm gì tiếp? (tóm tắt 1 khối)

```bash
# ① Kiểm tra code chạy được
#    Ctrl+Shift+B → build-backend     (phải 0 lỗi)
#    Ctrl+Shift+B → frontend          (npm run lint phải sạch)

# ② Nộp bài
git add .
git commit -m "feat: mo ta ngan gon viec da lam"
git push -u origin HEAD

# ③ Lên GitHub → bấm "Compare & pull request" → điền mẫu → Create pull request
# ④ Đợi CI xanh ✅
# ⑤ Nhờ 1 bạn Approve
# ⑥ Bấm "Squash and merge" → "Confirm" → "Delete branch"
# ⑦ Vào GitHub Projects → kéo thẻ task của mình sang cột "Done"

# ⑧ Bắt đầu task tiếp theo
git checkout main
git pull
git checkout -b feature/<số-issue>-<ten-task>
```

**Xong 8 bước trên là bạn hoàn thành 1 task.** Lặp lại cho task tiếp theo.

---

## 6. Lỗi Git thường gặp

| Lỗi hiện ra | Nghĩa | Cách sửa |
|---|---|---|
| `Permission denied (publickey)` | Chưa cài SSH key | Xem [01-cai-dat.md](01-cai-dat.md) Bước 6 |
| `Your branch is behind 'origin/main'` | Chưa pull | `git checkout main && git pull` rồi tạo lại nhánh |
| `CONFLICT (content): Merge conflict in ...` | 2 người sửa cùng 1 file | Xem mục 7 bên dưới |
| `error: failed to push some refs` | Nhánh trên GitHub có code mới hơn | `git pull --rebase` → sửa conflict → push lại |
| `nothing to commit, working tree clean` | Bạn chưa sửa file nào, hoặc đã commit rồi | Kiểm tra lại đã lưu file chưa (`Ctrl+S`) |
| `src refspec ... does not match any` | Gõ sai tên nhánh | Dùng `git push -u origin HEAD` thay vì gõ tên nhánh |
| `Updates were rejected because the remote contains work` | Trên GitHub có commit bạn chưa có | `git pull --rebase` rồi push lại |
| Push bị từ chối lên `main` | **Đúng rồi!** Không được push thẳng lên main | `git checkout -b feature/...` rồi push lại |
| `fatal: not a git repository` | Terminal đang ở sai thư mục | `cd "$HOME\Desktop\bus-ticketing"` |
| `LF will be replaced by CRLF` | Cảnh báo, **không phải lỗi** | Bỏ qua, không cần làm gì |

**Nguyên tắc: gặp lỗi thì ĐỪNG tự mò. Chụp màn hình → gửi nhóm chat.** Mò sai có thể làm mất code của người khác.

---

## 7. Khi bị Conflict

**Conflict** xảy ra khi bạn và người khác cùng sửa **một dòng trong một file**.

Git sẽ sửa file đó và chèn vào những đoạn như thế này:

```
<<<<<<< HEAD
    var token = GenerateJwt(user);        ← code của bạn
=======
    var jwt = CreateToken(user);          ← code của người kia
>>>>>>> main
```

**Cách sửa:**

1. Mở file đó trong VS Code — VS Code sẽ tô màu và hiện nút **"Accept Current"** / **"Accept Incoming"** / **"Accept Both"
2. **Gọi cho người kia** — quyết định giữ code nào (thường là kết hợp cả hai)
3. Xoá hết các dòng `<<<<<<<`, `=======`, `>>>>>>>`
4. Lưu file → `git add .` → `git commit -m "fix: giai quyet conflict"` → `git push`

> 💡 **Tránh conflict từ đầu:** luôn `git pull` trước khi bắt đầu, và **không sửa file của người khác**.

---

## 8. Definition of Ready — trước khi nhận task

Task **chỉ được nhận** khi có đủ 5 thứ. Thiếu 1 thứ → **chưa nhận**, báo Scrum Master.

- [ ] Mô tả rõ ràng, người khác đọc hiểu được
- [ ] Có estimate bằng giờ
- [ ] Có **1 người** nhận cụ thể (không phải "cả nhóm")
- [ ] Nếu cần cả FE và BE làm song song → **hợp đồng API đã có trong [`api-contract.md`](../api-contract.md)**
- [ ] Biết rõ nó phụ thuộc vào task nào khác (nếu có)

> **Vì sao?** Nhận task mơ hồ kiểu *"làm trang quản lý tuyến"* thì bạn mất 1–2 ngày đoán, làm xong mới biết hiểu sai, rồi làm lại. **5 phút làm rõ tiết kiệm 2 ngày làm lại.**

---

## 9. Definition of Done — trước khi đóng task

Task **chỉ được coi là XONG** khi qua hết. Không có "chắc là chạy được".

**Code**
- [ ] Build sạch (`Ctrl+Shift+B` → `build-backend`, hoặc `npm run build`)
- [ ] CI trên GitHub báo ✅ xanh
- [ ] Đã xoá `console.log` / code debug / `TODO` thừa

**Kiểm thử**
- [ ] Đã tự chạy thử và thấy nó hoạt động
- [ ] Đã thử **cả trường hợp lỗi** (nhập sai, thiếu dữ liệu), không chỉ trường hợp thành công

**Quy trình**
- [ ] Đã tạo Pull Request (không push thẳng lên `main`)
- [ ] Đã có 1 người approve và đã merge
- [ ] Thẻ task trên GitHub Projects đã chuyển sang **Done**

**An toàn**
- [ ] **KHÔNG** hardcode API key / mật khẩu / connection string vào code
- [ ] Nếu làm API mới → đã cập nhật [`api-contract.md`](../api-contract.md)

---

## 10. Bốn quy tắc không được vi phạm

### 🔴 1. Không push thẳng lên `main`
Mọi thay đổi phải qua Pull Request.

### 🔴 2. Không commit bí mật
Repo này **PUBLIC** — cả thế giới đọc được. Nếu lỡ commit API key, **xoá file cũng không cứu được**, phải **đổi key ngay**.

```csharp
var key = "sk_live_abc123";           // ❌ SAI
var key = config["MoMo:SecretKey"];   // ✅ ĐÚNG
```

- Code ở máy → dùng `dotnet user-secrets`
- Khi deploy → dùng Environment Variables

### 🔴 3. Đọc hợp đồng API trước khi code
Không ai viết code gọi API trước khi endpoint đó có trong [`api-contract.md`](../api-contract.md).
Muốn đổi API? **Sửa file đó trước** → báo người còn lại → rồi mới code.

### 🔴 4. Không sửa file của người khác
Cần dùng chung → hỏi trước. Riêng 4 file này **chỉ Hoàng được sửa**:
`.gitignore` · `global.json` · `.editorconfig` · `.vscode/` · `.github/`

---

## 11. Nhịp làm việc mỗi ngày

| Khi nào | Việc |
|---|---|
| **Mỗi sáng** | Daily Standup 15 phút — trả lời 3 câu (xem bên dưới) |
| **Cả ngày** | `git pull` → code → `git push` → PR → merge |
| **Cuối Sprint** | Sprint Review (demo cho mentor) + Retrospective |

**3 câu trong Daily Standup — ai cũng trả lời:**

1. Hôm qua tôi làm xong gì?
2. Hôm nay tôi làm gì?
3. Tôi có đang bị chặn không? (chờ API? chờ review? không hiểu task?)

> 🔴 **Bị chặn thì PHẢI nói ra.** Im lặng chịu đựng 3 ngày rồi mới báo = cả nhóm trễ theo. Đây là lý do standup tồn tại.

---

✅ **Đọc xong?** Sang [`04-sprint-1.md`](04-sprint-1.md) để biết Sprint 1 bạn làm file nào.
