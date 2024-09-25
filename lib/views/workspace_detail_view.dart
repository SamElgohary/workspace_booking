import 'package:flutter/material.dart';
import '../models/workspace.dart';
import 'package:go_router/go_router.dart';

class WorkspaceDetailView extends StatelessWidget {
  final Workspace workspace;

  WorkspaceDetailView({required this.workspace});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(workspace.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              workspace.location,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text('Capacity: ${workspace.capacity} people'),
            SizedBox(height: 10),
            Text('Amenities: ${workspace.amenities.join(', ')}'),
            Spacer(),
            ElevatedButton(
              child: Text('Book Workspace'),
              onPressed: () {
                context.go(
                  '/home/workspace/${workspace.id}/booking',
                  extra: workspace,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
