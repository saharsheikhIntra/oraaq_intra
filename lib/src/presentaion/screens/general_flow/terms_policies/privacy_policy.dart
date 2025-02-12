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
            // _buildHeading('Privacy Policy'),
            _buildParagraph(
                'Franchise Developers Pakistan Inc. is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you visit Oraaq.com.'),
            _buildHeading('1. Introduction'),
            _buildParagraph(
                'Franchise Developers Pakistan Inc. ("we," "us," or "our") is dedicated to protecting your privacy. This Privacy Policy outlines how we handle your personal information.'),
            _buildHeading('2. Information We Collect'),
            _buildSubParagraph(
                '• Personal Information: Name, email address, phone number, city of residence.'),
            _buildSubParagraph(
                '• Automatically Collected Data: IP address, browser type, operating system, and browsing behavior.'),
            _buildHeading('3. How We Use Your Information'),
            _buildSubParagraph('• To provide and manage our services;'),
            _buildSubParagraph(
                '• To communicate with you about offers and updates;'),
            _buildSubParagraph('• To comply with legal obligations.'),
            _buildHeading('4. Sharing of Information'),
            _buildParagraph(
                'We do not sell or rent your personal information. We may share information with:'),
            _buildSubParagraph(
                '• Service providers assisting with operations;'),
            _buildSubParagraph('• Legal authorities if required by law;'),
            _buildSubParagraph('• Third parties with your consent.'),
            _buildHeading('5. Data Security'),
            _buildParagraph(
                'We implement security measures to protect your personal information from unauthorized access, disclosure, alteration, or destruction.'),
            _buildHeading('6. Your Rights'),
            _buildSubParagraph(
                '• GDPR Rights: Access, rectify, erase, restrict processing, data portability, and withdraw consent.'),
            _buildSubParagraph(
                '• California Privacy Rights: If applicable, you may request information about our data practices.'),
            _buildHeading('7. Cookies'),
            _buildParagraph(
                'We use cookies to enhance your experience. You can control cookie settings through your browser.'),
            _buildHeading('8. Third-Party Links'),
            _buildParagraph(
                'Our Website may contain links to third-party websites. We are not responsible for their privacy practices.'),
            _buildHeading("9. Children's Privacy"),
            _buildParagraph(
                'Our Website is not intended for individuals under 18. We do not knowingly collect data from minors.'),
            _buildHeading('10. Changes to This Policy'),
            _buildParagraph(
                'We may update this Privacy Policy periodically. Please review it regularly.'),
            _buildHeading('11. Contact Us'),
            _buildParagraph(
                'For any questions about this Privacy Policy, contact us at:'),
            _buildParagraph('Franchise Developers Pakistan Inc.'),
            _buildParagraph(
                '1901 Pennsylvania Ave NW, Suite 900-6, Washington DC, 20006 USA'),
            _buildParagraph('Email: info at oraaq dot com'),
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
