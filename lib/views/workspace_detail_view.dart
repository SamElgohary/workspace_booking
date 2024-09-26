import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/workspace.dart';
import 'package:go_router/go_router.dart';

import '../ui/components/icon_and_text_row.dart';
import '../ui/widgets/facilities_widget.dart';
import '../utlis/colors.dart';
import '../utlis/size.dart';

class WorkspaceDetailView extends StatelessWidget {
  final Workspace workspace;

  const WorkspaceDetailView({super.key, required this.workspace});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(workspace.name,style: const TextStyle(fontSize: 18),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            // Handle back action
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.ios_share,),
            onPressed: () {

              debugPrint('Share button pressed');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical:16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal:16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: workspace.img,
                    imageBuilder: (context, imageProvider) => Container(
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(8),),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                  const SizedBox(height: 8,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:2.0),
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
                        horizontalSpace: 0,
                      ),
                      IconAndTextRow(
                        icon: Icons.star,
                        iconColor: Colors.yellow,
                        text: workspace.rate,
                      )
                    ],
                  ),
                  const SizedBox(height: 8,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:2.0),
                    child: Text(workspace.price,
                        style:const TextStyle(
                            color:primaryColor,
                            fontSize: 16,fontWeight: FontWeight.bold )),
                  ),
                  const SizedBox(height: 24,),
                  Center(
                    child: Container(
                      width:  ScreenSize.width(context) / 1.3,
                      padding: const EdgeInsets.symmetric(horizontal:8.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color: Colors.blueGrey,
                          width: 2.0,
                        ),
                      ),
                      // Adjust based on your needs
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 16),
                          const Text(
                            "OPENING HOURS",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),

                          Padding(
                            padding: const EdgeInsets.only(bottom:16.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(16.0),  // Adjust the radius value as needed
                                  bottomLeft: Radius.circular(16.0),
                                ),),
                              width:  (ScreenSize.width(context) / 1.3) - 64 ,

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 8,),
                                  Text(
                                    "SUNDAY – THURSDAY",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    workspace.openingHours,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                  const SizedBox(height: 16), // Spacing between sections
                                  Text(
                                    "FRIDAY",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "01:00PM - 10:00pm",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                          ),


                        ],
                      ),
                    ),),
                  const SizedBox(height: 24,),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal:2.0),
                    child: Text('Facilities',
                        style:TextStyle(
                          color:Colors.black,
                          fontSize: 16,fontWeight:FontWeight.w600, )),
                  ),
                ],
              ),
            ),

            Expanded(child: FacilitiesWidget(facilities: workspace.amenities,)),


          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical:8.0),
        width:  ScreenSize.width(context) - 32,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8.0),  // Adjust the radius value as needed
            topRight: Radius.circular(8.0),
          ),
          border: Border.all(
            color: Colors.blueGrey,
            width: 2.0,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            // Handle button press action
            debugPrint("Check Availability Button pressed");
            context.go(
              '/home/workspace/${workspace.id}/booking',
              extra: workspace,
            );
          },
          child: const Text(
            'Check Availability',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
