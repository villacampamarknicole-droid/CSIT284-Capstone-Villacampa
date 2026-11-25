import 'package:flutter/material.dart';
import '../models/items.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final VoidCallback onTap;

  const ItemCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: item.isClaimed ? Colors.grey : Colors.blue,
          child: Icon(
            item.isClaimed ? Icons.check : Icons.search,
            color: Colors.white,
          ),
        ),
        title: Text(
          item.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: item.isClaimed ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text("${item.category} • ${item.location}\nContact: ${item.contact}"),
        isThreeLine: true,
        trailing: item.isClaimed
            ? const Chip(label: Text('Claimed', style: TextStyle(fontSize: 10)))
            : const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}