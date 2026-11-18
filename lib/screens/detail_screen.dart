import 'package:flutter/material.dart';
import 'package:capstone_villacampa/models/items.dart';

class DetailScreen extends StatefulWidget {
  final Item item;

  const DetailScreen({Key? key, required this.item}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
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
              "Location Found/Lost: ${widget.item.location}",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const Divider(height: 30),
            const Text(
              "Description:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(widget.item.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text(
              "Contact Information:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(widget.item.contact, style: const TextStyle(fontSize: 16, color: Colors.blue)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.item.isClaimed ? Colors.grey : Colors.green,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    widget.item.isClaimed = !widget.item.isClaimed;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(widget.item.isClaimed
                          ? 'Item marked as claimed!'
                          : 'Item marked as active.'),
                    ),
                  );
                },
                child: Text(widget.item.isClaimed ? 'Mark as Unclaimed' : 'Mark as Claimed'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}