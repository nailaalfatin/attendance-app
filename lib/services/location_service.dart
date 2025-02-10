import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

// ini buat minta lokasi user, terus hasilnya dikirim ke callback (onPositionReceive)
Future<void> getGeoLocationPosition(BuildContext context, Function(Position) onPositionReceive) async { 
  // ignore: deprecated_member_use
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low); //kenapa pake yang low? biar hemat batre dan data
  onPositionReceive(position);
}

// ini buat convert koordinat jadi alamat lengkap pake package geocoding
Future<void> getAddressFromLongLat(Position position, Function(String) onAddressReceived) async {
  List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude); //latitude vertikal, longitude horizontal
  Placemark place = placemark[0];
  String address = "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
  onAddressReceived(address);
}

// ini buat ngecek apakah lokasi service aktif & user udah kasih izin lokasi
Future<bool> handleLocationPermission(BuildContext context) async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  // kalo lokasi mati ➝ munculin SnackBar
  if (!serviceEnabled) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.location_off,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          Text(
            "Location services are disabled. Please enable the service",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
      backgroundColor: Colors.blueGrey,
      shape: StadiumBorder(),
      behavior: SnackBarBehavior.floating,
    ));
    return false; //dipake buat ngeblokir user
  }
  
  LocationPermission permission = await Geolocator.checkPermission();

  // kalo user belum kasih izin/permission denied ➝ request lagi
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.location_off,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              "Location permission denied",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.blueGrey,
        shape: StadiumBorder(),
        behavior: SnackBarBehavior.floating,
      ));
      return false; //dipake buat ngeblokir user
    }
  }

  // kalo user menolak lagi/deniedForever ➝ kasih warning ke user karena kita nggak bisa akses lokasi lagi
  if (permission == LocationPermission.deniedForever) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.location_off,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          Text(
            "Location permission denied forever, we can't access.",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      backgroundColor: Colors.blueGrey,
        shape: StadiumBorder(),
        behavior: SnackBarBehavior.floating,
    ));
    return false; //dipake buat ngeblokir user
  }
  return true;
}