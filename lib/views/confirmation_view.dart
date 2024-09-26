// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../core/assets.dart';
import '../models/booking.dart';
import '../models/workspace.dart';
import '../ui/components/bottomButton.dart';
import '../ui/components/icon_and_text_row.dart';
import '../ui/widgets/facilities_widget.dart';
import '../utlis/size.dart';

class ConfirmationView extends StatelessWidget {
  final Workspace workspace;
  final Booking booking;

  const ConfirmationView({required this.workspace, required this.booking});

  @override
  Widget build(BuildContext context) {

    String formattedDate = DateFormat('EEE d MMM yyyy').format(booking.date);
    String formattedStartTime = DateFormat('h:mma').format(booking.startTime).toUpperCase();  // toUpperCase() ensures PM/AM are in uppercase
    String formattedEndTime = DateFormat('h:mma').format(booking.endTime).toUpperCase();  // toUpperCase() ensures PM/AM are in uppercase

    debugPrint('${booking.date}');
    debugPrint('${booking.startTime}');
    debugPrint('${booking.endTime}');

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 32,),
            Image.asset(
              Assets.images.confirmed, // Ensure the image exists
              width: 200,
            ),
            SizedBox(height: 16,),
            Text('Succeed',
                style:const TextStyle(
                  color:Colors.black,
                  fontSize: 24,fontWeight:FontWeight.w600, )),
            Text('Your Booking is Confirmed',
                style:const TextStyle(
                  color:Colors.black54,
                  fontSize: 16,fontWeight:FontWeight.normal, )),
            SizedBox(height: 4,),
            Text(workspace.name,
                style:const TextStyle(
                  color:Colors.black,
                  fontSize: 18,fontWeight:FontWeight.w600, )),

            Text(workspace.location,
                style:const TextStyle(
                  color:Colors.black54,
                  fontSize: 14,fontWeight:FontWeight.normal, )),

            const SizedBox(height: 8),

            Text(
              formattedDate,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$formattedStartTime - $formattedEndTime',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 32),

            const SizedBox(height: 8,),
            const Align(
              alignment: Alignment.topLeft,
              child: Text('Facilities',
                  style:TextStyle(
                    color:Colors.black,
                    fontSize: 16, )),
            ),

            Flexible(child: FacilitiesWidget(facilities: workspace.amenities,)),
            const SizedBox(height: 16,),

            BottomButton(
              text:'Back To Home',
              onTap: () {
                // Handle button press action
                debugPrint("Check Availability Button pressed");
                context.go('/home');
              },
            ),

          ],
        ),
      ),
    );
  }
}
