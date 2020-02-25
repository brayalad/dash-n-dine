import 'package:get_it/get_it.dart';

import './core/food_list.dart';


GetIt locator = GetIt();

void setupLocator() {
	locator.registerFactory(() => FoodList()) ;
}