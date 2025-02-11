// import 'package:flutter/material.dart';
// import 'package:oraaq/src/config/themes/text_style_theme.dart';

// class PrivacyPolicyScreen extends StatelessWidget {
//   const PrivacyPolicyScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Privacy Policy'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             // _buildHeading('Privacy Policy'),
//             _buildParagraph('Effective Date: [Insert Date]'),
//             _buildHeading('1. Introduction'),
//             _buildParagraph(
//                 "Welcome to Oraaq.com (\"Website\"), owned and operated by Franchise Developers Pakistan Inc., a Delaware corporation, with its office located at 1901 Pennsylvania Ave NW, Suite 900-6, Washington DC, 20006 USA (\"Company,\" \"we,\" \"us,\" or \"our\"). By accessing or using Oraaq.com, you agree to comply with and be bound by these Terms and Conditions (\"Terms\") and our Privacy Policy. If you do not agree with these Terms, please do not use the Website."),
//             _buildHeading('2. Use of the Website'),
//             _buildSubParagraph(
//                 'Eligibility You must be at least 18 years old to use our Website. By using the Website, you represent and warrant that you meet this requirement.'),
//             _buildSubParagraph(
//                 'License: We grant you a limited, non-exclusive, non-transferable, and revocable license to use the Website for personal, non-commercial purposes.'),
//             _buildSubParagraph('Prohibited Activities: You agree not to:'),
//             _buildSubSubParagraph('Use the Website for any unlawful purpose;'),
//             _buildSubSubParagraph('Use the Website for any unlawful purpose;'),
//             _buildSubSubParagraph(
//                 "Interfere with the security, functionality, or performance of the Website."),
//             _buildHeading('3. Free Discount Coupons'),
//             _buildParagraph(
//                 "The Website offers free discount coupons to visitors. We do not guarantee the availability, accuracy, or quality of the discounts provided by third parties. Any disputes arising from third-party offers should be directed to the respective provider."),
//             _buildHeading('4. Data Collection and Privacy'),
//             _buildParagraph(
//                 "We collect basic information, including your name, email address, phone number, and city of residence. Your information is used to:"),
//             _buildSubParagraph('Provide and improve our services;'),
//             _buildSubParagraph(
//                 'Communicate with you regarding offers and updates;'),
//             _buildSubParagraph(
//                 'c. Business Transfers: In the event of a merger, acquisition, or sale of all or a portion of our assets, your information may be transferred as part of that transaction.'),
//             _buildHeading('5. Data Security'),
//             _buildParagraph(
//                 'We implement a variety of security measures to protect your personal information from unauthorized access, use, or disclosure. However, no method of transmission over the Internet or electronic storage is completely secure, so we cannot guarantee its absolute security.'),
//             _buildHeading('6. Your Choices'),
//             _buildSubParagraph(
//                 'a. Access and Update: You can access and update your personal information by logging into your account or contacting us directly.'),
//             _buildSubParagraph(
//                 'b. Opt-Out: You can opt-out of receiving marketing communications from us by following the unsubscribe instructions included in each email or by contacting us.'),
//             _buildSubParagraph(
//                 'c. Cookies: You can control the use of cookies through your browser settings.'),
//             _buildHeading("7. Children's Privacy"),
//             _buildParagraph(
//                 'Our Service is not intended for individuals under the age of 13. We do not knowingly collect personal information from children under 13. If we become aware that we have collected personal information from a child under 13, we will take steps to delete such information.'),
//             _buildHeading('8. Changes to This Privacy Policy'),
//             _buildParagraph(
//                 'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on our website. You are advised to review this Privacy Policy periodically for any changes.'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeading(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
//       child: Text(
//         text,
//         style: TextStyleTheme.headlineMedium,
//       ),
//     );
//   }

//   Widget _buildParagraph(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12.0),
//       child: Text(
//         text,
//         style: TextStyleTheme.bodyLarge,
//       ),
//     );
//   }

//   Widget _buildSubParagraph(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0, left: 16.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text('•'),
//           const SizedBox(width: 8.0),
//           Expanded(
//             child: Text(
//               text,
//               style: TextStyleTheme.bodyLarge,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSubSubParagraph(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 4.0, left: 32.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text('◦'),
//           const SizedBox(width: 8.0),
//           Expanded(
//             child: Text(
//               text,
//               style: TextStyleTheme.bodyLarge,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:oraaq/src/config/themes/text_style_theme.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildParagraph('Effective Date: [Insert Date]'),
            _buildHeading('1. Introduction'),
            _buildParagraph(
                'Franchise Developers Pakistan Inc. ("we," "us," or "our") is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you visit Oraaq.com.'),
            _buildHeading('2. Information We Collect'),
            _buildSubParagraph(
                'Personal Information: Name, email address, phone number, city of residence.'),
            _buildSubParagraph(
                'Automatically Collected Data: IP address, browser type, operating system, and browsing behavior.'),
            _buildHeading('3. How We Use Your Information'),
            _buildSubParagraph('To provide and manage our services;'),
            _buildSubParagraph(
                'To communicate with you about offers and updates;'),
            _buildSubParagraph('To comply with legal obligations.'),
            _buildHeading('4. Sharing of Information'),
            _buildParagraph(
                'We do not sell or rent your personal information. We may share information with:'),
            _buildSubParagraph('Service providers assisting with operations;'),
            _buildSubParagraph('Legal authorities if required by law;'),
            _buildSubParagraph('Third parties with your consent.'),
            _buildHeading('5. Data Security'),
            _buildParagraph(
                'We implement security measures to protect your personal information from unauthorized access, disclosure, alteration, or destruction.'),
            _buildHeading('6. Your Rights'),
            _buildSubParagraph(
                'GDPR Rights: Access, rectify, erase, restrict processing, data portability, and withdraw consent.'),
            _buildSubParagraph(
                'California Privacy Rights: If applicable, you may request information about our data practices.'),
            _buildHeading('7. Cookies'),
            _buildParagraph(
                'We use cookies to enhance your experience. You can control cookie settings through your browser.'),
            _buildHeading('8. Third-Party Links'),
            _buildParagraph(
                'Our Website may contain links to third-party websites. We are not responsible for their privacy practices.'),
            _buildHeading('9. Children\'s Privacy'),
            _buildParagraph(
                'Our Website is not intended for individuals under 18. We do not knowingly collect data from minors.'),
            _buildHeading('10. Changes to This Policy'),
            _buildParagraph(
                'We may update this Privacy Policy periodically. Please review it regularly.'),
            _buildHeading('11. Contact Us'),
            _buildParagraph(
                'For any questions about this Privacy Policy, contact us at:'),
            _buildParagraph('Franchise Developers Pakistan Inc.\n'
                '1901 Pennsylvania Ave NW, Suite 900-6\n'
                'Washington DC, 20006 USA\n'
                'Email: info at oraaq dot com'),
          ],
        ),
      ),
    );
  }

  Widget _buildHeading(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        text,
        style: TextStyleTheme.headlineMedium,
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        text,
        style: TextStyleTheme.bodyLarge,
      ),
    );
  }

  Widget _buildSubParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('•'),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              text,
              style: TextStyleTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
