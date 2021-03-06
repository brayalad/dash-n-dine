class BusinessSearch {
	double rating;
	String price;
	String phone;
	String id;
	String alias;
	bool isClosed;
	List<Categories> categories;
	int reviewCount;
	String name;
	String url;
	Coordinates coordinates;
	String imageUrl;
	Location location;
	double distance;
	List<String> transactions;

	BusinessSearch(
			{this.rating,
				this.price,
				this.phone,
				this.id,
				this.alias,
				this.isClosed,
				this.categories,
				this.reviewCount,
				this.name,
				this.url,
				this.coordinates,
				this.imageUrl,
				this.location,
				this.distance,
				this.transactions});

	BusinessSearch.fromJson(Map<String, dynamic> json) {
		rating = json['rating'];
		price = json['price'];
		phone = json['phone'];
		id = json['id'];
		alias = json['alias'];
		isClosed = json['is_closed'];
		if (json['categories'] != null) {
			categories = List<Categories>();
			json['categories'].forEach((v) {
				categories.add(Categories.fromJson(v));
			});
		}
		reviewCount = json['review_count'];
		name = json['name'];
		url = json['url'];
		coordinates = json['coordinates'] != null
				? Coordinates.fromJson(json['coordinates'])
				: null;
		imageUrl = json['image_url'];
		location = json['location'] != null
				? Location.fromJson(json['location'])
				: null;
		distance = json['distance'];
		transactions = json['transactions'].cast<String>();
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		data['rating'] = this.rating;
		data['price'] = this.price;
		data['phone'] = this.phone;
		data['id'] = this.id;
		data['alias'] = this.alias;
		data['is_closed'] = this.isClosed;
		if (this.categories != null) {
			data['categories'] = this.categories.map((v) => v.toJson()).toList();
		}
		data['review_count'] = this.reviewCount;
		data['name'] = this.name;
		data['url'] = this.url;
		if (this.coordinates != null) {
			data['coordinates'] = this.coordinates.toJson();
		}
		data['image_url'] = this.imageUrl;
		if (this.location != null) {
			data['location'] = this.location.toJson();
		}
		data['distance'] = this.distance;
		data['transactions'] = this.transactions;
		return data;
	}
}

class Categories {
	String alias;
	String title;

	Categories({this.alias, this.title});

	Categories.fromJson(Map<String, dynamic> json) {
		alias = json['alias'];
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		data['alias'] = this.alias;
		data['title'] = this.title;
		return data;
	}
}

class Coordinates {
	double latitude;
	double longitude;

	Coordinates({this.latitude, this.longitude});

	Coordinates.fromJson(Map<String, dynamic> json) {
		latitude = json['latitude'];
		longitude = json['longitude'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		data['latitude'] = this.latitude;
		data['longitude'] = this.longitude;
		return data;
	}
}

class Location {
	String city;
	String country;
	String address2;
	String address3;
	String state;
	String address1;
	String zipCode;

	Location(
			{this.city,
				this.country,
				this.address2,
				this.address3,
				this.state,
				this.address1,
				this.zipCode});

	Location.fromJson(Map<String, dynamic> json) {
		city = json['city'];
		country = json['country'];
		address2 = json['address2'];
		address3 = json['address3'];
		state = json['state'];
		address1 = json['address1'];
		zipCode = json['zip_code'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		data['city'] = this.city;
		data['country'] = this.country;
		data['address2'] = this.address2;
		data['address3'] = this.address3;
		data['state'] = this.state;
		data['address1'] = this.address1;
		data['zip_code'] = this.zipCode;
		return data;
	}
}
