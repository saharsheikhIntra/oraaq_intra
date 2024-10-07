import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oraaq/src/core/constants/string_constants.dart';

extension OnNum on num {
  radius() => Radius.circular(toDouble());

  //
  // BORDER RADIUS
  //

  BorderRadius get borderRadius => BorderRadius.circular(toDouble());

  BorderRadius get topBorderRadius => BorderRadius.only(topLeft: Radius.circular(toDouble()), topRight: Radius.circular(toDouble()));
  BorderRadius get bottomBorderRadius => BorderRadius.only(bottomLeft: Radius.circular(toDouble()), bottomRight: Radius.circular(toDouble()));
  BorderRadius get leftBorderRadius => BorderRadius.only(topLeft: Radius.circular(toDouble()), bottomLeft: Radius.circular(toDouble()));
  BorderRadius get rightBorderRadius => BorderRadius.only(topRight: Radius.circular(toDouble()), bottomRight: Radius.circular(toDouble()));

  BorderRadius get topLeftBorderRadius => BorderRadius.only(topLeft: Radius.circular(toDouble()));
  BorderRadius get topRightBorderRadius => BorderRadius.only(topRight: Radius.circular(toDouble()));
  BorderRadius get bottomLeftBorderRadius => BorderRadius.only(bottomLeft: Radius.circular(toDouble()));
  BorderRadius get bottomRightBorderRadius => BorderRadius.only(bottomRight: Radius.circular(toDouble()));

  //
  // PADDING
  //

  EdgeInsets get allPadding => EdgeInsets.all(toDouble());

  EdgeInsets get leftPadding => EdgeInsets.only(left: toDouble());
  EdgeInsets get topPadding => EdgeInsets.only(top: toDouble());
  EdgeInsets get rightPadding => EdgeInsets.only(right: toDouble());
  EdgeInsets get bottomPadding => EdgeInsets.only(bottom: toDouble());

  EdgeInsetsDirectional get startPadding => EdgeInsetsDirectional.only(start: toDouble());
  EdgeInsetsDirectional get endPadding => EdgeInsetsDirectional.only(end: toDouble());

  EdgeInsets get horizontalPadding => EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets get verticalPadding => EdgeInsets.symmetric(vertical: toDouble());

  //

  String get currencyFormat => NumberFormat.simpleCurrency(name: StringConstants.rs).format(this);
}
