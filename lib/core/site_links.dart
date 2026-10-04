/// Every outbound destination in one place so hero, contact and footer can
/// never drift apart.
class SiteLinks {
  SiteLinks._();

  static const email = 'abdorehab95@gmail.com';
  static const linkedIn =
      'https://www.linkedin.com/in/abdallah-ali-rehab-a71246153';
  static const gitHub = 'https://github.com/AbdallahRehab';
  static const x = 'https://x.com/abdallahrehab2';
  static const whatsApp = 'https://wa.me/2001559292997';

  /// Served as a static file at the site root (web/cv.pdf), resolved against
  /// the current origin so it works both locally and on the deployed domain.
  static Uri get cv => Uri.base.resolve('cv.pdf');
}
