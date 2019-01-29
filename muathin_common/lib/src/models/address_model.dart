import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  String type, short, long;
  GeoPoint geopoint;
  double distance;

  AddressModel({this.type, this.short, this.long, this.geopoint});

  AddressModel transform({Map map}) {
    AddressModel address = new AddressModel();

    address.type = map['type'];
    address.short = map['short'];
    address.long = map["long"];
    address.geopoint = map['geopoint'] as GeoPoint;

    return address;
  }

  GeoPoint toGeoPoint(double latitude, double longitude) {
    return GeoPoint(latitude, longitude);
  }

  Map<String, dynamic> toMap(AddressModel a) {
    return {
      'type': a.type,
      'short': a.short,
      'long': a.long,
      'geoPoint': a.geopoint
    };
  }
}
