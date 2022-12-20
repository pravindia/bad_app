import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

/// Contains constraints for the app.
abstract class AppConstraints {
  AppConstraints._();

  /// The smallest size the space between the elements.
  ///
  /// `equals to 5.0`
  static const smallSpace = 5.0;

  /// The medium size the space between the elements.
  ///
  /// `equals to 10.0`
  static const mediumSpace = 10.0;

  /// The large size the space between the elements.
  ///
  /// `equals to 15.0`
  static const largeSpace = 15.0;

  /// The extra large size the space between the elements.
  ///
  /// `equals to 20.0`
  static const extraLargeSpace = 20.0;

  /// This is the maximum width a [TextField] or [TextFormField]
  /// can take.
  static const double maxTextFieldWidth = 300.0;

  /// This is border radius of [TextField] or [TextFormField]
  static const double inputFieldOutlineBorderRadius = 10.0;

  /// bmi is <18.5
  static const double underWeightBMI = 18.5;

  /// bmi is >18.5 and <=24.9
  static const Tuple2 normalWeightBMI = Tuple2(18.5, 24.9);

  /// bmi is >24.9 and <=29.9
  static const Tuple2 overWeightBMI = Tuple2(24.9, 29.9);

  /// bmi is >29.9 and <=34.9
  static const Tuple2 obeseWeightBMI = Tuple2(29.9, 34.9);

  /// bmi is >34.9
  static const double extremelyObeseWeightBMI = 34.9;

  /// weight color when bmi is <18.5
  static const Color underWeightColor = Color(0xff86b1d9);

  /// weight color when bmi is >18.5 and <=24.9
  static const Color normalWeightColor = Color(0xff3fd364);

  /// weight color when bmi is >24.9 and <=29.9
  static const Color overWeightColor = Color(0xffeee134);

  /// weight color when bmi is >29.9 and <=34.9
  static const Color obeseWeightColor = Color(0xfffc7f2f);

  /// weight color when bmi is >34.9
  static const Color extremelyObeseWeightColor = Color(0xfff95453);
}
