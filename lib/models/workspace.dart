class Workspace {
  final String id;
  final String name;
  final String location;
  final int capacity;
  final List<String> amenities;

  Workspace({
    required this.id,
    required this.name,
    required this.location,
    required this.capacity,
    required this.amenities,
  });

  factory Workspace.fromMap(Map<String, dynamic> data, String documentId) {
    return Workspace(
      id: documentId,
      name: data['name'],
      location: data['location'],
      capacity: data['capacity'],
      amenities: List<String>.from(data['amenities']),
    );
  }
}
