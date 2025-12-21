import 'package:flutter/material.dart';

class UsersContent extends StatelessWidget {
  const UsersContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Quản Lý Người Dùng', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text('Thêm Người Dùng'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 8)],
            ),
            child: DataTable(
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Tên')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Loại Tài Khoản')),
                DataColumn(label: Text('Vai Trò')),
                DataColumn(label: Text('Hành Động')),
              ],
              rows: [
                _buildUserRow('U001', 'Nguyễn Văn A', 'nguyenvana@email.com', 'VIP', 'Admin'),
                _buildUserRow('U002', 'Trần Thị B', 'tranthib@email.com', 'FREE', 'User'),
                _buildUserRow('U003', 'Lê Văn C', 'levanc@email.com', 'VIP', 'Moderator'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildUserRow(String id, String name, String email, String accountType, String role) {
    return DataRow(cells: [
      DataCell(Text(id)),
      DataCell(Text(name)),
      DataCell(Text(email)),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: accountType == 'VIP' ? Colors.purple.shade100 : Colors.blue.shade100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            accountType,
            style: TextStyle(
              color: accountType == 'VIP' ? Colors.purple : Colors.blue,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            role,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade800),
          ),
        ),
      ),
      DataCell(
        Row(
          children: [
            IconButton(icon: const Icon(Icons.edit, size: 18), onPressed: () {}),
          ],
        ),
      ),
    ]);
  }
}
