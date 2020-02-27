import 'package:dash_n_dine/core/auth/Auth.dart';
import 'package:dash_n_dine/core/auth/BasicAuth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dash_n_dine/ui/views/loginAnimation/staggeredAnimation.dart';

const _validEmailPattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';


class LoginScreen extends StatefulWidget {
  final PageController controller;

  LoginScreen({Key key, this.controller}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState(controller: controller);
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  final Auth auth = BasicAuth();
  final PageController controller;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  TextEditingController _emailInputController;
  TextEditingController _pswdInputController;
  AnimationController _loginButtonController;
  var animationStatus = 0;

  _LoginScreenState({this.controller});

  @override
  void initState(){
    _emailInputController = TextEditingController();
    _pswdInputController = TextEditingController();
    _loginButtonController = AnimationController(
        duration: Duration(milliseconds: 3000),
        vsync: this
    );

    super.initState();
  }

  String validateEmail(String value){
    RegExp regExp = RegExp(_validEmailPattern);
    return regExp.hasMatch(value) ? 'Email format invalid' : null;
  }

  String validatePassword(String value){
    int limit = 0;
    return value.length < limit ? 'Password must be longer than $limit characters' : null;
  }

  Future<Null> _playAnimation() async {
    await _loginButtonController.reset();

    try {
      await _loginButtonController.forward().whenComplete((){
        animationStatus = 0;
      });
    } on TickerCanceled{}
  }


  @override
  void dispose(){
    _loginButtonController.dispose();
    super.dispose();
  }

  gotoSignUp() {
    controller.animateToPage(
      2,
      duration: Duration(milliseconds: 800),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    Divider _divider = Divider(
      height: MediaQuery.of(context).size.height * 0.03,
      color: Colors.transparent,
    );


    Container _logo = Container(
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
            width: MediaQuery.of(context).size.width * 0.2
        ),
      ),
    );

    final forgotPassword = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              right: 20.0
          ),
          child: FlatButton(
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontSize: 15.0
              ),
              textAlign: TextAlign.end,
            ),
            onPressed: () => {},
          ),
        )
      ],
    );

    final noAccount = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              right: 20.0
          ),
          child: FlatButton(
            child: Text(
              'Dont Have an Account?',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontSize: 15.0
              ),
              textAlign: TextAlign.end,
            ),
            onPressed: () => gotoSignUp(),
          ),
        )
      ],
    );

    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(

        ),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Column(
              children: <Widget>[
                _logo,
                _UserInputRow(title: 'EMAIL'),
                _UserInputContainer(
                    hintText: 'username@email.com',
                    controller: _emailInputController
                ),
                _divider,
                _UserInputRow(title: 'PASSWORD'),
                _UserInputContainer(
                    hintText: '*********',
                    controller: _pswdInputController,
                    isSecret: true,
                ),
                _divider,
                forgotPassword,
                noAccount,
                Expanded(
                  child: Container(

                  ),
                ),
                Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 30.0,
                          right: 30.0,
                          top: 20.0
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.25)
                              ),
                            ),
                          ),
                          Text(
                            'OR CONNECT WITH',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.25)
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 30.0,
                          right: 30.0,
                          top: 20.0
                      ),
                      child: Row(
                        children: <Widget>[
                          _UserCustomSocialMediaLoginExpand(
                            socialMediaName: 'FACEBOOK',
                            color: Color(0Xff3B5998),
                          ),
                          _UserCustomSocialMediaLoginExpand(
                            socialMediaName: 'GOOGLE',
                            color: Color(0Xffdb3236),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    )
                  ],
                )
              ],
            ),
            (animationStatus == 0)
                ? Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.95 - 180
              ),
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(
                  left: 30.0,
                  right: 30.0
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)
                      ),
                      color: Theme.of(context).primaryColor,
                      onPressed: () async {
                        setState(() {
                          animationStatus = 1;
                        });
                        _playAnimation();

                        var user = await auth.signIn(_emailInputController.text, _pswdInputController.text);
                        if(user != null){
                          print("Success");
                        } else {
                          print("Fail");
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 20.0
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'LOGIN',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
                : StaggeredAnimation(
                buttonController: _loginButtonController,
                screenSize: MediaQuery.of(context).size
            )
          ],
        ),
      ),
    );
  }

}


class _UserInputRow extends StatelessWidget {
  final String title;

  _UserInputRow({this.title});

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
              this.title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontSize: 15.0
              ),
            ),
          ),
        ),
      ],
    );
  }

}

class _UserInputContainer extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isSecret;


  _UserInputContainer({this.hintText, this.controller, this.isSecret});


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
                  hintText: this.hintText,
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

class _UserCustomSocialMediaLoginExpand extends StatelessWidget {
  final String socialMediaName;
  final Color color;

  _UserCustomSocialMediaLoginExpand({this.socialMediaName, this.color});



  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: 8.0),
        alignment: Alignment.center,
        child: Row(
          children: <Widget>[
            Expanded(
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)
                ),
                color: this.color,
                onPressed: () => {},
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          onPressed: () {},
                          padding: EdgeInsets.only(
                              top: 20.0,
                              bottom: 20.0
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                this.socialMediaName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}


