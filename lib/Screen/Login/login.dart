import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_taxi_app_driver/Components/circular_progress.dart';
import 'package:flutter_taxi_app_driver/Components/custom_flash.dart';
import 'package:flutter_taxi_app_driver/Components/ink_well_custom.dart';
import 'package:flutter_taxi_app_driver/Components/validations.dart';
import 'package:flutter_taxi_app_driver/Screen/SignUp/phone_signup_verification.dart';
import 'package:flutter_taxi_app_driver/providers/login_service.dart';
import 'package:flutter_taxi_app_driver/theme/style.dart';
import 'package:flutter_taxi_app_driver/utils/prefs.dart';
import 'package:provider/provider.dart';
import '../../app_router.dart';


class LoginScreen extends StatefulWidget with ChangeNotifier{
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool autovalidate = false;
  Validations validations = new Validations();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _emailPassword = TextEditingController();
  TextEditingController _email = TextEditingController();
  CountryCode _currentCountry;
  bool _isPhone = false;
  bool _isLoading = false;
  final _auth = FirebaseAuth.instance;

  submit() async {
    final FormState form = formKey.currentState;
    if (!form.validate()) {
      autovalidate = true; // Start validating on every change.
    } else {
      form.save();
      if (_isPhone)
        _loginWithPhone();
      else
        _loginWithEmail();
//      Navigator.push(
//        context,
//        MaterialPageRoute(
//          builder: (BuildContext context) => PhoneVerification(
//            phoneNumber: "${_currentCountry.dialCode}${_phoneNumber.text}",
//          ),
//        ),
//      );
      //code
//      Navigator.of(context)
//          .pushReplacementNamed(AppRoute.phoneVerificationScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    final myProvider =Provider.of<LoginService>(context);

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
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      _isPhone
                          ? Container(
                        //padding: EdgeInsets.only(top: 100.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(7.0),
                          elevation: 5.0,
                          child: Container(
                            width:
                            MediaQuery
                                .of(context)
                                .size
                                .width - 20.0,
                            height:
                            MediaQuery
                                .of(context)
                                .size
                                .height * 0.5,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.circular(20.0)),
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
                                      'Login',
                                      style: heading35Black,
                                    ),
                                    Column(
                                      children: [
                                        TextFormField(
                                          controller: _phoneNumber,
                                          keyboardType:
                                          TextInputType.phone,
                                          validator: (value) {
                                            if (value.length < 6) {
                                              return 'Mobile Number must be correct';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10.0),
                                            ),
                                            prefixIcon: CountryCodePicker(
                                              onChanged: _onCountryChange,
                                              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                              initialSelection: 'AU',
                                              // optional. Shows only country name and flag
                                              showCountryOnly: false,
                                              // optional. Shows only country name and flag when popup is closed.
                                              showOnlyCountryWhenClosed:
                                              false,
                                              showFlag: false,
                                              // optional. aligns the flag and the Text left
                                              alignLeft: false,
                                              textStyle: TextStyle(
                                                color: Theme
                                                    .of(context)
                                                    .primaryColor,
                                              ),
                                              onInit: _setInitialCountry,
                                            ),
                                            contentPadding:
                                            EdgeInsets.only(
                                                left: 15.0,
                                                top: 15.0),
                                            hintText: 'xxx-xxx-xxxx',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: GestureDetector(
                           /////////////////////////////////provider///////////////////////////
                                            onTap: () =>
                                               setState(
                                                        () => _isPhone = false),
                                            child: Text(
                                              'Login with Email',
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
                                        duration:
                                        Duration(milliseconds: 500),
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
                                              'LOGIN',
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
                      )
                          : Container(
                        //padding: EdgeInsets.only(top: 100.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(7.0),
                          elevation: 5.0,
                          child: Container(
                            width:
                            MediaQuery
                                .of(context)
                                .size
                                .width - 20.0,
                            height:
                            MediaQuery
                                .of(context)
                                .size
                                .height * 0.5,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.circular(20.0)),
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
                                      'Login',
                                      style: heading35Black,
                                    ),
                                    Column(
                                      children: [
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
                                            contentPadding:
                                            EdgeInsets.only(
                                                left: 15.0,
                                                top: 15.0),
                                            hintText: 'Email',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        TextFormField(
                                          obscureText: true,
                                          controller: _emailPassword,
                                          validator: validations
                                              .validatePassword,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10.0),
                                            ),
                                            contentPadding:
                                            EdgeInsets.only(
                                                left: 15.0,
                                                top: 15.0),
                                            hintText: 'Password',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: GestureDetector(
                         /////////////////////////////////provider///////////////////////////
                                        onTap: () =>
                                            setState(() => _isPhone = true),
                                        child: Text(
                                          'Login with Phone',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Theme
                                                .of(context)
                                                .accentColor,
                                          ),
                                        ),
                                      ),
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
                                        duration:
                                        Duration(milliseconds: 500),
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
                                              'LOGIN',
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
                                onTap: () => _bottomSheet(context: context),
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

  void _onCountryChange(CountryCode countryCode) {
    print("New Country selected: " + countryCode.toString());
    _currentCountry = countryCode;
  }

  void _setInitialCountry(CountryCode value) {
    _currentCountry = value;
  }

  _bottomSheet({BuildContext context}) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        context: context,
        builder: (context) {
          return Container(
            height: 250,
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Signup',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 2,
                  shadowColor: Theme
                      .of(context)
                      .primaryColor,
                  child: ListTile(
                    title: Text('Email'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                     Navigator.pop(context);
                      Navigator.of(context).pushNamed(AppRoute.signUpScreen);
                    },
                  ),
                ),
                Card(
                  elevation: 2,
                  shadowColor: Theme
                      .of(context)
                      .primaryColor,
                  child: ListTile(
                    title: Text('Phone'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context)
                          .pushNamed(AppRoute.phoneSignupScreen);
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _loginWithEmail() {
    setState(() => _isLoading = true);
    bool _isError = false;
    _auth
        .signInWithEmailAndPassword(
      email: _email.text,
      password: _emailPassword.text,
    )
        .catchError(
          (onError) {
        debugPrint("Error ===> ${onError.code}");
        _isError = true;
        if (onError.code == 'ERROR_USER_NOT_FOUND') {
          showCustomFlash(
            context: context,
            title: 'Failed',
            message: 'User Not Found',
          );
          /////////////////////////////////provider///////////////////////////
          setState(() => _isLoading = false);
        } else if (onError.code == 'ERROR_WRONG_PASSWORD') {
          showCustomFlash(
            context: context,
            title: 'Failed',
            message: 'Wrong Email or Password',
          );
          /////////////////////////////////provider///////////////////////////
          setState(() => _isLoading = false);
        } else {
          showCustomFlash(
            context: context,
            title: 'Failed',
            message: 'Something went wrong!',
          );
          /////////////////////////////////provider///////////////////////////
          setState(() => _isLoading = false);
        }
      },
    ).then((AuthResult value) async {
      print('Login:: ===> isVerified ${value.user.isEmailVerified}');
      if (!_isError) {
        await _fetchUserDetailsFromFireStore();
      }
    });
  }

  Future _fetchUserDetailsFromFireStore() async {
    try {
      await Firestore.instance
          .collection('users')
          .where('email', isEqualTo: _email.text)
          .getDocuments()
          .then((value) {
        /////////////////////////////////provider///////////////////////////
        setState(() {
          _isLoading = false;
          _email.text = '';
          _emailPassword.text = '';
        });
        showCustomFlash(
          context: context,
          title: 'Success',
          message: 'Account Login Successfully!',
        );
        setEmailUserPref(userId: value.documents[0].documentID,
            email: value.documents[0]['email'])
            .then((_) {
          setUserVerification(
              isVerified: value.documents[0].data['identityVerified']);
          if (value.documents[0]['identityImg1'] == null ||
              value.documents[0]['identityImg2'] == null) {
            setVerifyImgCheck(isChecked: false);
            Navigator.of(context).pushReplacementNamed(
                AppRoute.identityCheckScreen);
          } else {
            setVerifyImgCheck(isChecked: true);
            Navigator.of(context).pushReplacementNamed(AppRoute.introScreen);
          }
        });
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
        'name': "",
        'password': _emailPassword.text,
        'phone': null,
        'status': 1,
        'timestamp': DateTime.now(),
      });
    } catch (e) {
      debugPrint("[Firestore User Collection Creation] ${e.toString()}");
    }
  }

  Future<void> _loginWithPhone() async {
    final FormState form = formKey.currentState;
    if (!form.validate()) {
      autovalidate = true; // Start validating on every change.
    } else {
      form.save();
      String phNo = _phoneNumber.text;
      if (_phoneNumber.text.substring(0, 1) == '0') {
        phNo = _phoneNumber.text.substring(1, _phoneNumber.text.length);
      }
      debugPrint(" =====>>> ${_currentCountry.dialCode}$phNo");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              PhoneSignUpVerification(
                phoneNumber: "${_currentCountry.dialCode}$phNo}",
                name: "",
              ),
        ),
      );
    }
  }
}
