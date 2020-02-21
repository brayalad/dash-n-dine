import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dash_n_dine/ui/views/loginAnimation/staggeredAnimation.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
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

  _UserInputContainer({this.hintText});


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




class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {

  AnimationController _loginButtonController;
  var animationStatus = 0;

  @override
  void initState(){
    _loginButtonController = AnimationController(
        duration: Duration(milliseconds: 3000),
        vsync: this
    );

    super.initState();
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
                _UserInputContainer(hintText: 'username@email.com'),
                _divider,
                _UserInputRow(title: 'PASSWORD'),
                _UserInputContainer(hintText: '*********'),
                _divider,
                Row(
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
                ),
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
                      onPressed: () {
                        setState(() {
                          animationStatus = 1;
                        });
                        _playAnimation();
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

