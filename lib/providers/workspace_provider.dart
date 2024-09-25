import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/workspace.dart';
import '../services/firebase_service.dart';

final firebaseServiceProvider = Provider<FirebaseService>((ref) {
  return FirebaseService();
});

final workspaceListProvider = FutureProvider<List<Workspace>>((ref) async {
  final service = ref.read(firebaseServiceProvider);
  try {
    final workspaces = await service.getWorkspaces();
    print('Workspaces loaded: $workspaces'); // Debug print
    return workspaces;
  } catch (e) {
    print('Error fetching workspaces: $e'); // Error print
    throw Exception('Failed to load workspaces');
  }
});