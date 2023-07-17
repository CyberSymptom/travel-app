import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/models/place.dart';

class GoogleMaps extends StatefulWidget {
  final PlaceLocation placeLocation;
  final bool isSelecting;

  const GoogleMaps({required this.placeLocation, required this.isSelecting});

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  LatLng? _pickedLocation;

  void _setLocation(LatLng Location) {
    setState(() {
      _pickedLocation = Location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select a destination"),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: _pickedLocation == null
                  ? null
                  : () => Navigator.of(context).pop(_pickedLocation),
              icon: Icon(Icons.check),
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
              widget.placeLocation.latitude, widget.placeLocation.longitude),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? _setLocation : (LatLng Location) {},
        markers: _pickedLocation == null
            ? {}
            : {
                Marker(
                  markerId: MarkerId("m1"),
                  position: _pickedLocation!,
                ),
              },
      ),
    );
  }
}
