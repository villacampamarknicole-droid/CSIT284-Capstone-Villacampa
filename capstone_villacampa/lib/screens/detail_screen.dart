import 'package:flutter/material.dart';
import 'package:capstone_villacampa/models/items.dart';
import 'package:capstone_villacampa/services/database_service.dart';

class DetailScreen extends StatefulWidget {
  final Item item;

  const DetailScreen({super.key, required this.item});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final DatabaseService _db = DatabaseService();
  bool _isSaving = false;

  Future<void> _handleClaim() async {
    if (_isSaving) return;

    setState(() {
      _isSaving = true;
    });

    try {
      await _db.markItemAsClaimed(widget.item);
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item marked as claimed and moved to history!'),
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isSaving = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to claim item: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Chip(
              label: Text(widget.item.category),
              backgroundColor: Colors.blue.shade100,
            ),
            const SizedBox(height: 12),
            Text(
              widget.item.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Location Found/Lost: ${widget.item.location}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const Divider(height: 30),
            const Text(
              'Description:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(widget.item.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text(
              'Contact Information:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              widget.item.contact,
              style: const TextStyle(fontSize: 16, color: Colors.blue),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                onPressed: _isSaving ? null : _handleClaim,
                child: Text(_isSaving ? 'Claiming...' : 'Mark as Claimed'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}