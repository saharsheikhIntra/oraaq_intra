import 'package:flutter/material.dart';
import 'package:oraaq/src/config/themes/text_style_theme.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

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
            // _buildHeading('Terms and Conditions'),
            _buildParagraph('Effective Date: [Insert Date]'),
            _buildHeading('1. Introduction'),
            _buildParagraph(
                'Welcome to pk.oraaq.com. These Terms and Conditions govern your use of our listings and coupon service. By accessing or using our Service, you agree to comply with and be bound by these Terms. If you disagree with these Terms, please do not use our Service.'),
            _buildHeading('2. Use of Service'),
            _buildSubParagraph(
                'a. Eligibility: You must be at least 18 years old to use our Service. By using our Service, you represent and warrant that you meet this age requirement.'),
            _buildSubParagraph(
                'b. Account Registration: To access certain features of our Service, you may need to register for an account. You agree to provide accurate, current, and complete information during the registration process and to update such information to keep it accurate, current, and complete. You are responsible for maintaining the confidentiality of your account password and for all activities that occur under your account.'),
            _buildSubParagraph(
                'c. Prohibited Activities: You agree not to use our Service for any unlawful purpose or in any way that could harm, disable, overburden, or impair our Service. You also agree not to use any automated means to access our Service, or to collect or harvest information from our Service without our prior written consent.'),
            _buildHeading('3. Listings and Coupons'),
            _buildSubParagraph(
                'a. Accuracy of Information: We strive to ensure that the information provided on our Service is accurate and up-to-date. However, we do not guarantee the accuracy, completeness, or reliability of any listings or coupons.'),
            _buildSubParagraph(
                'b. Expiration and Availability: Coupons and listings may be subject to expiration dates and availability. We are not responsible for any expired or unavailable offers.'),
            _buildSubParagraph(
                'c. Third-Party Links: Our Service may contain links to third-party websites or services that are not owned or controlled by us. We have no control over, and assume no responsibility for, the content, privacy policies, or practices of any third-party websites or services.'),
            _buildHeading('4. Payment and Subscriptions'),
            _buildSubParagraph(
                'a. Fees: Certain features of our Service may require payment of fees. All fees are non-refundable, unless otherwise stated.'),
            _buildSubParagraph(
                'b. Billing Information: You agree to provide accurate and complete billing information, including valid credit card information, and to update such information as necessary.'),
            _buildSubParagraph(
                'c. Recurring Payments: If you subscribe to a recurring payment plan, you authorize us to charge your payment method on a recurring basis for the subscription term you selected.'),
            _buildHeading('5. Intellectual Property'),
            _buildSubParagraph(
                'a. Ownership: The content, design, and other materials on our Service, including trademarks, logos, and service marks, are owned or licensed by us and are protected by intellectual property laws.'),
            _buildSubParagraph(
                'b. Limited License: We grant you a limited, non-exclusive, non-transferable license to access and use our Service for your personal, non-commercial use. You may not reproduce, distribute, modify, or create derivative works of our Service without our prior written consent.'),
            _buildHeading('6. Disclaimers and Limitation of Liability'),
            _buildSubParagraph(
                'a. Disclaimers: We make no warranties, express or implied, regarding the operation or availability of our Service, or the information, content, or materials included in our Service.'),
            _buildSubParagraph(
                'b. Limitation of Liability: To the fullest extent permitted by law, we disclaim all liability for any indirect, incidental, consequential, or punitive damages arising out of or in connection with your use of our Service. Our total liability to you for any claims arising from or related to our Service shall not exceed the amount you paid us, if any, in the past twelve months.'),
            _buildHeading('7. Indemnification'),
            _buildParagraph(
                'You agree to indemnify, defend, and hold harmless [Your Company Name], its officers, directors, employees, and agents from and against any claims, liabilities, damages, losses, and expenses, including reasonable attorneys’ fees, arising out of or in any way connected with your use of our Service, your violation of these Terms, or your violation of any rights of another.'),
            _buildHeading('8. Termination'),
            _buildParagraph(
                'We may terminate or suspend your access to our Service, without prior notice or liability, for any reason, including if you breach these Terms. Upon termination, your right to use our Service will immediately cease.'),
            _buildHeading('9. Governing Law'),
            _buildParagraph(
                'These Terms shall be governed by and construed in accordance with the laws of [Your Jurisdiction], without regard to its conflict of law provisions.'),
            _buildHeading('10. Changes to These Terms'),
            _buildParagraph(
                'We may update these Terms from time to time. We will notify you of any changes by posting the new Terms on our website. You are advised to review these Terms periodically for any changes. Your continued use of our Service after the posting of any changes constitutes your acceptance of those changes.'),
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
      child: Text(
        text,
        style: TextStyleTheme.bodyMedium,
      ),
    );
  }
}
