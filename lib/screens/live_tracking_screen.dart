import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BodyguardTrackingScreen extends StatefulWidget {
  const BodyguardTrackingScreen({super.key});

  @override
  State<BodyguardTrackingScreen> createState() => _BodyguardTrackingScreenState();
}

class _BodyguardTrackingScreenState extends State<BodyguardTrackingScreen> {
  GoogleMapController? mapController;
  BitmapDescriptor? bodyguardIcon;

  final LatLng customer = const LatLng(12.9289, 77.6101);
  final LatLng bookedGuard = const LatLng(12.9352, 77.6186);
  final List<LatLng> otherGuards = [
    const LatLng(12.9361, 77.6042),
    const LatLng(12.9320, 77.6251),
    const LatLng(12.9233, 77.6168),
    const LatLng(12.9220, 77.6098),
  ];

  Set<Marker> markers = {};
  Set<Polyline> polyline = {};

  @override
  void initState() {
    super.initState();
    _generateSmallEmojiMarker();
  }

  Future<void> _generateSmallEmojiMarker() async {
    const double size = 22; // Smaller emoji size
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);

    final textPainter = TextPainter(
      text: const TextSpan(
        text: '🕶️',
        style: TextStyle(fontSize: size),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(canvas, const Offset(0, 0));

    final ui.Image emojiImage = await recorder.endRecording().toImage(
      size.toInt(),
      size.toInt(),
    );

    final ByteData? byteData = await emojiImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List emojiBytes = byteData!.buffer.asUint8List();

    bodyguardIcon = BitmapDescriptor.fromBytes(emojiBytes);

    _setupMap();
  }

  void _setupMap() {
    Set<Marker> tempMarkers = {
      Marker(markerId: const MarkerId('customer'), position: customer),
      Marker(markerId: const MarkerId('booked'), position: bookedGuard, icon: bodyguardIcon!),
    };

    for (int i = 0; i < otherGuards.length; i++) {
      tempMarkers.add(
        Marker(
          markerId: MarkerId('guard_$i'),
          position: otherGuards[i],
          icon: bodyguardIcon!,
        ),
      );
    }

    Set<Polyline> tempPolyline = {
      Polyline(
        polylineId: const PolylineId('route'),
        points: [bookedGuard, customer],
        color: Colors.blue,
        width: 5,
      )
    };

    setState(() {
      markers = tempMarkers;
      polyline = tempPolyline;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: customer, zoom: 15),
            markers: markers,
            polylines: polyline,
            onMapCreated: (controller) => mapController = controller,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              height: 120,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(20),
              ),
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
//   GoogleMapController? mapController;
//   LatLng? bodyguardPosition;
//   LatLng? customerPosition;
//   BitmapDescriptor? bodyguardIcon;
//   Set<Polyline> _polylines = {};

//   @override
//   void initState() {
//     super.initState();
//     _loadCustomMarker();
//     _listenToLocations();
//   }

//   void _loadCustomMarker() async {
//     try {
//       bodyguardIcon = await BitmapDescriptor.fromAssetImage(
//         const ImageConfiguration(size: Size(48, 48)),
//         'lib/assets/bodyguard_marker.png',
//       );
//     } catch (_) {
//       bodyguardIcon = BitmapDescriptor.defaultMarker;
//     }
//     setState(() {});
//   }

//   void _listenToLocations() {
//     // Listen to bodyguard location
//     FirebaseDatabase.instance.ref("locations/bodyguard123").onValue.listen((event) {
//       final data = event.snapshot.value;
//       if (data != null && data is Map) {
//         final updated = LatLng(
//           (data['latitude'] as num).toDouble(),
//           (data['longitude'] as num).toDouble(),
//         );
//         setState(() => bodyguardPosition = updated);
//         _updateMap();
//       }
//     });

//     // Listen to customer location
//     FirebaseDatabase.instance.ref("locations/customer123").onValue.listen((event) {
//       final data = event.snapshot.value;
//       if (data != null && data is Map) {
//         final updated = LatLng(
//           (data['latitude'] as num).toDouble(),
//           (data['longitude'] as num).toDouble(),
//         );
//         setState(() => customerPosition = updated);
//         _updateMap();
//       }
//     });
//   }

//   void _updateMap() {
//     if (bodyguardPosition != null && customerPosition != null && mapController != null) {
//       _polylines = {
//         Polyline(
//           polylineId: const PolylineId("route"),
//           points: [bodyguardPosition!, customerPosition!],
//           color: Colors.blue,
//           width: 5,
//         )
//       };

//       mapController!.animateCamera(
//         CameraUpdate.newLatLngBounds(
//           LatLngBounds(
//             southwest: LatLng(
//               (bodyguardPosition!.latitude < customerPosition!.latitude)
//                   ? bodyguardPosition!.latitude
//                   : customerPosition!.latitude,
//               (bodyguardPosition!.longitude < customerPosition!.longitude)
//                   ? bodyguardPosition!.longitude
//                   : customerPosition!.longitude,
//             ),
//             northeast: LatLng(
//               (bodyguardPosition!.latitude > customerPosition!.latitude)
//                   ? bodyguardPosition!.latitude
//                   : customerPosition!.latitude,
//               (bodyguardPosition!.longitude > customerPosition!.longitude)
//                   ? bodyguardPosition!.longitude
//                   : customerPosition!.longitude,
//             ),
//           ),
//           100,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isLoading = bodyguardPosition == null || customerPosition == null || bodyguardIcon == null;

//     return Scaffold(
//       body: Stack(
//         children: [
//           isLoading
//               ? const Center(child: CircularProgressIndicator())
//               : GoogleMap(
//                   initialCameraPosition: CameraPosition(
//                     target: customerPosition!,
//                     zoom: 15,
//                   ),
//                   onMapCreated: (controller) => mapController = controller,
//                   markers: {
//                     Marker(
//                       markerId: const MarkerId("bodyguard"),
//                       position: bodyguardPosition!,
//                       icon: bodyguardIcon!,
//                     ),
//                     Marker(
//                       markerId: const MarkerId("customer"),
//                       position: customerPosition!,
//                       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
//                     ),
//                   },
//                   polylines: _polylines,
//                   myLocationEnabled: false,
//                   myLocationButtonEnabled: false,
//                 ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               padding: const EdgeInsets.all(16),
//               margin: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.black87,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               height: 120,
//               width: double.infinity,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Text(
//                     "Finding Your Bodyguard...",
//                     style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     "Your safety specialist is on the way. Please stay in your location.",
//                     style: TextStyle(color: Colors.white70),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }























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
