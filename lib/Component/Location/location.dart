// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// class MapLocationPage extends StatefulWidget {
//   const MapLocationPage({Key? key}) : super(key: key);

//   @override
//   _MapLocationPageState createState() => _MapLocationPageState();
// }

// class _MapLocationPageState extends State<MapLocationPage> {
//   final CameraPosition _initialCameraPosition = CameraPosition(
//     target: LatLng(-2.064444, 29.784722), // Biryogo, Rwanda
//     zoom: 15.0,
//   );

//   GoogleMapController? _mapController;
//   LatLng? _currentPosition;

//   // Function to request location permission and get current location
//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission = await Geolocator.checkPermission();

//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Location services are disabled. Please enable the services')),
//       );
//       return;
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Location permissions are denied')),
//         );
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Location permissions are permanently denied, we cannot request permissions.')),
//       );
//       return;
//     }

//     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//     setState(() {
//       _currentPosition = LatLng(position.latitude, position.longitude);
//     });

//     if (_mapController != null) {
//       _mapController!.animateCamera(
//         CameraUpdate.newLatLng(_currentPosition!),
//       );
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation(); // Get current location on app launch
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Biryogo'),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             initialCameraPosition: _initialCameraPosition,
//             onMapCreated: (GoogleMapController controller) {
//               _mapController = controller;
//               _mapController!.setMapStyle(''); // Optionally, set your map style here
//             },
//             myLocationEnabled: true, // Show user's location if available
//             zoomControlsEnabled: true,
//             markers: (_currentPosition != null)
//                 ? {
//                     // Marker for Biryogo
//                     Marker(
//                       markerId: MarkerId('biryogo'),
//                       position: LatLng(-2.064444, 29.784722), // Biryogo coordinates
//                       infoWindow: InfoWindow(
//                         title: 'Biryogo, Rwanda',
//                       ),
//                     ),
//                     // Marker for current location
//                     Marker(
//                       markerId: MarkerId('current_location'),
//                       position: _currentPosition!,
//                       infoWindow: InfoWindow(
//                         title: 'Your Location',
//                       ),
//                     ),
//                   }
//                 : {},
//             gestureRecognizers: {},
//           ),
//           Align(
//             alignment: Alignment.bottomRight,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: FloatingActionButton(
//                 onPressed: () async {
//                   if (_currentPosition != null) {
//                     _mapController?.animateCamera(CameraUpdate.newCameraPosition(
//                       CameraPosition(
//                         target: _currentPosition!,
//                         zoom: 17.0, // Adjust zoom level as needed
//                       ),
//                     ));
//                   } else {
//                     // Handle case where location is not available
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text('Unable to determine your location.'),
//                       ),
//                     );
//                   }
//                 },
//                 child: Icon(Icons.my_location),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
