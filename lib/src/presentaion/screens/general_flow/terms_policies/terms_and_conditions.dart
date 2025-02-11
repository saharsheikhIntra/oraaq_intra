// import 'package:flutter/material.dart';
// import 'package:oraaq/src/config/themes/text_style_theme.dart';

// class TermsAndConditionsScreen extends StatelessWidget {
//   const TermsAndConditionsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Terms and Conditions'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             // _buildHeading('Terms and Conditions'),
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
//             _buildSubParagraph("Provide and improve our services;"),
//             _buildSubParagraph(
//                 "Communicate with you regarding offers and updates;"),
//             _buildSubParagraph("Comply with legal obligations."),
//             _buildParagraph(
//                 "For more details, please refer to our Privacy Policy below."),
//             _buildHeading('5. GDPR Compliance'),
//             _buildParagraph(
//                 "If you are a resident of the European Economic Area (EEA), you have certain data protection rights:"),
//             _buildSubParagraph(
//                 "The right to access, update, or delete your personal information;"),
//             _buildSubParagraph("•	The right to data portability;"),
//             _buildSubParagraph("•	The right to withdraw consent at any time."),
//             _buildHeading('6. DMCA Compliance'),
//             _buildParagraph(
//                 "We respect intellectual property rights. If you believe your copyrighted material has been infringed on our Website, please submit a DMCA notice to:"),
//             _buildParagraph("Franchise Developers Pakistan Inc.\n"
//                 "1901 Pennsylvania Ave NW, Suite 900-6\n"
//                 "Washington DC, 20006 USA\n"
//                 "Email: dmca [at] oraaq dot com"),
//             _buildParagraph("Your notice must include:"),
//             _buildSubParagraph("•	A description of the copyrighted work;"),
//             _buildHeading('DMCA Agent:'),
//             _buildParagraph(
//                 'You agree to indemnify, defend, and hold harmless [Your Company Name], its officers, directors, employees, and agents from and against any claims, liabilities, damages, losses, and expenses, including reasonable attorneys’ fees, arising out of or in any way connected with your use of our Service, your violation of these Terms, or your violation of any rights of another.'),
//             _buildHeading('8. Termination'),
//             _buildParagraph(
//                 'We may terminate or suspend your access to our Service, without prior notice or liability, for any reason, including if you breach these Terms. Upon termination, your right to use our Service will immediately cease.'),
//             _buildHeading('9. Governing Law'),
//             _buildParagraph(
//                 'These Terms shall be governed by and construed in accordance with the laws of [Your Jurisdiction], without regard to its conflict of law provisions.'),
//             _buildHeading('10. Changes to These Terms'),
//             _buildParagraph(
//                 'We may update these Terms from time to time. We will notify you of any changes by posting the new Terms on our website. You are advised to review these Terms periodically for any changes. Your continued use of our Service after the posting of any changes constitutes your acceptance of those changes.'),
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

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildParagraph('Effective Date: [Insert Date]'),
            _buildHeading('1. Introduction'),
            _buildParagraph(
                'Welcome to Oraaq.com ("Website"), owned and operated by Franchise Developers Pakistan Inc., a Delaware corporation, with its office located at 1901 Pennsylvania Ave NW, Suite 900-6, Washington DC, 20006 USA ("Company," "we," "us," or "our"). By accessing or using Oraaq.com, you agree to comply with and be bound by these Terms and Conditions ("Terms") and our Privacy Policy. If you do not agree with these Terms, please do not use the Website.'),
            _buildHeading('2. Use of the Website'),
            _buildSubParagraph(
                'Eligibility: You must be at least 18 years old to use our Website. By using the Website, you represent and warrant that you meet this requirement.'),
            _buildSubParagraph(
                'License: We grant you a limited, non-exclusive, non-transferable, and revocable license to use the Website for personal, non-commercial purposes.'),
            _buildSubParagraph('Prohibited Activities: You agree not to:'),
            _buildSubSubParagraph('Use the Website for any unlawful purpose;'),
            _buildSubSubParagraph(
                'Attempt to gain unauthorized access to the Website or its related systems;'),
            _buildSubSubParagraph(
                'Interfere with the security, functionality, or performance of the Website.'),
            _buildHeading('3. Free Discount Coupons'),
            _buildParagraph(
                'The Website offers free discount coupons to visitors. We do not guarantee the availability, accuracy, or quality of the discounts provided by third parties. Any disputes arising from third-party offers should be directed to the respective provider.'),
            _buildHeading('4. Data Collection and Privacy'),
            _buildParagraph(
                'We collect basic information, including your name, email address, phone number, and city of residence. Your information is used to:'),
            _buildSubParagraph('Provide and improve our services;'),
            _buildSubParagraph(
                'Communicate with you regarding offers and updates;'),
            _buildSubParagraph('Comply with legal obligations.'),
            _buildParagraph(
                'For more details, please refer to our Privacy Policy below.'),
            _buildHeading('5. GDPR Compliance'),
            _buildParagraph(
                'If you are a resident of the European Economic Area (EEA), you have certain data protection rights:'),
            _buildSubParagraph(
                'The right to access, update, or delete your personal information;'),
            _buildSubParagraph('The right to data portability;'),
            _buildSubParagraph('The right to withdraw consent at any time.'),
            _buildParagraph(
                'To exercise these rights, please contact us at [Insert Contact Email].'),
            _buildHeading('6. DMCA Compliance'),
            _buildParagraph(
                'We respect intellectual property rights. If you believe your copyrighted material has been infringed on our Website, please submit a DMCA notice to:'),
            _buildHeading('DMCA Agent:'),
            _buildParagraph(
                'Franchise Developers Pakistan Inc.\n1901 Pennsylvania Ave NW, Suite 900-6\nWashington DC, 20006 USA\nEmail: dmca [at] oraaq dot com'),
            _buildParagraph('Your notice must include:'),
            _buildSubParagraph('A description of the copyrighted work;'),
            _buildSubParagraph('Identification of the infringing material;'),
            _buildSubParagraph('Your contact information;'),
            _buildSubParagraph(
                'A statement under penalty of perjury that your claim is accurate;'),
            _buildSubParagraph('Your electronic or physical signature.'),
            _buildHeading('7. Limitation of Liability'),
            _buildParagraph(
                'We are not liable for any direct, indirect, incidental, or consequential damages arising from your use of the Website or the discount coupons provided.'),
            _buildHeading('8. Changes to the Terms'),
            _buildParagraph(
                'We reserve the right to modify these Terms at any time. Changes will be effective immediately upon posting. Your continued use of the Website constitutes your acceptance of the updated Terms.'),
            _buildHeading('9. Governing Law'),
            _buildParagraph(
                'These Terms are governed by the laws of the State of Delaware, USA, without regard to its conflict of law principles.'),
            _buildHeading('10. Contact Information'),
            _buildParagraph(
                'For questions or concerns regarding these Terms or our Privacy Policy, please contact us at:'),
            _buildParagraph(
                'Franchise Developers Pakistan Inc.\n1901 Pennsylvania Ave NW, Suite 900-6\nWashington DC, 20006 USA\nEmail: info at oraaq dot com'),
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

  Widget _buildSubSubParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0, left: 32.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('◦'),
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
