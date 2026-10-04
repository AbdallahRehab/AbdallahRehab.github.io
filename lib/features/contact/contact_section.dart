import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/site_links.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/buttons.dart';
import '../../core/widgets/motion.dart';
import '../../core/widgets/pressable.dart';
import '../../core/widgets/section.dart';

/// The closing inverse band: bone in dark mode, olive-black in light mode.
/// A direct email action and outbound links on the left, a short form that
/// drafts an email on the right.
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
  static final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _toast(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final message = _messageController.text.trim();
    final uri = Uri(
      scheme: 'mailto',
      path: SiteLinks.email,
      query:
          <String, String>{
                'subject': 'Portfolio contact: $name',
                'body': 'Name: $name\nEmail: $email\n\n$message',
              }.entries
              .map(
                (e) =>
                    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
              )
              .join('&'),
    );
    try {
      final opened = await launchUrl(uri);
      if (!opened) throw StateError('no mail client');
      if (mounted) _toast('Opening your email app with the message drafted…');
    } catch (_) {
      if (mounted) {
        _toast(
          "Couldn't open an email app. Write to ${SiteLinks.email} directly.",
        );
      }
    }
  }

  Future<void> _copyEmail() async {
    await Clipboard.setData(const ClipboardData(text: SiteLinks.email));
    if (mounted) _toast('Email address copied');
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Section(
      background: p.inverse,
      topRule: false,
      paddingTop: AppType.fluid(context, 72, 152),
      paddingBottom: AppType.fluid(context, 72, 152),
      child: LayoutBuilder(
        builder: (context, c) {
          final wide = c.maxWidth > 900;
          final pitch = _Pitch(onCopy: _copyEmail);
          final form = Reveal(
            delay: const Duration(milliseconds: 150),
            child: _ContactForm(
              formKey: _formKey,
              name: _nameController,
              email: _emailController,
              message: _messageController,
              emailPattern: _emailPattern,
              onSubmit: _submitForm,
            ),
          );
          if (!wide) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [pitch, const SizedBox(height: 56), form],
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 11, child: pitch),
              SizedBox(width: AppType.fluid(context, 40, 96)),
              Expanded(flex: 8, child: form),
            ],
          );
        },
      ),
    );
  }
}

class _Pitch extends StatelessWidget {
  final VoidCallback onCopy;

