import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class LauncherUtil {
  static dialer(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  static link(
    String link, {
    LaunchMode mode = LaunchMode.externalApplication,
  }) async {
    Uri uri = Uri.parse(link);
    final bool nativeAppLaunchSucceeded = await launchUrl(
      uri,
      mode: mode,
    );
    if (!nativeAppLaunchSucceeded) {
      await launchUrl(
        uri,
        mode: mode,
      );
    }
  }

  static whatsapp(String body, {String? title, String? to}) async {
    String text = title != null ? "_*$title*_\n\n$body" : body;
    var url = to != null ? "https://wa.me/$to/?text=${Uri.parse(text)}" : "whatsapp://send?text=${Uri.parse(text)}!";
    link(url);
  }

  static sms({required String text, required String phone}) async {
    var url = "sms:$phone?body=$text";
    link(url);
  }

  static email({
    required String subject,
    required String body,
    String? to,
  }) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      query: to != null ? 'subject=$subject&body=$body&to=$to' : 'subject=$subject&body=$body',
    );

    final bool nativeAppLaunchSucceeded = await launchUrl(
      emailUri,
      mode: LaunchMode.externalNonBrowserApplication,
    );
    if (!nativeAppLaunchSucceeded) {
      await launchUrl(
        emailUri,
        mode: LaunchMode.inAppWebView,
      );
    }
  }

  static openMap(double latitude, double longitude) async {
    final String googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
    final String appleMapsUrl = "https://maps.apple.com/?q=$latitude,$longitude";

    var uri = Uri.parse(Platform.isIOS ? appleMapsUrl : googleMapsUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
