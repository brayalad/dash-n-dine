import 'dart:async';
import 'dart:convert';

import 'package:dash_n_dine/core/location/LocationService.dart';
import 'package:dash_n_dine/core/model/Business.dart';
import 'package:dash_n_dine/core/model/BusinessSearch.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class ParsedResponse<T> {
	ParsedResponse(this.statusCode, this.body);

	final int statusCode;
	final T body;

	bool isSuccess() {
		return statusCode >= 200 && statusCode < 300;
	}
}

const int CODE_OK = 200;
const int CODE_REDIRECTION = 300;
const int CODE_NOT_FOUND = 404;

class Repository {
	static final LocationService _geolocator = LocationService();
	static final Repository _repo = new Repository._internal();
	static const String API_KEY = "ods8ZNQoGmd7dasK7_nJLxyDzqeMZMdsX804ljCemd4uEg_NR8r0TRguFnSQKAChYxO5FB5ELXv3M9UTHuDOgenwEnzkBqcJ_9hx_Ll2yh33NZTkNSgl7kjwgWB8XnYx";
	static const Map<String, String> AUTH_HEADER = {"Authorization": "Bearer $API_KEY"};

	static Repository get() {
		return _repo;
	}

	Repository._internal();

	Future<List<BusinessSearch>> getBusinesses() async {

		Position position = await _geolocator.getCurrentLocation();

		String webAddress = "https://api.yelp.com/v3/businesses/search?latitude=${position.latitude}&longitude=${position.longitude}";

		http.Response response = await http.get(webAddress, headers: AUTH_HEADER).catchError((resp) {});


		// Error handling
		if (response == null || response.statusCode < CODE_OK || response.statusCode >= CODE_REDIRECTION) {
			return Future.error(response.body);
		}

		Map<String, dynamic> map = json.decode(response.body);

		List jsonList = map["businesses"];


		List<BusinessSearch> businesses = jsonList.map((model) => new BusinessSearch.fromJson(model)).toList();

		return businesses;
	}

	Future<List<BusinessSearch>> searchBusinesses(String term) async {
		if(term == null || term.isEmpty){
			return List();
		}


		Position position = await _geolocator.getCurrentLocation();

		String webAddress = "https://api.yelp.com/v3/businesses/search?latitude=${position.latitude}&longitude=${position.longitude}&term=$term";

		http.Response response = await http.get(webAddress, headers: AUTH_HEADER).catchError((resp) {});


		// Error handling
		if (response == null || response.statusCode < CODE_OK || response.statusCode >= CODE_REDIRECTION) {
			return Future.error(response.body);
		}

		Map<String, dynamic> map = json.decode(response.body);

		List jsonList = map["businesses"];


		List<BusinessSearch> businesses = jsonList.map((model) => new BusinessSearch.fromJson(model)).toList();

		return businesses;
	}


}