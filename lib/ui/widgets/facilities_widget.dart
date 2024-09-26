import 'package:flutter/material.dart';

class FacilitiesWidget extends StatelessWidget {
  // Define your string array
  final List<String> facilities;

   const FacilitiesWidget({super.key, required this.facilities});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          spacing: 4.0, // spacing between items
          children: facilities.map((facility) => buildFacilityItem(facility)).toList(),
        ),
      ),
    );
  }

  // Helper method to map string to icon
  Widget buildFacilityItem(String facility) {
    return  Container(
      padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical:4.0,),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(32),),
      ),
      child: Text(
        facility,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 14, color: Colors.black),
      ),
    );
  }
}

