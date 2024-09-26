// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/assets.dart';
import '../models/booking.dart';
import '../models/workspace.dart';
import '../ui/components/icon_and_text_row.dart';
import '../ui/widgets/facilities_widget.dart';
import '../utlis/size.dart';

class ConfirmationView extends StatelessWidget {
  final Workspace workspace;
  final Booking booking;

  const ConfirmationView({required this.workspace, required this.booking});

  @override
  Widget build(BuildContext context) {

    String formattedDate = DateFormat('yyyy-MM-dd').format(booking.date);
    String formattedStartTime = DateFormat('h:mma').format(booking.startTime).toUpperCase();  // toUpperCase() ensures PM/AM are in uppercase
    String formattedEndTime = DateFormat('h:mma').format(booking.endTime).toUpperCase();  // toUpperCase() ensures PM/AM are in uppercase

    debugPrint('${booking.date}');
    debugPrint('${booking.startTime}');
    debugPrint('${booking.endTime}');

    return Scaffold(
      appBar: AppBar(title: Text('Booking Confirmed'),backgroundColor: Colors.grey[50],),
      backgroundColor: Colors.grey[50],
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                Assets.images.confirmed, // Ensure the image exists
                width: 200,
              ),
            ),
            SizedBox(height: 16,),
            Center(
              child: Text('Succeed',
                  style:const TextStyle(
                    color:Colors.black,
                    fontSize: 24,fontWeight:FontWeight.w600, )),
            ),
            Center(
              child: Text('Your Booking is Confirmed',
                  style:const TextStyle(
                    color:Colors.black54,
                    fontSize: 16,fontWeight:FontWeight.normal, )),
            ),

            const SizedBox(height: 24,),
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal:2.0),
              child: Text('Facilities',
                  style:TextStyle(
                    color:Colors.black,
                    fontSize: 16, )),
            ),
            Expanded(child: FacilitiesWidget(facilities: workspace.amenities,)),
            const SizedBox(height: 16,),


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
                      "Booking Details",
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
                            const SizedBox(height: 32,),
                            Text(
                              formattedDate,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
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
                          ],
                        ),
                      ),
                    ),


                  ],
                ),
              ),),
          ],
        ),
      ),
    );
  }
}
