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

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'location': location,
      'contact': contact,
      'category': category,
      'isClaimed': isClaimed,
    };
  }

  factory Item.fromMap(String id, Map<dynamic, dynamic> map) {
    return Item(
      id: id,
      title: map['title']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      location: map['location']?.toString() ?? '',
      contact: map['contact']?.toString() ?? '',
      category: map['category']?.toString() ?? '',
      isClaimed: map['isClaimed'] == true,
    );
  }
}