import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LiveTrackingScreen extends StatefulWidget {
  const LiveTrackingScreen({super.key});

  @override
  State<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends State<LiveTrackingScreen> {
  late GoogleMapController mapController;
  LatLng? bodyguardPosition;
  BitmapDescriptor? bodyguardIcon;

  @override
  void initState() {
    super.initState();
    _loadCustomMarker();
    _listenToLocationUpdates();
  }

  void _loadCustomMarker() async {
    bodyguardIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      'lib/assets/bodyguard_marker.png',
    );
    setState(() {});
  }

  void _listenToLocationUpdates() {
    FirebaseDatabase.instance.ref("locations/bodyguard123").onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        setState(() {
          bodyguardPosition = LatLng(
            (data['latitude'] as num).toDouble(),
            (data['longitude'] as num).toDouble(),
          );
        });

        if (mapController != null && bodyguardPosition != null) {
          mapController.animateCamera(
            CameraUpdate.newLatLng(bodyguardPosition!),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          bodyguardPosition == null || bodyguardIcon == null
              ? const Center(child: CircularProgressIndicator())
              : GoogleMap(
                  onMapCreated: (controller) => mapController = controller,
                  initialCameraPosition: CameraPosition(
                    target: bodyguardPosition!,
                    zoom: 16,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId("bodyguard"),
                      position: bodyguardPosition!,
                      icon: bodyguardIcon!,
                    ),
                  },
                ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(20),
              ),
              height: 120,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Finding Your Bodyguard...",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Your safety specialist is on the way. Please stay in your location.",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
























// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class LiveTrackingScreen extends StatefulWidget {
//   const LiveTrackingScreen({super.key});

//   @override
//   State<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
// }

// class _LiveTrackingScreenState extends State<LiveTrackingScreen> {
//   late GoogleMapController mapController;
//   LatLng bodyguardPosition = const LatLng(0, 0);

//   @override
//   void initState() {
//     super.initState();

//     FirebaseDatabase.instance.ref("locations/bodyguard123").onValue.listen((event) {
//       final data = event.snapshot.value as Map;
//       setState(() {
//         bodyguardPosition = LatLng(data['latitude'], data['longitude']);
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Live Bodyguard Tracking")),
//       body: GoogleMap(
//         onMapCreated: (controller) => mapController = controller,
//         initialCameraPosition: CameraPosition(
//           target: bodyguardPosition,
//           zoom: 16,
//         ),
//         markers: {
//           Marker(markerId: const MarkerId("bg"), position: bodyguardPosition)
//         },
//       ),
//     );
//   }
// }
