import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const basic300 = Color(0xffE6E6E6);
const laneGreen = Color(0xff26C438);
const basic1000 = Color(0xff0A0A0A);

SvgPicture iconSearch({Color? color, double? size}) => SvgPicture.asset(
      'assets/svg/icon_search.svg',
      color: color,
      width: size,
      height: size,
    );

SvgPicture iconSort({Color? color, double? size}) => SvgPicture.asset(
      'assets/svg/icon_sort.svg',
      color: color,
      width: size ?? 16,
      height: size ?? 16,
    );

SvgPicture iconFilter({Color? color, double? size}) => SvgPicture.asset(
      'assets/svg/icon_filter.svg',
      color: color,
      width: size,
      height: size,
    );

ButtonStyle applyButtonStyle = TextButton.styleFrom(
    padding: const EdgeInsets.all(12),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: const BorderSide(color: laneGreen, width: 1)),
    textStyle: const TextStyle(color: laneGreen, fontSize: 18),
    onSurface: laneGreen,
    primary: laneGreen);
