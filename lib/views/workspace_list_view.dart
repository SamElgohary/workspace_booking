import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/workspace_provider.dart';
import '../widgets/workspace_card.dart';
import '../models/workspace.dart';
import 'package:go_router/go_router.dart';

class WorkspaceListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workspaceListAsync = ref.watch(workspaceListProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Available Workspaces')),
      body: workspaceListAsync.when(
        data: (workspaces) {
          return ListView.builder(
            itemCount: workspaces.length,
            itemBuilder: (context, index) {
              Workspace workspace = workspaces[index];
              return GestureDetector(
                onTap: () {
                  context.go(
                    '/home/workspace/${workspace.id}',
                    extra: workspace,
                  );
                },
                child: WorkspaceCard(workspace: workspace),
              );
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
