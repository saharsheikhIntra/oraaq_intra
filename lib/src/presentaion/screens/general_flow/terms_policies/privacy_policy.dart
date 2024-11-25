import 'package:flutter/material.dart';
import 'package:oraaq/src/config/themes/app_theme.dart';
import 'package:oraaq/src/config/themes/text_style_theme.dart';
import 'package:oraaq/src/core/extensions/num_extension.dart';

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
            // _buildHeading('Privacy Policy'),
            _buildParagraph('Effective Date: [Insert Date]'),
            _buildHeading('1. Introduction'),
            _buildParagraph(
                'Welcome to oraaq.com . We are dedicated to protecting your privacy and ensuring your personal information is managed safely and responsibly. This Privacy Policy outlines how we collect, use, disclose, and protect your information when you use our listings and coupon service.'),
            _buildHeading('2. Information We Collect'),
            _buildParagraph(
                'We may collect the following types of information:'),
            _buildSubParagraph(
                'a. Personal Information: When you register for our Service, we may collect personal information such as your name, email address, phone number, and mailing address.'),
            _buildSubParagraph(
                'b. Payment Information: If you make a purchase or subscribe to our Service, we collect payment details such as credit card information, billing address, and other necessary information to process your payment.'),
            _buildSubParagraph(
                'c. Usage Data: We collect information about how you interact with our Service, including your IP address, browser type, access times, pages viewed, and the referring URL.'),
            _buildSubParagraph(
                'd. Cookies and Similar Technologies: We use cookies and similar tracking technologies to collect data about your browsing activities. You can control the use of cookies through your browser settings.'),
            _buildHeading('3. How We Use Your Information'),
            _buildSubParagraph(
                'a. To Provide and Improve Our Service: We use your information to operate, maintain, and improve our Service, including personalizing your experience.'),
            _buildSubParagraph(
                'b. To Process Transactions: We use your information to process payments and deliver the products or services you request.'),
            _buildSubParagraph(
                'c. To Communicate with You: We use your contact information to send you updates, promotional materials, and other communications related to our Service. You can opt-out of receiving marketing communications at any time.'),
            _buildSubParagraph(
                'd. To Analyze and Improve Our Service: We use usage data to understand how our Service is used and to improve its performance and functionality.'),
            _buildHeading('4. Information Sharing and Disclosure'),
            _buildParagraph(
                'We do not sell, trade, or otherwise transfer your personal information to outside parties, except as described below:'),
            _buildSubParagraph(
                'a. Service Providers: We may share your information with third-party service providers who help us operate our business, such as payment processors and email service providers.'),
            _buildSubParagraph(
                'b. Legal Requirements: We may disclose your information if required to do so by law or in response to valid requests by public authorities.'),
            _buildSubParagraph(
                'c. Business Transfers: In the event of a merger, acquisition, or sale of all or a portion of our assets, your information may be transferred as part of that transaction.'),
            _buildHeading('5. Data Security'),
            _buildParagraph(
                'We implement a variety of security measures to protect your personal information from unauthorized access, use, or disclosure. However, no method of transmission over the Internet or electronic storage is completely secure, so we cannot guarantee its absolute security.'),
            _buildHeading('6. Your Choices'),
            _buildSubParagraph(
                'a. Access and Update: You can access and update your personal information by logging into your account or contacting us directly.'),
            _buildSubParagraph(
                'b. Opt-Out: You can opt-out of receiving marketing communications from us by following the unsubscribe instructions included in each email or by contacting us.'),
            _buildSubParagraph(
                'c. Cookies: You can control the use of cookies through your browser settings.'),
            _buildHeading("7. Children's Privacy"),
            _buildParagraph(
                'Our Service is not intended for individuals under the age of 13. We do not knowingly collect personal information from children under 13. If we become aware that we have collected personal information from a child under 13, we will take steps to delete such information.'),
            _buildHeading('8. Changes to This Privacy Policy'),
            _buildParagraph(
                'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on our website. You are advised to review this Privacy Policy periodically for any changes.'),
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
