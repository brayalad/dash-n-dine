class Categories {
	String alias;
	String title;

	Categories({this.alias, this.title});

	Categories.fromJson(Map<String, dynamic> json) {
		alias = json['alias'];
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['alias'] = this.alias;
		data['title'] = this.title;
		return data;
	}
}