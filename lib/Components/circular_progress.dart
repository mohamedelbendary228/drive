import 'package:flutter/material.dart';
import 'package:flutter_taxi_app_driver/theme/style.dart';

class CircularProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(loadingColor),
      ),
    );
  }
}
