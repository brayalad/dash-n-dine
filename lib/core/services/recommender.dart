import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:dash_n_dine/core/auth/Auth.dart';
import 'package:dash_n_dine/core/location/LocationService.dart';
import 'package:dash_n_dine/core/model/Business.dart';
import 'package:dash_n_dine/core/model/BusinessSearch.dart' as search;
import 'package:dash_n_dine/core/model/User.dart';
import 'package:dash_n_dine/core/services/repository.dart';
import 'package:http/http.dart' as http;
import 'package:more/collection.dart';

class Recommender {
	static final Recommender instance = get();

	static const String API_KEY = "ods8ZNQoGmd7dasK7_nJLxyDzqeMZMdsX804ljCemd4uEg_NR8r0TRguFnSQKAChYxO5FB5ELXv3M9UTHuDOgenwEnzkBqcJ_9hx_Ll2yh33NZTkNSgl7kjwgWB8XnYx";
	static const Map<String, String> AUTH_HEADER = {"Authorization": "Bearer $API_KEY"};

	final LocationService _location = LocationService.instance;
	final Auth _auth = Auth.instance;
	static final Recommender _recommender = new Recommender._internal();
	static final Repository _repo = Repository.get();

	final Map<String, Business> _favoritesCache = HashMap();
	final HashSet<String> _userFavoritesCache = HashSet();
	final List<String> _topCache = List();


	Recommender._internal();


	static Recommender get(){
		return _recommender;
	}

	Future<List<search.BusinessSearch>> getRecommendations() async {
		var user = await _auth.getCurrentUser();
		var position = await _location.getCurrentLocation();

		List<String> top = await calculateTopCategories(user.favorites);

		List<search.BusinessSearch> recommendations = List();
		for(String term in top){
			List<search.BusinessSearch> result = await _repo.searchBusinessesWithLocation(term, position.latitude, position.longitude);
			if(result != null) {
				List<search.BusinessSearch> sub = result.sublist(0, min(result.length, 10));
				sub.shuffle();
				recommendations.addAll(sub);
			}
		}

		recommendations.shuffle();

		return recommendations;
	}

	Future<List<Business>> getFavorites() async {
		var user = await _auth.getCurrentUser();

		List<Business> result = List();
		for(String favorite in user.favorites){

			Business info;
			if(_favoritesCache.containsKey(favorite)){
				info = _favoritesCache[favorite];
			} else {
				info = await _repo.getBusinessInfo(favorite);
				_favoritesCache[favorite] = info;
			}

			if(info != null){
				result.add(info);
			}
		}

		result.shuffle();

		return result;
	}

	Future<List<String>> calculateTopCategories(Iterable<String> ids) async {
		List<String> top = List();
		if(_haveFavoritesChanged(ids)){
			Multiset<String> multiset = Multiset.from(await getBusinessesCategories(ids));

			top.addAll(multiset.distinct);
			top.sort((a, b) {
				int ca = multiset[a];
				int cb = multiset[b];

				if(ca > cb){
					return -1;
				} else if(ca == cb){
					return 0;
				} else {
					return 1;
				}
			});
			_topCache.clear();
			_topCache.addAll(top);
		} else {
			top.addAll(_topCache);
		}


		return top.sublist(0, min(top.length, 5));
	}

	Future<List<String>> getBusinessesCategories(Iterable<String> ids) async {
		List<String> results = List();
		for(String id in ids){
			if(_favoritesCache.containsKey(id)){
				Business cached = _favoritesCache[id];
				if(cached != null){
					results.addAll(cached.categories.map((c) => c.title).toList());
				}
			} else {
				results.addAll(await getBusinessCategories(id));
			}
		}

		return results;
	}

	Future<List<String>> getBusinessCategories(String id) async {
		if(_favoritesCache.containsKey(id)){
			Business cached = _favoritesCache[id];
			if(cached != null){
				return cached.categories.map((c) => c.title).toList();
			}
		}

		Business business = await _repo.getBusinessInfo(id);
		if(business == null){
			return List();
		}

		return business.categories.map((c) => c.title).toList();
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

	bool _haveFavoritesChanged(Iterable<String> favorites){
		for(String favorite in favorites){
			if(!_userFavoritesCache.contains(favorite)){
				return true;
			}
		}

		return false;
	}

}