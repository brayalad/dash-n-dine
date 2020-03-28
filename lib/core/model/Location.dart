class Location {
	String address1;
	String address2;
	String address3;
	String city;
	String zipCode;
	String country;
	String state;
	List<String> displayAddress;
	String crossStreets;

	Location(
			{this.address1,
				this.address2,
				this.address3,
				this.city,
				this.zipCode,
				this.country,
				this.state,
				this.displayAddress,
				this.crossStreets});

	Location.fromJson(Map<String, dynamic> json) {
		address1 = json['address1'];
		address2 = json['address2'];
		address3 = json['address3'];
		city = json['city'];
		zipCode = json['zip_code'];
		country = json['country'];
		state = json['state'];
		displayAddress = json['display_address'].cast<String>();
		crossStreets = json['cross_streets'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['address1'] = this.address1;
		data['address2'] = this.address2;
		data['address3'] = this.address3;
		data['city'] = this.city;
		data['zip_code'] = this.zipCode;
		data['country'] = this.country;
		data['state'] = this.state;
		data['display_address'] = this.displayAddress;
		data['cross_streets'] = this.crossStreets;
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
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['latitude'] = this.latitude;
		data['longitude'] = this.longitude;
		return data;
	}
}