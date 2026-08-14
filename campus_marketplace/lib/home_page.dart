import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/item.dart';
import 'models/favorites_model.dart';
import 'widgets/item_list_section.dart';
import 'favorites_page.dart';

// เปลี่ยนเป็น StatefulWidget เพื่อเก็บ _searchQuery ด้วย setState (Ephemeral State)
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Ephemeral State: ค่าคำค้นหาเก็บไว้ใน State ของหน้านี้หน้าเดียว
  // ไม่มีหน้าอื่น (เช่น FavoritesPage) ที่ต้องรู้ค่านี้ด้วย จึงไม่จำเป็นต้องเป็น App State
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // กรองรายการ catalog เฉพาะที่ title ตรงกับคำค้นหา (ไม่สนตัวพิมพ์เล็ก-ใหญ่)
    final filteredCatalog = catalog
        .where(
          (item) =>
              item.title.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Marketplace'),
        actions: [
          IconButton(
            icon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.favorite),
                // .watch ทำให้ตัวเลขนี้อัปเดตเองทุกครั้งที่ FavoritesModel เปลี่ยน ไม่ว่าจะเปลี่ยนจากจุดไหน
                Text(' ${context.watch<FavoritesModel>().itemCount}'),
              ],
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FavoritesPage()),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Box
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'ค้นหาสินค้า...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                // setState เพื่ออัปเดต _searchQuery และ rebuild หน้าจอ
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          // ส่ง filteredCatalog (รายการที่กรองแล้ว) ให้ ItemListSection
          Expanded(child: ItemListSection(catalog: filteredCatalog)),
        ],
      ),
    );
  }
}
