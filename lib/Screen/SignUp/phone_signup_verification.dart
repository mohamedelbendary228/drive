import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_taxi_app_driver/Components/custom_flash.dart';
import 'package:flutter_taxi_app_driver/Components/ink_well_custom.dart';
import 'package:flutter_taxi_app_driver/theme/style.dart';
import 'package:flutter_taxi_app_driver/utils/prefs.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import '../../app_router.dart';

class PhoneSignUpVerification extends StatefulWidget {
  final String phoneNumber;
  final String name;

  const PhoneSignUpVerification({
    Key key,
    @required this.phoneNumber,
    @required this.name,
  }) : super(key: key);

  @override
  _PhoneSignUpVerificationState createState() =>
      _PhoneSignUpVerificationState();
}

class _PhoneSignUpVerificationState extends State<PhoneSignUpVerification> {
  TextEditingController controller = TextEditingController();
  String thisText = "";
  int pinLength = 6;
  String verificationCode;
  String _smsCode;

  bool hasError = false;
  String errorMessage;

  @override
  void initState() {
    _sendCode(widget.phoneNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: whiteColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: blackColor,
          ),
          onPressed: () =>
              Navigator.of(context).pushReplacementNamed(AppRoute.loginScreen),
        ),
      ),
      body: SingleChildScrollView(
          child: InkWellCustom(
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 0.0, 20, 0.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 10.0),
                      child: Text(
                        'Phone Verification',
                        style: heading35Black,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 0.0),
                      child: Text('Enter your OTP code hear'),
                    ),
                    Center(
                      child: PinCodeTextField(
                        autofocus: true,
                        controller: controller,
                        hideCharacter: false,
                        highlight: true,
                        highlightColor: secondary,
                        defaultBorderColor: blackColor,
                        hasTextBorderColor: primaryColor,
                        maxLength: pinLength,
                        pinBoxWidth: 40,
                        hasError: hasError,
                        maskCharacter: "*",
                        onTextChanged: (text) {
                          setState(() {
                            hasError = false;
                          });
                        },
                        onDone: (text) {
                          print("DONE ===> $text");
                          _smsCode = text;
                          showCustomFlash(
                            context: context,
                            title: 'Please Wait',
                            message: 'Verifying..',
                            icon: Icons.verified_user,
                          );
                          _verifySignInWithPhoneNumber(_smsCode);
                        },
                        wrapAlignment: WrapAlignment.start,
                        pinBoxDecoration:
                        ProvidedPinBoxDecoration.underlinedPinBoxDecoration,
                        pinTextStyle: heading35Black,
                        pinTextAnimatedSwitcherTransition:
                        ProvidedPinBoxTextAnimation.scalingTransition,
                        pinTextAnimatedSwitcherDuration:
                        Duration(milliseconds: 300),
                      ),
                    ),
                    SizedBox(height: 20),
                    ButtonTheme(
                      height: 50.0,
                      minWidth: MediaQuery
                          .of(context)
                          .size
                          .width - 50,
                      child: RaisedButton.icon(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15.0)),
                        elevation: 0.0,
                        color: primaryColor,
                        icon: new Text(''),
                        label: new Text(
                          'VERIFY NOW',
                          style: headingWhite,
                        ),
                        onPressed: () {
                          _verifySignInWithPhoneNumber(_smsCode);
                        },
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new InkWell(
                              onTap: () =>
                                  Navigator.of(context)
                                      .pushNamed(AppRoute.loginScreen),
                              child: new Text(
                                "I didn't get a code",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        )),
                  ]),
            ),
          )),
    );
  }

  Future _verifySignInWithPhoneNumber(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationCode,
      smsCode: smsCode,
    );
    _bloc(credential: credential);
  }

  Future _bloc({AuthCredential credential}) async {
    var auth = FirebaseAuth.instance;
    try {
      await auth.signInWithCredential(credential).then((signIn) async {
        print('*************** SUCCESS ****************');
        final FirebaseUser currentUser = await auth.currentUser();
        //call http method........*.........*........*........*.........*........*
        showCustomFlash(
          context: context,
          title: 'Success',
          message: 'Signup Successfully!',
        );
        _fetchUserDetailsFromFireStore();
        print(
            'Current User UID: ${currentUser.uid} & Phone Number: ${currentUser
                .phoneNumber}');
      });
    } catch (e) {
      showCustomFlash(
        context: context,
        title: 'Failed',
        message: 'Please Try Again',
      );
    }
  }

  _sendCode(String phoneNumber) async {
    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      verificationCode = verificationId;
      showCustomFlash(
        context: context,
        title: 'Sent',
        message: 'Code Sent Successfully!',
        icon: Icons.perm_phone_msg,
      );
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      showCustomFlash(
          context: context,
          title: 'Success',
          message: 'Auto retrieval time out',
          icon: Icons.timer_off
      );
    };
    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      var status;
      status = '${authException.message}';
      print("Error message: " + status);
      if (authException.message.contains('not authorized'))
        status = 'Something has gone wrong, please try later';
      else if (authException.message.contains('Network'))
        status = 'Please check your internet connection and try again';
      else
        status = 'Something has gone wrong, please try later';
      showCustomFlash(
        context: context,
        title: 'Error',
        message: status,
      );
    };
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential credential) async {
      _bloc(credential: credential);
    };
    var firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(seconds: 60),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  Future _fetchUserDetailsFromFireStore() async {
    debugPrint("===> _fetchUserDetailsFromFireStore");
    try {
      await Firestore.instance
          .collection('users')
          .where('phone', isEqualTo: widget.phoneNumber)
          .getDocuments()
          .then((value) {
        debugPrint("Value ===> ${value.documents[0]['name']}");
        showCustomFlash(
          context: context,
          title: 'Success',
          message: 'Logged In Successfully!',
        );
        setUserVerification(
            isVerified: value.documents[0].data['identityVerified']);
        setPhoneUserPref(userId: value.documents[0].documentID,
            phone: value.documents[0]['phone'])
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
        'email': null,
        'name': widget.name,
        'password': null,
        'phone': widget.phoneNumber,
        'status': 1,
        'timestamp': DateTime.now(),
        'identityVerified': false,
        'identityImg1': null,
        'identityImg2': null,
      });
    } catch (e) {
      debugPrint("[Firestore User Collection Creation] ${e.toString()}");
    }
  }
}
