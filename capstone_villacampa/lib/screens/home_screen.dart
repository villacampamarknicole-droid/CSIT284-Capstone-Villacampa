import 'package:flutter/material.dart';
import 'package:capstone_villacampa/models/items.dart';
import 'package:capstone_villacampa/screens/add_item_screen.dart';
import 'package:capstone_villacampa/screens/detail_screen.dart';
import 'package:capstone_villacampa/services/database_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService _db = DatabaseService();

  final List<Item> _initialItems = [
    Item(
      id: '1',
      title: 'Casio Scientific Calculator',
      description: 'Black scientific calculator with slide cover.',
      location: 'Building A, Room 302',
      contact: 'student1@school.edu',
      category: 'Electronics',
      isClaimed: false,
    ),
    Item(
      id: '2',
      title: 'Blue Hydro Flask Water Bottle',
      description: 'Insulated blue bottle with a few stickers.',
      location: 'Cafeteria',
      contact: 'student2@school.edu',
      category: 'Accessories',
      isClaimed: false,
    ),
    Item(
      id: '3',
      title: 'Calculus 8th Edition Textbook',
      description: 'Hardcover math textbook with highlighted pages.',
      location: 'Library 2nd Floor',
      contact: 'student3@school.edu',
      category: 'Books',
      isClaimed: false,
    ),
    Item(
      id: '4',
      title: 'Black Leather Wallet',
      description: 'Bifold black wallet found near the lounge.',
      location: 'Student Union',
      contact: 'student4@school.edu',
      category: 'Personal',
      isClaimed: false,
    ),
    Item(
      id: '5',
      title: 'Wireless Earbuds Case (White)',
      description: 'White charging case left on a lab desk.',
      location: 'Computer Lab 1',
      contact: 'student5@school.edu',
      category: 'Electronics',
      isClaimed: false,
    ),
    Item(
      id: '6',
      title: 'Red Umbrella',
      description: 'Compact red umbrella with wooden handle.',
      location: 'Gymnasium Entrance',
      contact: 'student6@school.edu',
      category: 'Accessories',
      isClaimed: false,
    ),
    Item(
      id: '7',
      title: 'Pencil Case with Pens',
      description: 'Zippered pouch containing pens, highlighters, and ruler.',
      location: 'Science Hall',
      contact: 'student7@school.edu',
      category: 'Stationery',
      isClaimed: false,
    ),
    Item(
      id: '8',
      title: 'Silver Dorm Room Keys',
      description: 'Two silver keys on a small lanyard.',
      location: 'Dormitory Lobby',
      contact: 'student8@school.edu',
      category: 'Keys',
      isClaimed: false,
    ),
    Item(
      id: '9',
      title: 'Black Jacket (Size M)',
      description: 'Zip-up black jacket left on a back row seat.',
      location: 'Auditorium',
      contact: 'student9@school.edu',
      category: 'Clothing',
      isClaimed: false,
    ),
    Item(
      id: '10',
      title: 'Chemistry Lab Goggles',
      description: 'Clear safety goggles in a plastic sleeve.',
      location: 'Chemistry Lab',
      contact: 'student10@school.edu',
      category: 'Personal',
      isClaimed: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _db.seedInitialItems(_initialItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Lost & Found'),
        actions: [
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
            return const Center(child: Text('No items found.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(
                      item.isClaimed ? Icons.check : Icons.search,
                    ),
                  ),
                  title: Text(item.title),
                  subtitle: Text(
                    '${item.category} • ${item.location}\nContact: ${item.contact}',
                  ),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (item.isClaimed)
                        const Padding(
                          padding: EdgeInsets.only(right: 6),
                          child: Chip(label: Text('Claimed')),
                        ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(item: item),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}