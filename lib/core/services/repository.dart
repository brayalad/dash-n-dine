import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:dash_n_dine/core/location/LocationService.dart';
import 'package:dash_n_dine/core/model/Business.dart' as info;
import 'package:dash_n_dine/core/model/BusinessSearch.dart' as search;
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graphql/client.dart';
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
	static final Repository instance = _repo;

	static final LocationService _geolocator = LocationService.instance;
	static final Repository _repo = Repository._internal();
	static const String API_KEY = "ods8ZNQoGmd7dasK7_nJLxyDzqeMZMdsX804ljCemd4uEg_NR8r0TRguFnSQKAChYxO5FB5ELXv3M9UTHuDOgenwEnzkBqcJ_9hx_Ll2yh33NZTkNSgl7kjwgWB8XnYx";
	static const String GRAPH_QL_ENDPOINT = 'https://api.yelp.com/v3/graphql';
	static const Map<String, String> AUTH_HEADER = {"Authorization": "Bearer $API_KEY"};
	static const Map<String, String> GRAPH_QL_AUTH_HEADER = {
		"Authorization": "Bearer $API_KEY",
		"Content-Type": "application/graphql"
	};

	static final HttpLink _httpLink = HttpLink(
		uri: GRAPH_QL_ENDPOINT,
	);

	static final AuthLink _authLink = AuthLink(
		getToken: () async => 'Bearer $API_KEY',
	);

	final Dio client = Dio();


	static Repository get() {
		return _repo;
	}


	final Map<String, search.BusinessSearch> _searchCache = HashMap();
	final Map<String, info.Business> _businessCache = HashMap();

	Repository._internal(){
		client.options.baseUrl = 'https://api.yelp.com/v3/';
		client.options.responseType = ResponseType.json;
		client.options.headers = {HttpHeaders.authorizationHeader: "Bearer $API_KEY"};

		DioCacheManager manager = DioCacheManager(
			CacheConfig(
				baseUrl: 'https://api.yelp.com/v3/',
				defaultMaxStale: Duration(hours: 1),
				defaultMaxAge: Duration(days: 1)
			)
		);

	client.interceptors.add(manager.interceptor);

		Timer.periodic(Duration(hours: 1), (Timer t) => _businessCache.clear());
	}

	Future<List<search.BusinessSearch>> getBusinesses() async {

		Position position = await _geolocator.getCurrentLocation();

		String webAddress = "https://api.yelp.com/v3/businesses/search?latitude=${position.latitude}&longitude=${position.longitude}";

		http.Response response = await http.get(webAddress, headers: AUTH_HEADER).catchError((resp) {});


		// Error handling
		if (response == null || response.statusCode < CODE_OK || response.statusCode >= CODE_REDIRECTION) {
			return Future.error(response.body);
		}

		Map<String, dynamic> map = json.decode(response.body);

		List jsonList = map["businesses"];


		List<search.BusinessSearch> businesses = jsonList.map((model) => new search.BusinessSearch.fromJson(model)).toList();

		return businesses;
	}

	Future<List<search.BusinessSearch>> searchBusinesses(String term) async {
		if(term == null || term.isEmpty){
			return List();
		}

		Position position = await _geolocator.getCurrentLocation();

		return searchBusinessesWithLocation(term, position.latitude, position.longitude);
	}

	Future<List<search.BusinessSearch>> searchBusinessesWithLocation(String term, double latitude, double longitude) async {
		if(term == null || latitude == null || longitude == null){
			return List();
		}

		String webAddress = "https://api.yelp.com/v3/businesses/search?latitude=$latitude&longitude=$longitude&term=$term";

		//http.Response response = await http.get(webAddress, headers: AUTH_HEADER).catchError((resp) {});

		Response response = await client.get(webAddress);


		// Error handling
		if (response == null || response.statusCode < CODE_OK || response.statusCode >= CODE_REDIRECTION) {
			//return Future.error(response.statusMessage);
			return null;
		}

		//Map<String, dynamic> map = json.decode(response.data.toString());

		List jsonList = response.data["businesses"];


		List<search.BusinessSearch> businesses = jsonList
				.map((model) => search.BusinessSearch.fromJson(model))
				.where((e) => e != null)
				.toList();

		return businesses;
	}

	Future<info.Business> getBusinessInfo(String id) async {
		if(_businessCache.containsKey(id)){
			return _businessCache[id];
		}

		info.Business business = await _getBusinessInfo(id);

		_businessCache[id] = business;

		return business;
	}

	Future<info.Business> _getBusinessInfo(String id) async {
		String url = 'https://api.yelp.com/v3/businesses/$id';

		http.Response response = await http.get(url, headers: AUTH_HEADER);

		// Error handling
		if (response == null || response.statusCode < CODE_OK || response.statusCode >= CODE_REDIRECTION) {
			return null;
		}

		Map<String, dynamic> map = json.decode(response.body);

		return info.Business.fromJson(map);
	}

	Future<List<info.Categories>> getBusinessesCategories(Iterable<String> ids) async {
		List<info.Categories> list = List();
		for(var id in ids){
			list.addAll(await getBusinessCategories(id));
		}

		return list;
	}

	Future<List<info.Categories>> getBusinessCategories(String id) async {

		String webAddress = "https://api.yelp.com/v3/businesses/$id";

		http.Response response = await http.get(webAddress, headers: AUTH_HEADER).catchError((resp) {});


		// Error handling
		if (response == null || response.statusCode < CODE_OK || response.statusCode >= CODE_REDIRECTION) {
			List();
		}

		Map<String, dynamic> map = json.decode(response.body);

		List list = map['categories'];

		List<info.Categories> categories = List();
		if(list != null){
			list.forEach((e) {
				categories.add(info.Categories.fromJson(e));
			});
		}

		return categories;
	}

	void _clearCache(){
		_businessCache.clear();
	}

}