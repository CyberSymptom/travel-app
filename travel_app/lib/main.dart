import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/providers/place_provider.dart';
import 'package:travel_app/screens/add_place_screen.dart';
import 'package:travel_app/screens/places_list_screen.dart';


void main(){

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => placeProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routName:(ctx) => AddPlaceScreen(),
        },
      ), 
    );
  }
}