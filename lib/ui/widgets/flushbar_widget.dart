import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

Flushbar FlushbarWidget(BuildContext context, String text) {
  return Flushbar(
    duration: Duration(milliseconds: 4000),
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: Color(0xFFFF5C83),
    message: text,
  )..show(context);
}
