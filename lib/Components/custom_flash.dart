import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showCustomFlash({
  @required BuildContext context,
  @required String title,
  @required String message,
  IconData icon = Icons.info_outline,
}) {
  showFlash(
    context: context,
    duration: Duration(seconds: 2),
    builder: (context, controller) {
      return Flash(
        controller: controller,
        style: FlashStyle.floating,
        position: FlashPosition.top,
        backgroundColor: Theme.of(context).primaryColor,
        boxShadows: kElevationToShadow[4],
        horizontalDismissDirection: HorizontalDismissDirection.horizontal,
        child: FlashBar(
          title: Text(title),
          icon: Icon(
            icon,
            color: Colors.white,
          ),
          message: Text(message),
        ),
      );
    },
  );
}
