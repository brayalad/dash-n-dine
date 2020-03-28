class Hours {
	List<Open> open;
	String hoursType;
	bool isOpenNow;

	Hours({this.open, this.hoursType, this.isOpenNow});

	Hours.fromJson(Map<String, dynamic> json) {
		if (json['open'] != null) {
			open = new List<Open>();
			json['open'].forEach((v) {
				open.add(new Open.fromJson(v));
			});
		}
		hoursType = json['hours_type'];
		isOpenNow = json['is_open_now'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.open != null) {
			data['open'] = this.open.map((v) => v.toJson()).toList();
		}
		data['hours_type'] = this.hoursType;
		data['is_open_now'] = this.isOpenNow;
		return data;
	}
}

class Open {
	bool isOvernight;
	String start;
	String end;
	int day;

	Open({this.isOvernight, this.start, this.end, this.day});

	Open.fromJson(Map<String, dynamic> json) {
		isOvernight = json['is_overnight'];
		start = json['start'];
		end = json['end'];
		day = json['day'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['is_overnight'] = this.isOvernight;
		data['start'] = this.start;
		data['end'] = this.end;
		data['day'] = this.day;
		return data;
	}
}

class SpecialHours {
	String date;
	Null isClosed;
	String start;
	String end;
	bool isOvernight;

	SpecialHours(
			{this.date, this.isClosed, this.start, this.end, this.isOvernight});

	SpecialHours.fromJson(Map<String, dynamic> json) {
		date = json['date'];
		isClosed = json['is_closed'];
		start = json['start'];
		end = json['end'];
		isOvernight = json['is_overnight'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['date'] = this.date;
		data['is_closed'] = this.isClosed;
		data['start'] = this.start;
		data['end'] = this.end;
		data['is_overnight'] = this.isOvernight;
		return data;
	}
}
