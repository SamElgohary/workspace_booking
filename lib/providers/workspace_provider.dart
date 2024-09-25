import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/workspace.dart';
import '../services/firebase_service.dart';

final firebaseServiceProvider = Provider<FirebaseService>((ref) {
  return FirebaseService();
});

final workspaceListProvider = FutureProvider<List<Workspace>>((ref) async {
  final service = ref.watch(firebaseServiceProvider);
  return service.getWorkspaces();
});
