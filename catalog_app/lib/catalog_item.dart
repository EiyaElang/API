class CatalogItem {
  final int id;
  String name;

  CatalogItem({required this.id, required this.name});

  // Untuk mengubah dari JSON ke object CatalogItem
  factory CatalogItem.fromJson(Map<String, dynamic> json) {
    return CatalogItem(
      id: json['id'],
      name: json['name'],
    );
  }

  // Untuk mengubah CatalogItem menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
