import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/workspace.dart';
import 'package:go_router/go_router.dart';

import '../ui/components/bottomButton.dart';
import '../ui/components/icon_and_text_row.dart';
import '../ui/widgets/availability_line.dart';
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: workspace.img,
                imageBuilder: (context, imageProvider) => Container(
                  height: 200,
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

              const Padding(
                padding: EdgeInsets.symmetric(horizontal:2.0),
                child: Text('Facilities',
                    style:TextStyle(
                      color:Colors.black,
                      fontSize: 16,fontWeight:FontWeight.w600, )),
              ),
              const SizedBox(height: 8,),
              FacilitiesWidget(facilities: workspace.amenities,),
              const SizedBox(height: 24,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal:2.0),
                child: Text('Working Hours',
                    style:TextStyle(
                      color:Colors.black,
                      fontSize: 16,fontWeight:FontWeight.w600, )),
              ),
              const SizedBox(height: 8,),
              Column(
                children: [
                  // Day Headers
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text("Sun", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
                      Text("Mon", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
                      Text("Tue", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
                      Text("Wed", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
                      Text("Thu", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
                      Text("Fri", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
                      Text("Sat", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 8), // Space between headers and lines

                  // Availability Lines
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AvailabilityLine(color:Colors.red),
                      AvailabilityLine(color:Colors.orange),
                      AvailabilityLine(color:Colors.orange),
                      AvailabilityLine(color:Colors.orange),
                      AvailabilityLine(color:Colors.red),
                      AvailabilityLine(color:Colors.grey),
                      AvailabilityLine(color:Colors.orange),
                    ],
                  ),
                  SizedBox(height: 8), // Space between lines and time slots

                  // Time Slots
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (index) => "08:00AM\n09:00PM").map((timeSlot) {
              return SizedBox(
                width: 40,
                  child: Text(timeSlot, style: TextStyle(color: Colors.black87,fontSize: 9),));
            }).toList(), // Convert the generated list into a List of widgets
          ),

                  const SizedBox(height: 32,),
                  BottomButton(
                    text:'Check Availability',
                    onTap: () {
                      // Handle button press action
                      debugPrint("Check Availability Button pressed");
                      context.go(
                        '/home/workspace/${workspace.id}/booking',
                        extra: workspace,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

    );
  }
}
