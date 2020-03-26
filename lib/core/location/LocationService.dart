import 'package:geolocator/geolocator.dart';

class LocationService {
	final Geolocator _geolocator = Geolocator();


	Future<Position> getCurrentLocation() async {
			return await _geolocator.getCurrentPosition(
					desiredAccuracy: LocationAccuracy.best
			);
	}

	Future<String> getAddressFromPosition(Position position) async {
		Placemark place = (await _geolocator.placemarkFromCoordinates(position.latitude, position.longitude))[0];

		return '${place.locality}, ${place.postalCode}, ${place.country}';
	}

	Future<String> getCurrentLocationAddress() async {
		//Position position = await getCurrentLocation();

		return await getAddressFromPosition(await getCurrentLocation());
	}

	Future<GeolocationStatus> getLocationPermissionStatus() async {
		return await _geolocator.checkGeolocationPermissionStatus();
	}

}