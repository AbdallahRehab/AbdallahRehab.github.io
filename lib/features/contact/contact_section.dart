import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_button.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final email = _emailController.text;
      final message = _messageController.text;

      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'abdorehab95@gmail.com',
        query: _encodeQueryParameters(<String, String>{
          'subject': 'Portfolio Contact: $name',
          'body': 'Name: $name\nEmail: $email\n\nMessage:\n$message',
        }),
      );

      try {
        if (await canLaunchUrl(emailLaunchUri)) {
          await launchUrl(emailLaunchUri);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Opening email client...'),
                backgroundColor: AppTheme.neonCyan,
              ),
            );
          }
        } else {
          throw 'Could not launch email client';
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Could not open email client. Please email manually to abdorehab95@gmail.com',
              ),
              backgroundColor: AppTheme.neonPink,
            ),
          );
        }
      }
    }
  }

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              Text(
                'Have a mobile product\nthat needs to scale?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppTheme.textColor(context),
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ).animate().fadeIn().slideY(begin: 0.2, end: 0),

              const SizedBox(height: 16),

              Text(
                'Let\'s build something reliable, fast, and production-ready.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppTheme.textColorSecondary(context)),
              ).animate().fadeIn(delay: 80.ms),

              const SizedBox(height: 40),

              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: AppTheme.cardColor(context),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppTheme.borderColor(context)),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField(
                        controller: _nameController,
                        label: 'Name',
                        icon: Icons.person_outline,
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        controller: _emailController,
                        label: 'Email',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        controller: _messageController,
                        label: 'Message',
                        icon: Icons.message_outlined,
                        maxLines: 5,
                      ),
                      const SizedBox(height: 32),
                      GlassButton(
                        text: 'Send Message',
                        icon: Icons.send_rounded,
                        onPressed: _submitForm,
                      ),
                      const SizedBox(height: 24),
                      TextButton.icon(
                        onPressed: () {
                          launchUrl(Uri.parse('mailto:abdorehab95@gmail.com'));
                        },
                        icon: Icon(
                          Icons.email,
                          color: AppTheme.textColorSecondary(context),
                        ),
                        label: Text(
                          'Or email me directly at abdorehab95@gmail.com',
                          style: TextStyle(
                            color: AppTheme.textColorSecondary(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: TextStyle(color: AppTheme.textColor(context)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppTheme.textColorSecondary(context)),
        prefixIcon: Icon(icon, color: AppTheme.primaryColor(context)),
        filled: true,
        fillColor: AppTheme.borderColor(context).withValues(alpha: 0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.borderColor(context)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.primaryColor(context)),
        ),
      ),
    );
  }
}
