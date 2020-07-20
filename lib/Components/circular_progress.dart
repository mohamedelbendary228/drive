import 'package:flutter/material.dart';
import 'package:flutter_map_booking/theme/style.dart';

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
