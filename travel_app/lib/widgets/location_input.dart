import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/helpers/location_helper.dart';
import 'package:travel_app/models/place.dart';
import 'package:travel_app/screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewLocationImage;

  Future<void> _getCurrentLocation() async {
    final _locationData = await Geolocator.getCurrentPosition();

    _getLocationImage(LatLng(_locationData.latitude, _locationData.longitude),
);
  }



  void _getLocationImage(LatLng location) {

    setState(() {
      _previewLocationImage = LocationHelper.getLocationImage(
        latitude: location.latitude, longtitude: location.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: _previewLocationImage == null
              ? Text("Location not selected")
              : Image.network(
                  _previewLocationImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 150,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
                onPressed: _getCurrentLocation,
                icon: Icon(Icons.location_on),
                label: Text("My Destination")),
            ElevatedButton.icon(
              onPressed: () async {
                final selectLocation = await Navigator.of(context).push<LatLng>(
                  MaterialPageRoute(
                    builder: (ctx) => GoogleMaps(
                        placeLocation: PlaceLocation(
                            latitude: 37.8263608,
                            longitude: 66.8359907,
                            address: "Tashkent"),
                        isSelecting: true),
                  ),
                );

                if (selectLocation == null) {
                  return;
                }

                _getLocationImage(selectLocation);
              },
              icon: Icon(Icons.map),
              label: Text("Open a Map"),
            ),
          ],
        )
      ],
    );
  }
}
