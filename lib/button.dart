import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddButton extends StatelessWidget {
  final String text;
  VoidCallback handler;

  AddButton(this.text, this.handler, {super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: handler,
            child: Text(text),
          )
        : TextButton(
            onPressed: handler,
            child: Text(text),
          );
  }
}
