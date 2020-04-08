import 'dart:convert';
import 'dart:math';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:dash_n_dine/core/auth/Auth.dart';
import 'package:dash_n_dine/core/location/LocationService.dart';
import 'package:dash_n_dine/core/model/BusinessSearch.dart';
import 'package:dash_n_dine/core/model/User.dart';
import 'package:dash_n_dine/core/services/repository.dart';
import 'package:http/http.dart';
import 'package:more/collection.dart';

class Recommender {
	final LocationService _location = LocationService();
	final Auth _auth = Auth.instance;
	static final Recommender _recommender = new Recommender._internal();
	static final Repository _repo = Repository.get();

	Recommender._internal();


	static Recommender get(){
		return _recommender;
	}

	Future<List<BusinessSearch>> getRecommendations() async {
		var user = await _auth.getCurrentUser();
		var position = await _location.getCurrentLocation();


		var response = await CloudFunctions.instance
				.getHttpsCallable(functionName: 'recommend')
				.call(<String, dynamic> {
			'favorites': List.from(user.favorites),
			'latitude': position.latitude,
			'longitude': position.longitude
		});

		//print(result.data['recommendations']);

		List list = response.data['recommendations'];

		print(response.toString());



		//Map<String, dynamic> result = json.decode(response.data);
		//print(result.toString());
		List<BusinessSearch> search = List();
		for(var i in list){
			//print(i.runtimeType);
			//Map<String, dynamic> json = i.map((k, v ) => MapEntry(k as String, v as dynamic));
			Map<String, dynamic> json = i.cast<String, dynamic>();
			//print(json.runtimeType);
			search.add(BusinessSearch.fromJson(json));
		}

		return search;



		//return list.map((e) => BusinessSearch.fromJson(e.map((k, v ) => MapEntry(k as String, v as dynamic))));
	}

	Future<Categories> calculateCurrentUserTopCategories() async {
		return await calculateUserTopCategories(await Auth.instance.getCurrentUser());
	}

	Future<Categories> calculateUserTopCategories(User user) async {

		Map<String, Categories> cache = Map();

		List<Categories> favorites = await _repo.getBusinessesCategories(user.favorites);

		Multiset<String> count = Multiset();

		String result;
		int max = -1;
		for(var favorite in favorites){
			String alias = favorite.alias;
			cache[alias] = favorite;
			count.add(alias);
			if(count[alias] > max){
				max = count[alias];
				result = alias;
			}
		}

		return cache[result];
	}

}