import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_booking/Components/circular_progress.dart';
import 'package:flutter_map_booking/Components/custom_flash.dart';
import 'package:flutter_map_booking/Components/ink_well_custom.dart';
import 'package:flutter_map_booking/app_router.dart';
import 'package:flutter_map_booking/theme/style.dart';
import 'package:flutter_map_booking/Components/validations.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool autoValidate = false;
  Validations validations = Validations();
  TextEditingController _email = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _isLoading = false;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: InkWellCustom(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: <
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
                    padding: EdgeInsets.fromLTRB(32.0, 100.0, 32.0, 0.0),
                    child: Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height,
                        width: double.infinity,
                        child: Column(
                          children: <Widget>[
                            Container(
                              //padding: EdgeInsets.only(top: 100.0),
                                child: Material(
                                  borderRadius: BorderRadius.circular(7.0),
                                  elevation: 5.0,
                                  child: Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width - 20.0,
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.55,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            20.0)),
                                    child: Form(
                                        key: formKey,
                                        child: Container(
                                          padding: EdgeInsets.all(32.0),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Sign up',
                                                style: heading35Black,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  TextFormField(
                                                    controller: _email,
                                                    keyboardType:
                                                    TextInputType.emailAddress,
                                                    validator:
                                                    validations.validateEmail,
                                                    decoration: InputDecoration(
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                      ),
                                                      prefixIcon: Icon(
                                                          Icons.email,
                                                          color: Color(
                                                              getColorHexFromStr(
                                                                  '#FEDF62')),
                                                          size: 20.0),
                                                      contentPadding: EdgeInsets
                                                          .only(
                                                          left: 15.0,
                                                          top: 15.0),
                                                      hintText: 'Email',
                                                      hintStyle: TextStyle(
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10.0),
                                                  ),
                                                  TextFormField(
                                                      controller: _name,
                                                      validator: (value) {
                                                        if (value.isEmpty)
                                                          return 'Please Enter Name';
                                                        else
                                                          return null;
                                                      },
                                                      decoration: InputDecoration(
                                                          border: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                10.0),
                                                          ),
                                                          prefixIcon: Icon(
                                                              Icons
                                                                  .info_outline,
                                                              color: Color(
                                                                  getColorHexFromStr(
                                                                      '#FEDF62')),
                                                              size: 20.0),
                                                          contentPadding:
                                                          EdgeInsets.only(
                                                              left: 15.0,
                                                              top: 15.0),
                                                          hintText: 'Fullname',
                                                          hintStyle: TextStyle(
                                                            color: Colors.grey,
                                                          ))),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10.0),
                                                  ),
                                                  TextFormField(
                                                    validator:
                                                    validations
                                                        .validatePassword,
                                                    controller: _password,
                                                    obscureText: true,
                                                    decoration: InputDecoration(
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                      ),
                                                      prefixIcon: Icon(
                                                          Icons.lock_outline,
                                                          color: Color(
                                                              getColorHexFromStr(
                                                                  '#FEDF62')),
                                                          size: 20.0),
                                                      contentPadding: EdgeInsets
                                                          .only(
                                                          left: 15.0,
                                                          top: 15.0),
                                                      hintText: 'Password',
                                                      hintStyle: TextStyle(
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10.0),
                                                  ),
                                                  Align(
                                                    alignment: Alignment
                                                        .centerRight,
                                                    child: GestureDetector(
                                                      onTap: () =>
                                                          Navigator.of(context)
                                                              .pushNamed(
                                                              AppRoute
                                                                  .forgotPassword),
                                                      child: Text(
                                                        'Forgot Password?',
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color: Theme
                                                              .of(context)
                                                              .accentColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: AnimatedContainer(
                                                  height: 50,
                                                  width: _isLoading
                                                      ? 80
                                                      : MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width,
                                                  duration: Duration(
                                                      milliseconds: 500),
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
                                                        'SIGN UP',
                                                        style: headingWhite,
                                                      ),
                                                      onPressed: submit,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                )),
                            Container(
                                padding: EdgeInsets.fromLTRB(
                                    0.0, 20.0, 0.0, 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Already have an account? ",
                                      style: textGrey,
                                    ),
                                    InkWell(
                                      onTap: () =>
                                          Navigator.of(context)
                                              .pushNamed(AppRoute.loginScreen),
                                      child: Text(
                                        "Sign In",
                                        style: textStyleActive,
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ))),
              ])
            ]),
          )),
    );
  }

  submit() async {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      _createAuth();
    }
  }

  Future _fetchUserDetailsFromFireStore() async {
    try {
      bool _isError = false;
      await Firestore.instance
          .collection('users')
          .where('email', isEqualTo: _email.text)
          .getDocuments()
          .then((value) {
        if (value.documents[0].documentID != null) {
          showCustomFlash(
            context: context,
            title: 'Success',
            message: 'Account Created Successfully!',
          );
          setState(() {
            _isLoading = false;
            _name.text = '';
            _email.text = '';
            _password.text = '';
          });
        }
      });
    } catch (error) {
      debugPrint('Going to create User ===> $error');
      await _createUserInFireStore()
          .then((_) => _fetchUserDetailsFromFireStore());
    }
  }

  Future _createUserInFireStore() async {
    try {
      await Firestore.instance.collection('users').document().setData({
        'email': _email.text,
        'name': _name.text,
        'password': _password.text,
        'phone': null,
        'status': 1,
        'timestamp': DateTime.now(),
        'identityVerified': false,
        'identityImg1': null,
        'identityImg2': null,
        'userType': 1,
      });
    } catch (e) {
      debugPrint("[Firestore User Collection Creation] ${e.toString()}");
    }
  }

  Future _createAuth() async {
    try {
      setState(() => _isLoading = true);
      bool _isError = false;
      await _auth
          .createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      ).catchError(
            (onError) {
          debugPrint("Error ===> ${onError.code}");
          _isError = true;
          if (onError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
            showCustomFlash(
              context: context,
              title: 'Failed',
              message: 'Email Already in Use!',
            );
            setState(() => _isLoading = false);
          } else {
            showCustomFlash(
              context: context,
              title: 'Failed',
              message: 'Something went wrong!',
            );
          }
        },
      ).then((AuthResult value) async {
        if (!_isError) {
          UserUpdateInfo userUpdateInfo = UserUpdateInfo();
          userUpdateInfo.displayName = _name.text;
          await value.user.updateProfile(userUpdateInfo).then((_) async {
            value.user.sendEmailVerification();
            await _fetchUserDetailsFromFireStore();
          });
        }
      });
    } catch (e) {
      debugPrint("[Resistration] ${e.toString()}");
    }
  }


}
