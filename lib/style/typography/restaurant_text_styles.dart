import 'package:flutter/widgets.dart';

class RestaurantTextStyles {
  static const TextStyle _commonStyle = TextStyle(
    fontFamily: 'IBMPlexSansCondensed',
  );

  static TextStyle displayLarge = _commonStyle.copyWith(
    fontSize: 57,
    fontWeight: FontWeight.w700,
    height: 1.11,
    letterSpacing: -2,
  );

  static TextStyle displayMedium = _commonStyle.copyWith(
    fontSize: 45,
    fontWeight: FontWeight.w600,
    height: 1.17,
    letterSpacing: -1,
  );

  static TextStyle displaySmall = _commonStyle.copyWith(
    fontSize: 36,
    fontWeight: FontWeight.w500,
    height: 1.25,
    letterSpacing: -1,
  );

  static TextStyle headlineLarge = _commonStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    height: 1.5,
    letterSpacing: -1,
  );

  static TextStyle headlineMedium = _commonStyle.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: -1,
  );

  static TextStyle headlineSmall = _commonStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    height: 1.0,
    letterSpacing: -1,
  );

  static TextStyle titleLarge = _commonStyle.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 1.2,
  );

  static TextStyle titleMedium = _commonStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.2,
    letterSpacing: 1.2,
  );

  static TextStyle titleSmall = _commonStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    height: 1.2,
    letterSpacing: 1.2,
  );

  static TextStyle bodyLargeBold = _commonStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.56,
  );

  static TextStyle bodyLargeMedium = _commonStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    height: 1.56,
  );

  static TextStyle bodyLargeRegular = _commonStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w200,
    height: 1.56,
  );

  static TextStyle labelLarge = _commonStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    height: 1.71,
    letterSpacing: 1.3,
  );

  static TextStyle labelMedium = _commonStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w200,
    height: 1.4,
    letterSpacing: 1.3,
  );

  static TextStyle labelSmall = _commonStyle.copyWith(
    fontSize: 11,
    fontWeight: FontWeight.w100,
    height: 1.2,
    letterSpacing: 1.3,
  );
}
