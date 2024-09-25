class Workspace {
  final String id;
  final String name;
  final String img;
  final String location;
  final String openingHours;
  final int capacity;
  final int spaceId;
  final List<String> amenities;

  Workspace({
    required this.id,
    required this.name,
    required this.location,
    required this.capacity,
    required this.amenities,
     required this.img,
    required this.spaceId,
    required this.openingHours,

  });

  factory Workspace.fromMap(Map<String, dynamic> data, String documentId) {
    return Workspace(
      id: documentId,
      name: data['name'],
      location: data['location'],
      capacity: data['capacity'],
      openingHours: data['opening_hours'],
       img: data['img'],
       spaceId: data['id'],
      amenities: List<String>.from(data['amenities']),
    );
  }
}
