import 'package:dash_n_dine/core/auth/Auth.dart';
import 'package:dash_n_dine/core/auth/BasicAuth.dart';
import 'package:dash_n_dine/core/model/User.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';
import 'package:provider/provider.dart';
import '../shared/theme.dart';

const String PROFILE_PIC_PATH_FORMAT = '%s_profile_pic.jpeg';

class SignUpPage extends StatefulWidget {
	final PageController controller;

	SignUpPage({this.controller});

	@override
	_SignUpPageState createState() => _SignUpPageState(controller: controller);
}

class _SignUpPageState extends State<SignUpPage> {
	final Auth _auth = BasicAuth();
	final PageController controller;

	TextEditingController _firstNameInputController;
	TextEditingController _lastNameInputController;
	TextEditingController _userNameInputController;
	TextEditingController _emailInputController;
	TextEditingController _pswdInputController;
	TextEditingController _pswdConfirmInputController;

	_SignUpPageState({this.controller});

	@override
	void initState(){
		_firstNameInputController = TextEditingController();
		_lastNameInputController = TextEditingController();
		_userNameInputController = TextEditingController();
		_emailInputController = TextEditingController();
		_pswdInputController = TextEditingController();
		_pswdConfirmInputController = TextEditingController();
		super.initState();
	}

	gotoLogin() {
		controller.animateToPage(
			0,
			duration: Duration(milliseconds: 800),
			curve: Curves.ease,
		);
	}

	String getName(){
		return _firstNameInputController.text + ' ' + _lastNameInputController.text;
	}

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

	  final firstName = _UserInputRow(text: 'FIRST NAME');
	  final firstNameInput = _UserInputContainer(
		  text: 'James',
		  controller: _firstNameInputController,
	  );

	  final lastName = _UserInputRow(text: 'LAST NAME');
	  final lastNameInput = _UserInputContainer(
		  text: 'Smith',
		  controller: _lastNameInputController,
	  );

	  final username = _UserInputRow(text: 'USERNAME');
	  final usernameInput = _UserInputContainer(
		  text: 'username',
		  controller: _userNameInputController,
	  );

  	final email = _UserInputRow(text: 'EMAIL');
		final emailInput = _UserInputContainer(
				text: 'username@email.com',
			controller: _emailInputController,
		);

	  final password = _UserInputRow(text: 'PASSWORD');
	  final passwordInput = _UserInputContainer(
			  text: '***************',
		    controller: _pswdInputController,
		    isSecret: true,
	  );

	  final passwordConfirm = _UserInputRow(text: 'CONFIRM PASSWORD');
	  final passwordConfirmInput = _UserInputContainer(
		  text: '***************',
		  controller: _pswdConfirmInputController,
		  isSecret: true
	  );

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
					  onPressed: () => gotoLogin()
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
							onPressed: () async {
								User user = User(
									id: 'tempID',
									email: _emailInputController.text,
									username: _userNameInputController.text,
									firstName: _firstNameInputController.text,
									lastName: _lastNameInputController.text,
									photoUrl: sprintf(PROFILE_PIC_PATH_FORMAT, _userNameInputController.text)
								);
								
								var userId = await _auth.signUpUser(user, _pswdInputController.text);
								
								print(userId != null ? "SUCESS" : "FAIL");
								
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
				child: Column(
					children: <Widget>[
						logo,
						firstName,
						firstNameInput,
						divider,
						lastName,
						lastNameInput,
						divider,
						username,
						usernameInput,
						divider,
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
	final bool isSecret;
	final TextEditingController controller;


	_UserInputContainer({this.text, this.isSecret, this.controller});

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
					    obscureText: isSecret != null ? isSecret : false,
					    textAlign: TextAlign.left,
					    controller: controller,
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






