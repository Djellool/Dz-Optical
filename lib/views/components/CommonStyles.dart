import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class CommonStyles {
  final Color blue = Color(0xFF041E59);
  final Color green = Color(0xFF01AFB5);
  final Color white = Color(0xFFFFFFFF);
  final Color grey = Color(0xFF7A8AA3);
  final Color coldgreen = Color(0xFF3E9DAC);

  final Shader linearGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: <Color>[Color(0xFF041E59), Color(0xFF01AFB5)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 120));

  static BoxDecoration buttonDeco() {
    return BoxDecoration(
        gradient: LinearGradient(
          colors: [CommonStyles().green, CommonStyles().blue],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        shape: BoxShape.circle);
  }

  static BoxDecoration buttonDecoSqaure() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [CommonStyles().green, CommonStyles().blue],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    );
  }

  static textDecoration(BuildContext context, String label, Icon icon) {
    return InputDecoration(
      labelStyle: TextStyle(
          color: CommonStyles().blue,
          fontFamily: "Nunito",
          fontWeight: FontWeight.bold,
          fontSize: 18),
      labelText: label,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: CommonStyles().blue,
          width: 2.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: CommonStyles().blue,
        ),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
    );
  }
}
