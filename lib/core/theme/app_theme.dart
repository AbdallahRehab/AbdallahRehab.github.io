import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// "Moss Night" — bone ink on an olive-black ground, one phosphor-lime
/// signal, hairlines instead of shadows. Light mode ("Bone Day") keeps the
/// same roles on a bone ground and swaps text-set accent for a deep moss so
/// it clears WCAG AA; the lime itself stays as a fill with dark ink on it.
@immutable
class Palette extends ThemeExtension<Palette> {
  /// Page canvas.
  final Color ground;

  /// Recessed bands (footer, marquee strip).
  final Color recessed;

  /// Card / panel fill.
  final Color surface;

  /// Card fill on hover.
  final Color surfaceHover;

  /// Visible hairlines: dividers, outlines, chart gridlines.
  final Color line;

  /// Barely-there hairlines: section tops, row separators.
  final Color lineFaint;

  /// Primary text.
  final Color ink;

  /// Body copy / secondary text.
  final Color inkMuted;

  /// Captions, labels, axis ticks.
  final Color inkFaint;

  /// Lime signal used as a FILL (buttons, bars, dots). Always pair with
  /// [onAccent] for anything drawn on top of it.
  final Color accent;

  /// Accent used as TEXT or a thin line on [ground]. Equal to [accent] in
  /// dark mode; a deep moss in light mode for contrast.
  final Color accentInk;

  /// Accent for data marks and small graphics (chart bars, dots, nodes).
  /// Lime in dark mode; a deeper green in light mode so marks clear 3:1
  /// against the bone ground.
  final Color signal;

  /// Ink drawn on top of an [accent] fill.
  final Color onAccent;

  /// The inverse band (contact): its background and its ink.
  final Color inverse;
  final Color onInverse;
  final Color onInverseMuted;

  const Palette({
    required this.ground,
    required this.recessed,
    required this.surface,
    required this.surfaceHover,
    required this.line,
    required this.lineFaint,
    required this.ink,
    required this.inkMuted,
    required this.inkFaint,
    required this.accent,
    required this.accentInk,
    required this.signal,
    required this.onAccent,
    required this.inverse,
    required this.onInverse,
    required this.onInverseMuted,
  });

  static const dark = Palette(
    ground: Color(0xFF0E110C),
    recessed: Color(0xFF090B07),
    surface: Color(0xFF141811),
    surfaceHover: Color(0xFF191E15),
    line: Color(0xFF2C3326),
    lineFaint: Color(0xFF1B2017),
    ink: Color(0xFFEEF0E4),
    inkMuted: Color(0xFFA9AF9C),
    inkFaint: Color(0xFF858C78),
    accent: Color(0xFFC5F04A),
    accentInk: Color(0xFFC5F04A),
    signal: Color(0xFFC5F04A),
    onAccent: Color(0xFF0E110C),
    inverse: Color(0xFFEEF0E4),
    onInverse: Color(0xFF0E110C),
    onInverseMuted: Color(0xFF4E5343),
  );

  static const light = Palette(
    ground: Color(0xFFF3F2EA),
    recessed: Color(0xFFE9E8DD),
    surface: Color(0xFFFBFBF6),
    surfaceHover: Color(0xFFFFFFFF),
    line: Color(0xFFCFCFC0),
    lineFaint: Color(0xFFE2E1D5),
    ink: Color(0xFF151912),
    inkMuted: Color(0xFF4E5343),
    inkFaint: Color(0xFF6B6F5E),
    accent: Color(0xFFC5F04A),
    accentInk: Color(0xFF4D6B00),
    signal: Color(0xFF6E9410),
    onAccent: Color(0xFF0E110C),
    inverse: Color(0xFF0E110C),
    onInverse: Color(0xFFEEF0E4),
    onInverseMuted: Color(0xFFA9AF9C),
  );

  @override
  Palette copyWith() => this;

  @override
  Palette lerp(ThemeExtension<Palette>? other, double t) {
    if (other is! Palette) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return Palette(
      ground: l(ground, other.ground),
      recessed: l(recessed, other.recessed),
      surface: l(surface, other.surface),
      surfaceHover: l(surfaceHover, other.surfaceHover),
      line: l(line, other.line),
      lineFaint: l(lineFaint, other.lineFaint),
      ink: l(ink, other.ink),
      inkMuted: l(inkMuted, other.inkMuted),
      inkFaint: l(inkFaint, other.inkFaint),
      accent: l(accent, other.accent),
      accentInk: l(accentInk, other.accentInk),
      signal: l(signal, other.signal),
      onAccent: l(onAccent, other.onAccent),
      inverse: l(inverse, other.inverse),
      onInverse: l(onInverse, other.onInverse),
      onInverseMuted: l(onInverseMuted, other.onInverseMuted),
    );
  }
}

extension PaletteContext on BuildContext {
  Palette get palette => Theme.of(this).extension<Palette>()!;
  double get screenWidth => MediaQuery.sizeOf(this).width;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}

/// Type roles. Bricolage Grotesque carries every display moment (large,
/// tight, regular-to-medium weight); Hanken Grotesk carries everything a
/// visitor reads at length or scans as a label.
class AppType {
  AppType._();

