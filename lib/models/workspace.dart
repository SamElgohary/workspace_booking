class Workspace {
  final String id;
  final String name;
  final String img;
  final String location;
  final String rate;
  final String openingHours;
  final String price;
  final int capacity;
  final int spaceId;
  final List<String> amenities;

  Workspace({
    required this.id,
    required this.name,
    required this.location,
    required this.capacity,
    required this.price,
    required this.rate,
    required this.amenities,
     required this.img,
    required this.spaceId,
    required this.openingHours,

  });

  factory Workspace.fromMap(Map<String, dynamic> data, String documentId) {
    return Workspace(
      id: documentId,
      name: data['name'] ?? '',
      rate: data['rate'] ?? '',
      price: data['price'] ?? '',
      location: data['location'] ?? '',
      capacity: data['capacity'] ?? 0,
      openingHours: data['opening_hours'] ?? '',
       img: data['img'] ?? '',
       spaceId: data['id'] ?? 0,
      amenities: List<String>.from(data['amenities']),
    );
  }
}
