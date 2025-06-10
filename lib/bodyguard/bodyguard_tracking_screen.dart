import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BodyguardTrackingScreens extends StatefulWidget {
  const BodyguardTrackingScreens({super.key});

  @override
  State<BodyguardTrackingScreens> createState() => _BodyguardTrackingScreenState();
}

class _BodyguardTrackingScreenState extends State<BodyguardTrackingScreens> {
  GoogleMapController? mapController;

  final LatLng bodyguardLocation = const LatLng(12.9289, 77.6101); // fixed
  final LatLng customerLocation = const LatLng(12.9352, 77.6186); // fixed

  Set<Polyline> route = {};
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    _setupMarkersAndRoute();
  }

  void _setupMarkersAndRoute() {
    route = {
      Polyline(
        polylineId: const PolylineId('route'),
        points: [bodyguardLocation, customerLocation],
        color: Colors.green,
        width: 5,
      )
    };

    markers = {
      Marker(markerId: const MarkerId('bodyguard'), position: bodyguardLocation),
      Marker(markerId: const MarkerId('customer'), position: customerLocation),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tracking")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: bodyguardLocation, zoom: 15),
        markers: markers,
        polylines: route,
        onMapCreated: (controller) => mapController = controller,
      ),
    );
  }
}
