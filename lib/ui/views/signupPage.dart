import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared/theme.dart';

class SignUpPage extends StatefulWidget {
	@override
	_SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  @override
  Widget build(BuildContext context) {

  	final divider = Divider(
		  height: MediaQuery.of(context).size.height * 0.03,
		  color: Colors.transparent,
	  );

  	final logo = Container(
		  padding: EdgeInsets.symmetric(
			  horizontal: 100,
			  vertical: (MediaQuery.of(context).size.height > 600)
				  ? MediaQuery.of(context).size.height * 0.1
				  : MediaQuery.of(context).size.height * 0.05
		  ),
		  child: Center(
			  child: Image.asset(
					  'assets/logo.png',
					  color: Theme.of(context).primaryColor,
					  height: MediaQuery.of(context).size.height * 0.15,
					  width: MediaQuery.of(context).size.width * 0.2,
			  ),
		  ),
	  );

  	final email = _UserInputRow(text: 'EMAIL');
		final emailInput = _UserInputContainer(text: 'username@email.com');

	  final password = _UserInputRow(text: 'PASSWORD');
	  final passwordInput = _UserInputContainer(text: '***************');

	  final passwordConfirm = _UserInputRow(text: 'CONFIRM PASSWORD');
	  final passwordConfirmInput = _UserInputContainer(text: '***************');

	  final alreadyMember = Row(
		  mainAxisAlignment: MainAxisAlignment.end,
		  children: <Widget>[
			  Padding(
				  padding: const EdgeInsets.only(right: 20.0),
				  child: FlatButton(
					  child: Text(
						  'Already have an account?',
						  style: TextStyle(
							  fontWeight: FontWeight.bold,
							  color: Theme.of(context).primaryColor,
							  fontSize: 15.0,
						  ),
						  textAlign: TextAlign.end,
					  ),
					  onPressed: () => {},
				  ),
			  ),
		  ],
	  );

		final signup = Container(
			width: MediaQuery.of(context).size.width,
			margin: EdgeInsets.only(
					left: 30.0,
					right: 30.0,
					top: MediaQuery.of(context).size.height * 0.05),
			alignment: Alignment.center,
			child: Row(
				children: <Widget>[
					Expanded(
						child: FlatButton(
							shape: RoundedRectangleBorder(
								borderRadius: BorderRadius.circular(30.0),
							),
							color: Theme.of(context).primaryColor,
							onPressed: () {

							}
							,
							child: Container(
								padding: const EdgeInsets.symmetric(
									vertical: 20.0,
									horizontal: 20.0,
								),
								child: Row(
									mainAxisAlignment: MainAxisAlignment.center,
									children: <Widget>[
										Expanded(
											child: Text(
												'SIGN UP',
												textAlign: TextAlign.center,
												style: TextStyle(
														color: Colors.white,
														fontWeight: FontWeight.bold
												),
											),
										),
									],
								),
							),
						),
					),
				],
			),
		);


		return SingleChildScrollView(
			child: Container(
				height: MediaQuery.of(context).size.height,
				child: Column(
					children: <Widget>[
						logo,
						email,
						emailInput,
						divider,
						password,
						passwordInput,
						divider,
						passwordConfirm,
						passwordConfirmInput,
						divider,
						alreadyMember,
						signup
					],
				),
			),
		);

  }

}



class _UserInputContainer extends StatelessWidget {
	final text;

	_UserInputContainer({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
	    width: MediaQuery.of(context).size.width,
	    margin: const EdgeInsets.only(
		    left: 40.0,
		    right: 40.0,
		    top: 10.0
	    ),
	    alignment: Alignment.center,
	    decoration: BoxDecoration(
		    border: Border(
			    bottom: BorderSide(
				    color: Theme.of(context).primaryColor,
				    width: 0.5,
				    style: BorderStyle.solid
			    )
		    )
	    ),
	    padding: const EdgeInsets.only(
		    left: 0.0,
		    right: 10.0
	    ),
	    child: Row(
		    crossAxisAlignment: CrossAxisAlignment.center,
		    mainAxisAlignment: MainAxisAlignment.start,
		    children: <Widget>[
		    	Expanded(
				    child: TextField(
					    obscureText: false,
					    textAlign: TextAlign.left,
					    decoration: InputDecoration(
						    border: InputBorder.none,
						    hintText: text,
						    hintStyle: TextStyle(
							    color: Theme.of(context).hintColor
						    )
					    ),
				    ),
			    )
		    ],
	    ),
    );
  }

}


class _UserInputRow extends StatelessWidget {
	final text;

	_UserInputRow({this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
	    children: <Widget>[
	    	Expanded(
			    child: Padding(
				    padding: const EdgeInsets.only(
					    left: 40.0
				    ),
				    child: Text(
					    text,
					    style: TextStyle(
						    fontWeight: FontWeight.bold,
						    color: Theme.of(context).primaryColor,
						    fontSize: 15.0
					    ),
				    ),
			    ),
		    )
	    ],
    );
  }
}






