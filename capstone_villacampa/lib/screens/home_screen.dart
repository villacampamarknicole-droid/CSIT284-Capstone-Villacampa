import 'package:flutter/material.dart';
import 'package:capstone_villacampa/data/dummy_data.dart';
import 'package:capstone_villacampa/models/items.dart';
import 'package:capstone_villacampa/screens/add_item_screen.dart';
import 'package:capstone_villacampa/screens/claimed_items_history.dart';
import 'package:capstone_villacampa/screens/detail_screen.dart';
import 'package:capstone_villacampa/services/database_service.dart';
import 'package:capstone_villacampa/widgets/item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService _db = DatabaseService();

  @override
  void initState() {
    super.initState();
    _db.seedInitialItems(dummyItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lost & Found'),
        actions: [
          IconButton(
            tooltip: 'Claimed History',
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClaimedHistoryScreen(),
                ),
              );
            },
          ),
          IconButton(
            tooltip: 'Add Item',
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddItemScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Item>>(
        stream: _db.watchItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final items = snapshot.data ?? [];
          if (items.isEmpty) {
            return const Center(child: Text('No active lost or found items.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ItemCard(
                item: item,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(item: item),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}