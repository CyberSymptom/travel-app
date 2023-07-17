import 'dart:io';
import 'package:flutter/material.dart';
import 'package:travel_app/database/place_db.dart';
import 'package:travel_app/models/place.dart';

class placeProvider with ChangeNotifier {
  List<Place> _list = [];

  List<Place> get list {
    return [..._list];
  }

  void AddPlace(String title, File image) {
    PlaceLocation placeLocation =
        PlaceLocation(latitude: 1, longitude: 1, address: "Uzb");

    Place newPlace = Place(
        id: UniqueKey().toString(),
        title: title,
        location: placeLocation,
        image: image);

    _list.add(newPlace);
    notifyListeners();

    PlaceDB.insert("user_places",
        {"id": newPlace.id, "title": newPlace.title, "image": newPlace.image});
  }

  Future<void> getPlaces() async {
    PlaceLocation placeLocation =
        PlaceLocation(latitude: 1, longitude: 1, address: "Uzb");

    final PlacesList = await PlaceDB.getDate("user_places");

   _list =  PlacesList.map((place) => Place(
        id: place["id"],
        title: place["title"],
        location: placeLocation,
        image: File(place["image"])
        ),
      ).toList();
      notifyListeners();
  }
}
