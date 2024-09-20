import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({super.key});

  @override
  State<CurrentLocation> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  final Completer<GoogleMapController>_controller=Completer();

  CameraPosition cameraPosition=const CameraPosition(
      zoom:14.4647 ,
      target: LatLng(29.4727,77.7085));

  List <Marker>lst=[];
  List <Marker>lst1=[
      Marker(markerId: MarkerId('1'),
      position: LatLng(29.4727,77.7085),
      infoWindow: InfoWindow(
        title: 'My City Location'
      )
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
          initialCameraPosition: cameraPosition,
          markers: Set<Marker>.of(lst),
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()async {
        await getCurrentLocation().then((value)async{
          print("My current Location");
          print(value.latitude.toString()+ " " +value.longitude.toString());
          lst.add(
              Marker(markerId: const MarkerId('1'),
                  position: LatLng(value.latitude, value.longitude),
                infoWindow: const InfoWindow(
                  title: "My Current Location"
                )
              )
          );
          CameraPosition position=CameraPosition(
            zoom: 14,
              target: LatLng(value.latitude,value.longitude));

         final GoogleMapController controller=await _controller.future;
         controller.animateCamera(CameraUpdate.newCameraPosition(position));
         setState(() {

         });


        });



      },
        child: const Icon(Icons.location_disabled_outlined),
      ),
    );
  }

 Future <Position> getCurrentLocation()async{

    await Geolocator.requestPermission().then((value){

    }).onError((err,stackTrace){
      print("Error${err.toString()}" );
    });
   return Geolocator.getCurrentPosition();
  }

}