  /// Fluid size: linearly interpolates between [min] at 390px and [max] at
  /// 1440px viewport width, clamped outside that range.
  static double fluid(BuildContext context, double min, double max) {
    final w = context.screenWidth;
    final t = ((w - 390) / (1440 - 390)).clamp(0.0, 1.0);
    return min + (max - min) * t;
  }

  /// Hero name. Used once per page.
  static TextStyle hero(BuildContext context) => GoogleFonts.bricolageGrotesque(
    fontSize: fluid(context, 46, 92),
    fontWeight: FontWeight.w500,
    height: 0.98,
    letterSpacing: -fluid(context, 46, 92) * 0.045,
    color: context.palette.ink,
  );

  /// Section titles.
  static TextStyle h2(BuildContext context) => GoogleFonts.bricolageGrotesque(
    fontSize: fluid(context, 36, 68),
    fontWeight: FontWeight.w500,
    height: 1.02,
    letterSpacing: -fluid(context, 36, 68) * 0.035,
    color: context.palette.ink,
  );

  /// Card titles, project names.
  static TextStyle h3(BuildContext context, {double? size}) {
    final s = size ?? fluid(context, 22, 26);
    return GoogleFonts.bricolageGrotesque(
      fontSize: s,
      fontWeight: FontWeight.w500,
      height: 1.15,
      letterSpacing: -s * 0.02,
      color: context.palette.ink,
    );
  }

  /// Big numerals (metrics, chart headline figures).
  static TextStyle numeral(BuildContext context, double size) =>
      GoogleFonts.bricolageGrotesque(
        fontSize: size,
        fontWeight: FontWeight.w500,
        height: 0.95,
        letterSpacing: -size * 0.04,
        color: context.palette.ink,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  static TextStyle body(BuildContext context, {double size = 16}) =>
      GoogleFonts.hankenGrotesk(
        fontSize: size,
        fontWeight: FontWeight.w400,
        height: 1.6,
        color: context.palette.inkMuted,
      );

  /// Lead paragraph under a heading.
  static TextStyle lead(BuildContext context) => GoogleFonts.hankenGrotesk(
    fontSize: fluid(context, 17, 19),
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: context.palette.inkMuted,
  );

  static TextStyle ui(BuildContext context, {double size = 14}) =>
      GoogleFonts.hankenGrotesk(
        fontSize: size,
        fontWeight: FontWeight.w500,
        height: 1.2,
        color: context.palette.ink,
      );

  /// Small uppercase tracked label (form fields, case-study row labels).
  static TextStyle label(BuildContext context, {Color? color}) =>
      GoogleFonts.hankenGrotesk(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1.2,
        letterSpacing: 1.7,
        color: color ?? context.palette.inkFaint,
      );

  static TextStyle caption(BuildContext context) => GoogleFonts.hankenGrotesk(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: context.palette.inkFaint,
    fontFeatures: const [FontFeature.tabularFigures()],
  );
}

/// Layout rhythm.
class Space {
  Space._();
  static const double maxWidth = 1200;
  static const double gap = 12;
  static const double radius = 6;
  static const double pill = 999;
  static const Duration fast = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 550);
  static const Curve expo = Cubic(0.16, 1, 0.3, 1);
  static const Curve easeOut = Cubic(0.2, 0.7, 0.2, 1);

  /// Horizontal page gutter: 16px on phones up to 32px on desktop.
  static double gutter(BuildContext context) => AppType.fluid(context, 16, 32);

  /// Vertical section padding.
  static double section(BuildContext context) =>
      AppType.fluid(context, 64, 120);
}

class AppTheme {
  AppTheme._();

  static ThemeData _build(Brightness brightness, Palette p) {
    final base = ThemeData(brightness: brightness, useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: p.ground,
      canvasColor: p.ground,
      colorScheme: ColorScheme.fromSeed(
        seedColor: p.accent,
        brightness: brightness,
        primary: p.accentInk,
        onPrimary: brightness == Brightness.dark ? p.onAccent : p.ground,
        surface: p.ground,
        onSurface: p.ink,
      ),
      textTheme: GoogleFonts.hankenGroteskTextTheme(
        base.textTheme,
      ).apply(bodyColor: p.ink, displayColor: p.ink),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: p.accentInk,
        selectionColor: p.accent.withValues(alpha: 0.35),
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) =>
              states.contains(WidgetState.hovered) ||
                  states.contains(WidgetState.dragged)
              ? p.inkFaint
              : p.line,
        ),
        thickness: const WidgetStatePropertyAll(6),
        radius: const Radius.circular(Space.pill),
        crossAxisMargin: 3,
      ),
      focusColor: p.accent.withValues(alpha: 0.18),
      hoverColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: p.ink,
          borderRadius: BorderRadius.circular(Space.radius),
        ),
        textStyle: GoogleFonts.hankenGrotesk(color: p.ground, fontSize: 12),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: p.ink,
        contentTextStyle: GoogleFonts.hankenGrotesk(color: p.ground),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Space.pill),
        ),
      ),
      extensions: [p],
    );
  }

  static ThemeData get darkTheme => _build(Brightness.dark, Palette.dark);
  static ThemeData get lightTheme => _build(Brightness.light, Palette.light);
}
