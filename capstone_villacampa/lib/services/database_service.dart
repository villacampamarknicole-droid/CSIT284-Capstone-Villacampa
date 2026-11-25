import 'package:firebase_database/firebase_database.dart';
import 'package:capstone_villacampa/models/items.dart';

class DatabaseService {
  final DatabaseReference _db = FirebaseDatabase.instance.ref();

  DatabaseReference get _itemsRef => _db.child('items');
  DatabaseReference get _claimedItemsRef => _db.child('claimed_items');

  Stream<List<Item>> watchItems() {
    return _itemsRef.onValue.map((event) {
      final raw = event.snapshot.value;
      if (raw == null) return <Item>[];

      final List<Item> items = [];
      if (raw is Map) {
        raw.forEach((key, value) {
          if (value is Map) {
            final map = Map<String, dynamic>.from(value);
            items.add(Item.fromMap(key.toString(), map));
          }
        });
      } else if (raw is List) {
        for (var i = 0; i < raw.length; i++) {
          final value = raw[i];
          if (value is Map) {
            final map = Map<String, dynamic>.from(value);
            items.add(Item.fromMap(i.toString(), map));
          }
        }
      }

      return items.where((item) => !item.isClaimed).toList();
    });
  }

  Stream<List<Item>> watchClaimedItems() {
    return _claimedItemsRef.onValue.map((event) {
      final raw = event.snapshot.value;
      if (raw == null) return <Item>[];

      final List<Item> claimed = [];
      if (raw is Map) {
        raw.forEach((key, value) {
          if (value is Map) {
            final map = Map<String, dynamic>.from(value);
            claimed.add(Item.fromMap(key.toString(), map));
          }
        });
      } else if (raw is List) {
        for (var i = 0; i < raw.length; i++) {
          final value = raw[i];
          if (value is Map) {
            final map = Map<String, dynamic>.from(value);
            claimed.add(Item.fromMap(i.toString(), map));
          }
        }
      }

      return claimed;
    });
  }

  Future<void> addItem(Item item) async {
    await _itemsRef.child(item.id).set(item.toMap());
  }

  Future<void> markItemAsClaimed(Item item) async {
    final claimedMap = item.toMap();
    claimedMap['isClaimed'] = true;
    claimedMap['claimedAt'] = DateTime.now().toIso8601String();

    await _claimedItemsRef.child(item.id).set(claimedMap);
    await _itemsRef.child(item.id).remove();
  }

  Future<void> seedInitialItems(List<Item> initialItems) async {
    final snapshot = await _itemsRef.get();
    if (snapshot.exists) return;

    for (final item in initialItems) {
      await _itemsRef.child(item.id).set(item.toMap());
    }
  }
}