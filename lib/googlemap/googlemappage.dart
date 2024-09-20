
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  final Completer<GoogleMapController>_controller = Completer();

  final CameraPosition position = const CameraPosition(
      zoom: 14.4746,
      target: LatLng(29.472561, 77.707130));

  List<Marker>lst = [];
  List<Marker>lst1 = const [
    Marker(markerId: MarkerId('1'),
      position: LatLng(29.472561, 77.707130),
      infoWindow: InfoWindow(
          title: 'My Location'
      ),
    ),
    Marker(markerId: MarkerId('2'),
      position: LatLng(29.4662369, 77.6961699),
      infoWindow: InfoWindow(
          title: 'mzn railway station'
      ),
    )
  ];

  @override
  void initState() {
    lst.addAll(lst1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: GoogleMap(
            initialCameraPosition: position,
            mapType: MapType.normal,
            markers: Set<Marker>.of(lst),
            // myLocationEnabled: true,
            // compassEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.location_disabled_outlined),
            onPressed: () async {
              GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(
                  const CameraPosition(
                      zoom: 14,
                      target: LatLng(27.5056942, 77.6641794))),
              );
              setState(() {

              });
            }

        )
    );
  }
}
