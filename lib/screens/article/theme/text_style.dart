import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recything_mobile/screens/article/theme/color_style.dart';

class ThemeText {
  TextStyle heading6Medium = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: ThemeColor().blackColor,
  );

  TextStyle bodySmallMedium = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: ThemeColor().dark3Color,
  );

  TextStyle bodySmallRegular = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: ThemeColor().grayScale900,
  );

  TextStyle bodySmallRegular2 = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: ThemeColor().mainColor,
  );

  TextStyle bodySmallRegular3 = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: ThemeColor().dark3Color,
  );

  TextStyle bodyNormalSemiBold = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: ThemeColor().blackColor,
  );

  TextStyle bodyNormalMedium = GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: ThemeColor().grayScale900);
}
