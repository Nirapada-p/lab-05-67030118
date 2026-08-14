# Notes — โจทย์ที่ 1: Search Box

## การตัดสินใจเลือก State Management

### คำค้นหา (_searchQuery)  **Ephemeral State**

**เหตุผล:**
คำค้นหาเป็นข้อมูลที่ใช้แค่ **ภายในหน้า Home เพียงหน้าเดียว** เท่านั้น
ไม่มีหน้าอื่นในแอป (เช่น FavoritesPage) ที่จำเป็นต้องรู้หรือใช้ค่านี้ร่วมกัน

ดังนั้น การใช้ **`setState` ธรรมดา** จึงเป็นเครื่องมือที่เบาที่สุดและเพียงพอสำหรับงานนี้
ไม่จำเป็นต้อง "ยก" state ขึ้นไปเป็น App State ผ่าน Provider ซึ่งจะเพิ่ม complexity โดยไม่จำเป็น

| เกณฑ์ | คำตอบ |
|---|---|
| หน้าอื่นต้องรู้ค่านี้ด้วยไหม? | ? ไม่มี |
| ค่ายังคงอยู่หลัง navigate ออกจากหน้าไหม? | ? ไม่จำเป็น (reset เมื่อกลับมาก็ ok) |
| ประเภท State | ? Ephemeral State (setState) |

## การเปลี่ยนแปลงที่ทำ

1. **home_page.dart** — เปลี่ยน StatelessWidget  StatefulWidget
   - เพิ่ม String _searchQuery = '' เป็น instance variable
   - เพิ่ม TextField พร้อม onChanged ที่เรียก setState
   - กรอง catalog ด้วย .where(...) ก่อนส่งให้ ItemListSection

2. **widgets/item_list_section.dart** — ลบ shrinkWrap: true และ NeverScrollableScrollPhysics
   - เพราะตอนนี้ ItemListSection ถูกห่อด้วย Expanded ใน Column
     จึงให้ ListView จัดการ scroll เองได้ตามปกติ
