enum SocialSignInEnum {
  google(
    "google.com",
    "google",
    'assets/images/google.png',
    'assets/images/gmail.png',
  ),
  // apple(
  //   "apple.com",
  //   "apple",
  //   'assets/images/apple.png',
  //   'assets/images/apple.png',
  // ),
  facebook(
    "facebook.com",
    "facebook",
    'assets/images/facebook.png',
    'assets/images/facebook.png',
  );

  final String id;
  final String name;
  final String iconPath;
  final String iosIconPath;

  const SocialSignInEnum(
    this.id,
    this.name,
    this.iconPath,
    this.iosIconPath,
  );
}