  const _Pitch({required this.onCopy});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final size = AppType.fluid(context, 40, 84);
    final links = <(IconData, String, VoidCallback)>[
      (
        FontAwesomeIcons.linkedinIn.data,
        'LinkedIn',
        () => Pressable.open(SiteLinks.linkedIn),
      ),
      (
        FontAwesomeIcons.github.data,
        'GitHub',
        () => Pressable.open(SiteLinks.gitHub),
      ),
      (
        FontAwesomeIcons.whatsapp.data,
        'WhatsApp',
        () => Pressable.open(SiteLinks.whatsApp),
      ),
      (FontAwesomeIcons.xTwitter.data, 'X', () => Pressable.open(SiteLinks.x)),
      (
        Icons.download_rounded,
        'Download CV',
        () => launchUrl(SiteLinks.cv, mode: LaunchMode.externalApplication),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Reveal(
          child: Semantics(
            header: true,
            headingLevel: 2,
            child: Text(
              'Have a mobile product that needs to scale?',
              style: AppType.h2(context).copyWith(
                fontSize: size,
                letterSpacing: -size * 0.045,
                height: 1,
                color: p.onInverse,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Reveal(
          delay: const Duration(milliseconds: 80),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Text(
              "Let's build something reliable, fast, and production-ready — "
              'whether you are hiring for a senior Flutter role or need an '
              'app built.',
              style: AppType.lead(context).copyWith(color: p.onInverseMuted),
            ),
          ),
        ),
        const SizedBox(height: 40),
        Reveal(
          delay: const Duration(milliseconds: 140),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              PillButton(
                label: SiteLinks.email,
                icon: Icons.mail_outline_rounded,
                variant: PillVariant.inverse,
                large: true,
                semanticLabel: 'Email ${SiteLinks.email}',
                onPressed: () =>
                    launchUrl(Uri(scheme: 'mailto', path: SiteLinks.email)),
              ),
              CircleIconButton(
                icon: Icons.content_copy_rounded,
                semanticLabel: 'Copy email address',
                size: 52,
                onInverse: true,
                onPressed: onCopy,
              ),
            ],
          ),
        ),
        const SizedBox(height: 48),
        Reveal(
          delay: const Duration(milliseconds: 200),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 24),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: p.onInverse.withValues(alpha: 0.15)),
              ),
            ),
            child: Wrap(
              spacing: 28,
              runSpacing: 12,
              children: [
                for (final (icon, label, onTap) in links)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon, size: 15, color: p.onInverse),
                      const SizedBox(width: 8),
                      InlineLink(
                        label: label,
                        onTap: onTap,
                        underline: p.onInverse,
                        style: AppType.ui(
                          context,
                          size: 15,
                        ).copyWith(color: p.onInverse),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ContactForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController message;
  final RegExp emailPattern;
  final VoidCallback onSubmit;

  const _ContactForm({
    required this.formKey,
    required this.name,
    required this.email,
    required this.message,
    required this.emailPattern,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final error = p.onInverseError;

    InputDecoration deco(String label, String hint) => InputDecoration(
      labelText: label,
      hintText: hint,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      // Floating labels render at 75%, so these land at ~12px.
      labelStyle: AppType.label(
        context,
        color: p.onInverseMuted,
      ).copyWith(fontSize: 16, letterSpacing: 1.6),
      floatingLabelStyle: AppType.label(
        context,
        color: p.onInverse,
      ).copyWith(fontSize: 16, letterSpacing: 1.6),
      hintStyle: AppType.body(context).copyWith(color: p.onInverseMuted),
      errorStyle: AppType.caption(context).copyWith(color: error),
      contentPadding: const EdgeInsets.only(top: 14, bottom: 12),
      enabledBorder: UnderlineInputBorder(
        // 50% keeps the field boundary above 3:1 against the band.
        borderSide: BorderSide(color: p.onInverse.withValues(alpha: 0.5)),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: p.onInverse, width: 1.5),
      ),
      errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: error)),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: error, width: 1.5),
      ),
    );

    final textStyle = AppType.body(
      context,
      size: 17,
    ).copyWith(color: p.onInverse);

    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: p.onInverse,
          selectionColor: p.accent.withValues(alpha: 0.5),
        ),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Or send a note',
              style: AppType.h3(context).copyWith(color: p.onInverse),
            ),
            const SizedBox(height: 8),
            Text(
              'It opens your email app with the message ready to send.',
              style: AppType.body(
                context,
                size: 14.5,
              ).copyWith(color: p.onInverseMuted),
            ),
            const SizedBox(height: 28),
            TextFormField(
              controller: name,
              style: textStyle,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.name],
              decoration: deco('Name', 'Your name'),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Add your name so I know who is writing.'
                  : null,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: email,
              style: textStyle,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.email],
              decoration: deco('Email', 'you@company.com'),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Add an email so I can reply.';
                }
                if (!emailPattern.hasMatch(v.trim())) {
                  return 'That email looks incomplete — check for typos.';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: message,
              style: textStyle,
              minLines: 3,
              maxLines: 6,
              decoration: deco('Message', 'What are you building?'),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Tell me a little about the project or role.'
                  : null,
            ),
            const SizedBox(height: 32),
            PillButton(
              label: 'Draft email',
              icon: Icons.north_east_rounded,
              variant: PillVariant.inverse,
              onPressed: onSubmit,
            ),
          ],
        ),
      ),
    );
  }
}
