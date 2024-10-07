import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

enum SocialSignInEnum {
  google(
    "google.com",
    "google",
    LineIcons.googlePlus,
  ),
  apple(
    "apple.com",
    "apple",
    LineIcons.apple,
  ),
  facebook(
    "facebook.com",
    "facebook",
    LineIcons.facebook,
  );

  final String id;
  final String name;
  final IconData icon;

  const SocialSignInEnum(
    this.id,
    this.name,
    this.icon,
  );
}
