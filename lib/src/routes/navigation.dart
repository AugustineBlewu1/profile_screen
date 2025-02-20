import 'package:flutter/material.dart';

//extending the navigation using the build context
extension Navigation on BuildContext {
  push(Widget? screen) {
    Navigator.push<void>(
      this,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => screen!,
      ),
    );
  }
}
