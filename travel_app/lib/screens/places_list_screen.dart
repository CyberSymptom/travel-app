import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/providers/place_provider.dart';
import 'package:travel_app/screens/add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Travel"),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AddPlaceScreen.routName),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<placeProvider>(context, listen: false).getPlaces(),
        builder: (ctx, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            Center(
              child: CircularProgressIndicator(),
            );
          }
          return Consumer<placeProvider>(
            builder: (ctx, placeProvider, child) {
              if (placeProvider.list.isNotEmpty) {
                return ListView.builder(
                    itemCount: placeProvider.list.length,
                    itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                FileImage(placeProvider.list[i].image),
                          ),
                          title: Text(placeProvider.list[i].title),
                        ));
              } else {
                return child!;
              }
            },
            child: Center(
              child: Text("There is no Travel Place Name, Plaese add Place"),
            ),
          );
        },
      ),
    );
  }
}
