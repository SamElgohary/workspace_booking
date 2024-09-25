import 'package:flutter/material.dart';
import '../models/workspace.dart';

class WorkspaceCard extends StatelessWidget {
  final Workspace workspace;

  WorkspaceCard({required this.workspace});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(workspace.name),
        subtitle: Text('${workspace.location} • Capacity: ${workspace.capacity}'),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }
}
