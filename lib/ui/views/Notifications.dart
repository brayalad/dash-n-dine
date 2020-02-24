import 'package:dash_n_dine/ui/widgets/TitleAppBar.dart';
import 'package:flutter/material.dart';
import '../widgets/TitleAppBar.dart';
import '../shared/text_styles.dart' as style;


class NotificationsPage extends StatelessWidget {
  final List<NotificationCard> notifications;

  NotificationsPage(this.notifications);

	@override
  Widget build(BuildContext context) {
		return Scaffold(
			appBar: TitleAppBar(
				title: 'Notification'
			),
			body: SingleChildScrollView(
				child: Padding(
					padding: EdgeInsets.all(12),
					child: Column(
						children: notifications,
					),
				),
			),
		);
  }
}


class NotificationCard extends StatelessWidget {
	final IconData icon;
	final Color color;
	final String message;

  const NotificationCard(this.icon, this.color, this.message);


  @override
  Widget build(BuildContext context) {
    final _icon = Container(
	    decoration: BoxDecoration(
		    color: color, borderRadius: BorderRadius.circular(300),
	    ),
	    height: MediaQuery.of(context).size.height * 0.07,
	    width: MediaQuery.of(context).size.height * 0.07,
	    child: Icon(
		    icon,
		    color: Colors.white,
		    size: 30,
	    ),
    );

		final _message = Expanded(
			child: Text(
				message,
				maxLines: 3,
				style: style.subHeaderStyle,
				softWrap: true,
			),
		);

		final card = Card(
			elevation: 10,
			child: Container(
				decoration: BoxDecoration(
					color: Theme.of(context).cardColor
				),
				padding: EdgeInsets.all(10.0),
				width: MediaQuery.of(context).size.width * 0.95,
				height: MediaQuery.of(context).size.height * 0.1,
				child: Row(
					children: <Widget>[
						_icon,
						SizedBox(width: 15),
						_message
					],
				),
			),
		);

		return Dismissible(
			key: GlobalKey(),
			child: Padding(
				padding: const EdgeInsets.only(
					bottom: 14
				),
				child: card,
			),
		);

  }

}

