import '../constants/google_maps.dart';

class LocationHelper{

  static String getLocationImage({ required double latitude, required double longtitude}){

    return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude, $longtitude NY&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longtitude&key=$GOOGLE_API_KEY";

  }
}