import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/providers/place_provider.dart';
import 'package:travel_app/widgets/image_input.dart';
import 'package:travel_app/widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  static const routName = '/add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  File? _savedImages;
  String _title = "";
  final _formKey = GlobalKey<FormState>();

  void _takeImage(savedImage) {
    _savedImages = savedImage;
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _savedImages != null) {
      _formKey.currentState!.save();
      Provider.of<placeProvider>(context, listen: false)
          .AddPlace(_title, _savedImages!);

      Navigator.of(context).pop();
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Add a Place"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          label: Text("Place of name"),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the place name";
                          }
                        },
                        onSaved: (value) {
                          _title = value!;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ImageInput(_takeImage),
                      SizedBox(
                        height: 20,
                      ),
                      LocationInput(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _submit,
            child: Text("Add"),
            style: ElevatedButton.styleFrom(
                elevation: 0,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.symmetric(vertical: 15)),
          ),
        ],
      ),
    );
  }
}
