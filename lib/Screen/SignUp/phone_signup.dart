import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_taxi_app_driver/Components/ink_well_custom.dart';
import 'package:flutter_taxi_app_driver/Components/validations.dart';
import 'package:flutter_taxi_app_driver/Screen/SignUp/phone_signup_verification.dart';
import 'package:flutter_taxi_app_driver/theme/style.dart';


class PhoneSignUpScreen extends StatefulWidget {
  @override
  _PhoneSignUpScreenState createState() => _PhoneSignUpScreenState();
}

class _PhoneSignUpScreenState extends State<PhoneSignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool autoValidate = false;
  Validations validations = Validations();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _name = TextEditingController();
  CountryCode _currentCountry;

  submit() async {
    final FormState form = formKey.currentState;
    if (!form.validate()) {
      autoValidate = true; // Start validating on every change.
    } else {
      form.save();
      debugPrint(" =====>>> ${_currentCountry.dialCode}${_phoneNumber.text}");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => PhoneSignUpVerification(
            phoneNumber: "${_currentCountry.dialCode}${_phoneNumber.text}",
            name: _name.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: InkWellCustom(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
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
                                      'Sign Up',
                                      style: heading35Black,
                                    ),
                                    Column(
                                      children: [
                                        TextFormField(
                                          controller: _phoneNumber,
                                          keyboardType: TextInputType.phone,
                                          maxLength: 10,
                                          validator: validations.validateMobile,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            prefixIcon: CountryCodePicker(
                                              onChanged: _onCountryChange,
                                              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                              initialSelection: 'AU',
                                              // optional. Shows only country name and flag
                                              showCountryOnly: false,
                                              // optional. Shows only country name and flag when popup is closed.
                                              showOnlyCountryWhenClosed: false,
                                              showFlag: false,
                                              // optional. aligns the flag and the Text left
                                              alignLeft: false,
                                              textStyle: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              onInit: _setInitialCountry,
                                            ),
                                            contentPadding: EdgeInsets.only(
                                                left: 15.0, top: 15.0),
                                            hintText: 'xxx-xxx-xxxx',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          controller: _name,
                                          validator: validations.validateName,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            prefixIcon: Icon(
                                              Icons.person_outline,
                                            ),
                                            contentPadding: EdgeInsets.only(
                                                left: 15.0, top: 15.0),
                                            hintText: 'Fullname',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    ButtonTheme(
                                      height: 50.0,
                                      minWidth:
                                          MediaQuery.of(context).size.width,
                                      child: RaisedButton.icon(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                        elevation: 0.0,
                                        color: primaryColor,
                                        icon: Text(''),
                                        label: Text(
                                          'NEXT',
                                          style: headingWhite,
                                        ),
                                        onPressed: () {
                                          submit();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      )),
                      Container(
                          padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Already have an account? ",
                                style: textGrey,
                              ),
                              InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Text(
                                  "Login",
                                  style: textStyleActive,
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ])
          ]),
        ),
      ),
    );
  }

  void _onCountryChange(CountryCode countryCode) {
    print("Country selected: " + countryCode.toString());
    _currentCountry = countryCode;
  }

  void _setInitialCountry(CountryCode value) {
    _currentCountry = value;
  }
}
