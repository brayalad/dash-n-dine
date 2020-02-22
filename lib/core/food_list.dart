import 'package:flutter/material.dart';


class FoodList extends ChangeNotifier {
	List categories = [];

	List cuisines = [];


}


class FoodCategory {
	final id;
	final type;
	final cuisine;

  FoodCategory(this.id, this.type, this.cuisine);
}


class FoodCuisine {
	final id;
	final cuisine;
	final img;

	FoodCuisine(this.id, this.cuisine, this.img);


}


