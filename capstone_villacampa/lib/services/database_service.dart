import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:capstone_villacampa/models/items.dart';

class DatabaseService {
  final DatabaseReference _itemsRef = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL:
        'https://capstone-32782-default-rtdb.asia-southeast1.firebasedatabase.app',
  ).ref('items');

  Stream<List<Item>> watchItems() {
    return _itemsRef.onValue.map((event) {
      final value = event.snapshot.value;
      if (value == null) {
        return <Item>[];
      }

      final items = <Item>[];

      if (value is Map) {
        value.forEach((key, rawData) {
          if (rawData is Map) {
            items.add(Item.fromMap(key.toString(), rawData));
          }
        });
      } else if (value is List) {
        for (var i = 0; i < value.length; i++) {
          final rawData = value[i];
          if (rawData is Map) {
            items.add(Item.fromMap(i.toString(), rawData));
          }
        }
      }

      items.sort((a, b) {
        final intA = int.tryParse(a.id);
        final intB = int.tryParse(b.id);
        if (intA != null && intB != null) {
          return intA.compareTo(intB);
        }
        return a.id.compareTo(b.id);
      });

      return items;
    });
  }

  Future<void> addItem(Item item) async {
    final newRef =
        item.id.isNotEmpty ? _itemsRef.child(item.id) : _itemsRef.push();
    await newRef.set(item.toMap());
  }

  Future<void> updateItem(Item item) async {
    await _itemsRef.child(item.id).update(item.toMap());
  }

  Future<void> setClaimed(String itemId, bool isClaimed) async {
    await _itemsRef.child(itemId).update({'isClaimed': isClaimed});
  }

  Future<void> deleteItem(String itemId) async {
    await _itemsRef.child(itemId).remove();
  }

  Future<void> seedInitialItems(List<Item> initialItems) async {
    try {
      final snapshot = await _itemsRef.get();
      if (snapshot.exists && snapshot.value != null) {
        return;
      }
      final Map<String, dynamic> payload = {
        for (final item in initialItems) item.id: item.toMap(),
      };
      await _itemsRef.set(payload);
    } catch (e) {
      print('Seed error: $e');
    }
  }
}