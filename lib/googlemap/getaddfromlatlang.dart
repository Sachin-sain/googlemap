import 'package:flutter/material.dart';
import 'package:location_geocoder/location_geocoder.dart';

class AddressFromLatLang extends StatefulWidget {
  const AddressFromLatLang({super.key});

  @override
  State<AddressFromLatLang> createState() => _AddressFromLatLangState();
}

class _AddressFromLatLangState extends State<AddressFromLatLang> {
  String add = '';
  String coordinates = '';

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Geocoding Example')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: (){
             getAddress();
            },
            child: Text("Get Address"),
          ),
          Text("Address: $add"),
          Text("Coordinates: $coordinates"),
        ],
      ),
    );
  }
  getAddress() async {
    const _apiKey = 'AIzaSyAboTTGSKXF5EjObaUgpCHj6t6M2FO8TOs';
    final LocatitonGeocoder geocoder = LocatitonGeocoder(_apiKey);

    try {
      final addresses = await geocoder.findAddressesFromCoordinates(Coordinates(20.5937, 78.9629));

      if (addresses.isNotEmpty) {
        print(addresses.first.addressLine);
        setState(() {
          add = addresses.first.addressLine.toString();
        });
      } else {
        print("No address found.");
        setState(() {
          add = "No address found.";
        });
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        add = "Error fetching address.";
      });
    }
  }


}
