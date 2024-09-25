import 'package:flutter/material.dart';
import '../../models/workspace.dart';
import '../../utlis/colors.dart';
import '../components/icon_and_text_row.dart';
import 'package:cached_network_image/cached_network_image.dart';

class WorkspaceCard extends StatelessWidget {
  final Workspace workspace;

  WorkspaceCard({required this.workspace});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:2.0),
      child: Card(
        child:  Container(
          height: 290,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            CachedNetworkImage(
              imageUrl: workspace.img,
              imageBuilder: (context, imageProvider) => Container(
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),  // Adjust the radius value as needed
                    topRight: Radius.circular(8.0),
                  ),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
             const SizedBox(height: 8,),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal:8.0),
               child: Text(workspace.name,
                   style:const TextStyle(
                     color:Colors.black,
                     fontSize: 16,fontWeight:FontWeight.w600, )),
             ),
              const SizedBox(height: 4,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconAndTextRow(
                    icon: Icons.location_on,
                    text: workspace.location,
                  ),
                  IconAndTextRow(
                    icon: Icons.star,
                    iconColor: Colors.yellow,
                    text: workspace.rate,
                  )
                ],
              ),
              const SizedBox(height: 2,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:10.0),
                child: Row(
                  children: [
                    const Text('Available Places: ',
                        style:TextStyle(
                          color:Colors.black54,
                          fontSize: 14,fontWeight:FontWeight.normal,)),
                    Text(workspace.capacity.toString(),
                        style:const TextStyle(
                          color:Colors.black87,
                          fontSize: 14,fontWeight:FontWeight.bold,)),
                  ],
                )
              ),
              const SizedBox(height: 8,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0),
                child: Text(workspace.price,
                    style:const TextStyle(
                      color:primaryColor,
                      fontSize: 16,fontWeight: FontWeight.bold )),
              ),
          ],),
        ),
      ),
    );
  }
}
