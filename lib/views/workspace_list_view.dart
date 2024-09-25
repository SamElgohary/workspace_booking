import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/workspace_provider.dart';
import '../models/workspace.dart';
import 'package:go_router/go_router.dart';

import '../ui/widgets/workspace_card.dart';

class WorkspaceListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workspaceListAsync = ref.watch(workspaceListProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(  toolbarHeight:.1,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:12.0,vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Hi Sara, Where You',style:TextStyle(color:Colors.black,fontSize: 18)),
            const Text('Wanna Work Today?',style:TextStyle(color:Colors.black87,fontSize: 16,fontWeight:  FontWeight.w600, )),
            const SizedBox(height: 16,),
            const SizedBox(
              height: 40,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search by name, location',
                  hintStyle: TextStyle(fontSize: 14),
                  filled: true,               // Enable filling
                  fillColor: Colors.white,     // Set background color to white
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide.none,  // No border outline
                  ),// No border
                  prefixIcon: Icon(Icons.search,color: Colors.grey,size: 16,), // Add search icon
                ),),
            ),

            const SizedBox(height: 24,),

            const Text('Available Places',style:TextStyle(color:Colors.black87,fontSize: 16,fontWeight:  FontWeight.w600, )),

            const SizedBox(height: 16,),

            Expanded(child:   workspaceListAsync.when(
              data: (workspaces) {
                debugPrint('workspaces  length ${workspaces.length}');
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
            ),)
          ],
        ),
      )
    );
  }
}
