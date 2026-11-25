import 'package:flutter/material.dart';
import 'package:capstone_villacampa/models/items.dart';
import 'package:capstone_villacampa/services/database_service.dart';

class ClaimedHistoryScreen extends StatelessWidget {
  ClaimedHistoryScreen({super.key});

  final DatabaseService _db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Claimed History'),
      ),
      body: StreamBuilder<List<Item>>(
        stream: _db.watchClaimedItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final claimedItems = snapshot.data ?? [];
          if (claimedItems.isEmpty) {
            return const Center(child: Text('No claimed items yet.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: claimedItems.length,
            itemBuilder: (context, index) {
              final item = claimedItems[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.history),
                  ),
                  title: Text(item.title),
                  subtitle: Text(
                    '${item.category} • ${item.location}\nContact: ${item.contact}',
                  ),
                  isThreeLine: true,
                  trailing: const Chip(label: Text('Claimed')),
                ),
              );
            },
          );
        },
      ),
    );
  }
}