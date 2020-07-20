import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_taxi_app_driver/Components/circular_progress.dart';
import 'package:flutter_taxi_app_driver/Components/custom_flash.dart';
import 'package:flutter_taxi_app_driver/Components/ink_well_custom.dart';
import 'package:flutter_taxi_app_driver/Components/validations.dart';
import 'package:flutter_taxi_app_driver/theme/style.dart';


class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Validations validations = new Validations();
  TextEditingController _email = TextEditingController();
  bool _isLoading = false;
  final _auth = FirebaseAuth.instance;

  submit() async {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      _sendResetEmail();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: InkWellCustom(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
            Stack(children: <Widget>[
              Container(
                height: 250.0,
                width: double.infinity,
                color: Color(0xFFFDD148),
              ),
              Positioned(
                bottom: 450.0,
                right: 100.0,
                child: Container(
                  height: 400.0,
                  width: 400.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200.0),
                    color: Color(0xFFFEE16D),
                  ),
                ),
              ),
              Positioned(
                bottom: 500.0,
                left: 150.0,
                child: Container(
                    height: 300.0,
                    width: 300.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(150.0),
                        color: Color(0xFFFEE16D).withOpacity(0.5))),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(32.0, 150.0, 32.0, 0.0),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Container(
                        //padding: EdgeInsets.only(top: 100.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(7.0),
                          elevation: 5.0,
                          child: Container(
                            width: MediaQuery.of(context).size.width - 20.0,
                            height: MediaQuery.of(context).size.height * 0.5,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Form(
                              key: formKey,
                              child: Container(
                                padding: EdgeInsets.all(32.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Forgot Password',
                                      style: heading35Black,
                                    ),
                                    TextFormField(
                                      controller: _email,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: validations.validateEmail,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            left: 15.0, top: 15.0),
                                        hintText: 'Email',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: AnimatedContainer(
                                        height: 50,
                                        width: _isLoading
                                            ? 80
                                            : MediaQuery.of(context).size.width,
                                        duration: Duration(milliseconds: 500),
                                        child: ButtonTheme(
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.0)),
                                            elevation: 0.0,
                                            color: primaryColor,
                                            child: _isLoading
                                                ? CircularProgress()
                                                : Text(
                                                    'DONE',
                                                    style: headingWhite,
                                                  ),
                                            onPressed: submit,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text(
                                "Create new account? ",
                                style: textGrey,
                              ),
                              new InkWell(
                                onTap: () => Navigator.pop(context),
                                child: new Text(
                                  "Sign Up",
                                  style: textStyleActive,
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ]),
          ]),
        ),
      ),
    );
  }

  void _sendResetEmail() {
    setState(() => _isLoading = true);
    bool _isError = false;
    _auth.sendPasswordResetEmail(email: _email.text).catchError(
      (onError) {
        debugPrint("Error ===> ${onError.code}");
        _isError = true;
        if (onError.code == 'ERROR_USER_NOT_FOUND') {
          showCustomFlash(
            context: context,
            title: 'Failed',
            message: 'User Not Found',
          );
          setState(() => _isLoading = false);
        } else {
          showCustomFlash(
            context: context,
            title: 'Failed',
            message: 'Something went wrong!',
          );
          setState(() => _isLoading = false);
        }
      },
    ).then((value) async {
      if (!_isError) {
        showCustomFlash(
          context: context,
          title: 'Email Sent',
          message: 'Check your Inbox to change password',
        );
        Navigator.pop(context);
      }
    });
  }
}
