import 'package:shared_preferences/shared_preferences.dart';

Future setPhoneUserPref({String userId, String phone}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("userId", userId);
  await prefs.setBool("primarySource", false);
  await prefs.setString("phone", phone);
}

Future setEmailUserPref({String userId, String email}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("userId", userId);
  await prefs.setBool("primarySource", true);
  await prefs.setString("email", email);
}

Future setUserBasicInfoPref({String name, String image}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("name", name);
  await prefs.setString("image", image);
}

Future setVerifyImgCheck({bool isChecked}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool("isChecked", isChecked);
}

Future<bool> getVerifyImgCheck() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool("isChecked");
}

Future<String> getUserIdPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("userId");
}

Future<String> getUserImagePref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("image");
}

Future<String> getUserNamePref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("name");
}

Future<bool> getUserVerification() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool("isUserVerified");
}

Future setUserVerification({bool isVerified}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool("isUserVerified", isVerified);
}

Future<bool> getUserPrimarySourcePref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool("primarySource");
}

Future<String> getUserEmailPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("email");
}

Future<String> getUserPhonePref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("phone");
}

Future clearPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("userId", null);
  await prefs.setBool("primarySource", null);
  await prefs.setString("phone", null);
  await prefs.setString("email", null);
  await prefs.setString("name", null);
  await prefs.setString("image", null);
}
