import 'package:dash_n_dine/core/model/Hours.dart';

import 'Categories.dart';
import 'Location.dart';

class Business {
	String id;
	String alias;
	String name;
	String imageUrl;
	bool isClaimed;
	bool isClosed;
	String url;
	String phone;
	String displayPhone;
	int reviewCount;
	List<Categories> categories;
	double rating;
	Location location;
	Coordinates coordinates;
	List<String> photos;
	String price;
	List<Hours> hours;
	List<String> transactions;
	List<SpecialHours> specialHours;

	Business(
			{this.id,
				this.alias,
				this.name,
				this.imageUrl,
				this.isClaimed,
				this.isClosed,
				this.url,
				this.phone,
				this.displayPhone,
				this.reviewCount,
				this.categories,
				this.rating,
				this.location,
				this.coordinates,
				this.photos,
				this.price,
				this.hours,
				this.transactions,
				this.specialHours});

	Business.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		alias = json['alias'];
		name = json['name'];
		imageUrl = json['image_url'];
		isClaimed = json['is_claimed'];
		isClosed = json['is_closed'];
		url = json['url'];
		phone = json['phone'];
		displayPhone = json['display_phone'];
		reviewCount = json['review_count'];
		if (json['categories'] != null) {
			categories = new List<Categories>();
			json['categories'].forEach((v) {
				categories.add(new Categories.fromJson(v));
			});
		}
		rating = json['rating'];
		location = json['location'] != null
				? new Location.fromJson(json['location'])
				: null;
		coordinates = json['coordinates'] != null
				? new Coordinates.fromJson(json['coordinates'])
				: null;
		photos = json['photos'].cast<String>();
		price = json['price'];
		if (json['hours'] != null) {
			hours = new List<Hours>();
			json['hours'].forEach((v) {
				hours.add(new Hours.fromJson(v));
			});
		}
		transactions = json['transactions'].cast<String>();
		if (json['special_hours'] != null) {
			specialHours = new List<SpecialHours>();
			json['special_hours'].forEach((v) {
				specialHours.add(new SpecialHours.fromJson(v));
			});
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['alias'] = this.alias;
		data['name'] = this.name;
		data['image_url'] = this.imageUrl;
		data['is_claimed'] = this.isClaimed;
		data['is_closed'] = this.isClosed;
		data['url'] = this.url;
		data['phone'] = this.phone;
		data['display_phone'] = this.displayPhone;
		data['review_count'] = this.reviewCount;
		if (this.categories != null) {
			data['categories'] = this.categories.map((v) => v.toJson()).toList();
		}
		data['rating'] = this.rating;
		if (this.location != null) {
			data['location'] = this.location.toJson();
		}
		if (this.coordinates != null) {
			data['coordinates'] = this.coordinates.toJson();
		}
		data['photos'] = this.photos;
		data['price'] = this.price;
		if (this.hours != null) {
			data['hours'] = this.hours.map((v) => v.toJson()).toList();
		}
		data['transactions'] = this.transactions;
		if (this.specialHours != null) {
			data['special_hours'] = this.specialHours.map((v) => v.toJson()).toList();
		}
		return data;
	}
}

