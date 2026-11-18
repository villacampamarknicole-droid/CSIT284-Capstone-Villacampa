class Item {
  final String id;
  final String title;
  final String description;
  final String location;
  final String contact;
  final String category;
  bool isClaimed;

  Item({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.contact,
    required this.category,
    this.isClaimed = false,
  });
}