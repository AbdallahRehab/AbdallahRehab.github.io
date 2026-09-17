# Abdallah Ali Rehab Portfolio

A premium personal portfolio website built with Flutter Web, showcasing the work and experience of Abdallah Ali Rehab, Senior Mobile Engineer (Flutter).

## 🌟 Live Demo

[View Portfolio](https://AbdallahRehab.github.io/)

## ✨ Features

- **Dark/Light Theme**: Fully theme-aware across every section, with the preference persisted via `shared_preferences`.
- **Fully Responsive**: Adaptive layout for Mobile, Tablet, and Desktop, including a dedicated mobile navigation menu.
- **Accessible Interactions**: Keyboard-focusable, semantically labeled buttons and nav links (not just mouse-only gesture detectors).
- **Case-Study Projects**: Each project is presented as a real case study — context, challenge, contribution, impact, and technologies — not just a name and screenshot.

### 🚀 Sections

1. **Hero**: Name, role, a concise positioning statement, a scannable metrics strip, and CTAs for CV/contact.
2. **About**: Evidence-based narrative (scale, performance, security, ownership) instead of generic bio copy.
3. **Experience**: Reverse-chronological career timeline with measurable impact per role.
4. **Skills**: Technologies grouped into meaningful categories (Architecture, Security, DevOps, AI-assisted engineering, etc.) rather than a flat icon list.
5. **Projects**: Case-study cards that open into a detailed modal (context/challenge/contribution/impact/technologies/store links).
6. **Contact**: Direct email form (`mailto:`) plus social links.

## 🛠️ Tech Stack

- **Framework**: [Flutter Web](https://flutter.dev/multi-platform/web) (Stable Channel)
- **Animations**: [Flutter Animate](https://pub.dev/packages/flutter_animate)
- **Responsive Breakpoints**: [responsive_framework](https://pub.dev/packages/responsive_framework)
- **Styling**: Custom theme system (`AppTheme`), no glassmorphism/heavy gradients
- **Icons**: FontAwesome & Material Icons
- **Typography**: Google Fonts (Outfit)

## 📂 Project Structure

```text
lib/
├── core/
│   ├── theme/          # AppTheme (theme-aware color tokens)
│   └── widgets/        # Reusable widgets (GlassButton, SocialIcon, PortfolioAppBar, etc.)
├── features/
│   ├── home/           # Hero section, Starfield background, Skills
│   ├── about/          # About narrative, Experience timeline
│   ├── projects/       # Project grid and case-study modal
│   └── contact/        # Contact form
└── main.dart           # Entry point, section ordering, scroll/nav wiring
```

Project case-study content lives in `assets/config.json` — update it to add/remove/edit projects without touching Dart code.

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (Latest Stable)
- Dart SDK

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/AbdallahRehab/AbdallahRehab.github.io.git
   cd AbdallahRehab.github.io
   ```

2. **Install Dependencies**

   ```bash
   flutter pub get
   ```

3. **Run Locally**

   ```bash
   flutter run -d chrome
   ```

## 📦 Deployment

### GitHub Pages (Automated)

This project is configured with GitHub Actions for automatic deployment.
Any push to the `main` branch will trigger a build and deploy to GitHub Pages.

**Manual Build:**

```bash
flutter build web --release --base-href "/"
```

## ⚙️ Customization

- **Projects**: Add/remove/edit case studies in `assets/config.json` (context, challenge, contribution, impact, technologies, store links).
- **Hero/About/Experience/Skills copy**: Edit directly in their respective widgets under `lib/features/`, since they're sourced from the CV rather than a shared config.
- **Theme colors**: `lib/core/theme/app_theme.dart`.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Built with Flutter by [Abdallah Ali Rehab](https://github.com/AbdallahRehab)
