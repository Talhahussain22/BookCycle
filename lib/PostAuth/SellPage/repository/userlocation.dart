import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart' as geocoding;

class UserLocation {
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint("Location services are disabled.");
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint("Location permission denied.");
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint("Location permissions are permanently denied.");
      return false;
    }

    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;

    try {
      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      debugPrint("Error getting location: $e");
    }
  }

  dynamic lat;
  dynamic lon;

  Future<dynamic> getAddressFromLatLng() async {
    await _getCurrentPosition();
    if (_currentPosition == null) return null;

    lat = _currentPosition!.latitude;
    lon = _currentPosition!.longitude;

    try {
      final url = Uri.parse(
        "https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lon&zoom=18&addressdetails=1",
      );

      final response = await http.get(
        url,
        headers: {
          'User-Agent':
              'BookCycleApp/1.0 (th47555@gmail.com)', // Required by Nominatim
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["address"]["neighbourhood"] != null) {
          return [data["address"]["neighbourhood"], lat, lon];
        }
      }
    } catch (e) {
      debugPrint("OSM reverse geocoding failed: $e");
    }
    try {
      final placemarks = await geocoding.placemarkFromCoordinates(lat, lon);
      if (placemarks == null) return null;
      final place = placemarks.first;
      if (place == null) return null;

      return [
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}',
        lat,
        lon,
      ];
    } catch (e) {
      debugPrint("Google reverse geocoding failed: $e");
    }

    return null;
  }
}
