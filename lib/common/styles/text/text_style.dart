import 'package:flutter/material.dart';

enum AppTextStyle {
  semiBold20(
    TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w600,
      fontSize: 20,
      height: 1.2,
    ),
  ),
  semiBold24(
    TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w600,
      fontSize: 24,
      height: 1.2,
    ),
  ),
  semiBold31(
    TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w600,
      fontSize: 31,
      height: 1.2,
    ),
  ),
  semiBold36(
    TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w600,
      fontSize: 36,
      height: 1.2,
    ),
  ),
  semiBold40(
    TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w600,
      fontSize: 40,
      height: 1.2,
    ),
  ),
  semiBold48(
    TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w600,
      fontSize: 48,
      height: 1.2,
    ),
  ),
  semiBold60(
    TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w600,
      fontSize: 60,
      height: 1.2,
    ),
  ),
  semiBold64(
    TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w600,
      fontSize: 64,
      height: 1.2,
    ),
  ),
  regular8(
    TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w400,
      fontSize: 8,
      height: 1.2,
    ),
  ),
  regular11(
    TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w400,
      fontSize: 11,
      height: 1.2,
    ),
  ),
  regular12(
    TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 1.2,
    ),
  ),
  regular13(
    TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w400,
      fontSize: 13,
      height: 1.2,
    ),
  ),
  regular14(
    TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 1.2,
    ),
  ),
  regular15(
    TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w400,
      fontSize: 15,
      height: 1.2,
    ),
  ),
  regular16(
    TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 1.2,
    ),
  ),
  regular20(
    TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w400,
      fontSize: 20,
      height: 1.2,
    ),
  ),
  regular22(
    TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w400,
      fontSize: 22,
      height: 1.2,
    ),
  ),
  regular24(
    TextStyle(
      fontFamily: 'VK Sans Display',
      fontWeight: FontWeight.w400,
      fontSize: 24,
      height: 1.2,
    ),
  ),
  regular32(
    TextStyle(
      fontFamily: 'VK Sans Display',
      fontWeight: FontWeight.w400,
      fontSize: 32,
      height: 1.2,
    ),
  ),
  regular40(
    TextStyle(
      fontFamily: 'VK Sans Display',
      fontWeight: FontWeight.w400,
      fontSize: 40,
      height: 1.2,
    ),
  ),
  medium15(
    TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w500,
      fontSize: 15,
      height: 1.2,
    ),
  ),
  medium13(
    TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w500,
      fontSize: 13,
      height: 1.2,
    ),
  ),
  medium16(
    TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 1.2,
    ),
  ),
  medium20(
    TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w500,
      fontSize: 20,
      height: 1.2,
    ),
  ),
  medium24(
    TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w500,
      fontSize: 24,
      height: 1.2,
    ),
  );

  const AppTextStyle(this.value);
  final TextStyle value;
}
