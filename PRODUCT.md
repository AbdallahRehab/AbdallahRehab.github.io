# Product

<!-- impeccable:product-schema 1 -->

## Platform

web

## Users

Two audiences, treated with roughly equal weight:

- **Full-time hiring**: recruiters and hiring managers screening candidates for senior Flutter/mobile engineer roles, deciding whether to reach out or schedule an interview.
- **Freelance/contract clients**: founders or teams evaluating whether to hire Abdallah as a contractor for a mobile app build, deciding whether to start a conversation.

Both groups are doing rapid credibility assessment — scanning for evidence of real scale, real ownership, and real engineering rigor rather than a generic bio.

## Product Purpose

A personal portfolio site for Abdallah Ali Rehab, Senior Mobile Engineer (Flutter), built with Flutter Web. It exists to convert a visitor's attention into a reach-out — an email, a CV download, or a follow-through to LinkedIn/GitHub — by presenting verifiable case studies and career impact rather than a conventional resume page. Success is a visitor deciding to make contact (via the contact form, `mailto:`, or downloading the CV) because they trust the evidence presented.

## Positioning

6+ years building Flutter apps for Android & iOS that serve millions of users, spanning the full lifecycle — architecture, performance, application security, and delivery — not just feature implementation. Distinguishing evidence a generic "Flutter developer" listing could not truthfully copy:
- Has taken products from zero to production (Doam: architecture, CI/CD, and coding standards for a government partnership, 1.2M+ users).
- Has hardened live apps against reverse engineering and MiTM attacks with an explicit threat model (WalaPlus).
- Combines this with a deliberate AI-augmented engineering workflow — framed as an accelerator for the mechanical parts of the job, not a replacement for engineering judgment.
- Currently modernizing a legacy healthcare-grade codebase (Saudi German Health) under compliance and reliability constraints.

## Operating Context

- Content for case studies is data-driven: `assets/config.json` holds project context/challenge/contribution/impact/technologies/store links, editable without touching Dart code.
- Copy for Hero/About/Experience/Skills is sourced from Abdallah's CV and lives directly in the corresponding widgets under `lib/features/`, not in shared config.
- The CV is served as a static file at the site root (`web/cv.pdf`) and downloaded via `Uri.base.resolve('cv.pdf')`.
- Contact happens two ways: an in-page form that opens a `mailto:` draft to abdorehab95@gmail.com, and direct social links (LinkedIn, GitHub) in the hero/footer.
- Theme preference (dark/light) persists via `shared_preferences`; dark is the default (`isDarkMode` defaults to `true`).
- Deployed to GitHub Pages via GitHub Actions on push to `main`; manual build is `flutter build web --release --base-href "/"`.

## Capabilities and Constraints

- Fully responsive across Mobile/Tablet/Desktop, including a dedicated mobile navigation menu (`responsive_framework`).
- Keyboard-focusable, semantically labeled interactive elements (buttons, nav links) rather than mouse-only gesture detectors.
- Current visual system deliberately avoids glassmorphism and heavy gradients (see Brand Commitments) — a custom `AppTheme` with theme-aware tokens instead.
- No formal accessibility standard (e.g. WCAG level) has been confirmed as a requirement; the README's accessibility claims are the current bar, not an externally audited one.

## Brand Commitments

- Name and title stay fixed: **Abdallah Ali Rehab — Senior Mobile Engineer · Flutter**, along with the current role/company facts (MEGAMIND IT Solutions, Cairo; prior WalaPlus, Riyadh; WEDDnGO, Nasr City).
- `assets/config.json` is the sole source of truth for project/case-study data — future work must never invent, embellish, or add project facts, metrics, or clients outside it.
- The current no-glassmorphism / no-heavy-gradients constraint applies to the *current* visual system; it is not locked against a deliberate future redesign (the user marked other stylistic choices open, not binding, for future work).

## Evidence on Hand

- Six real case studies in `assets/config.json`: WalaOne (3M+ users), Doam (1.2M+ users, government partnership), Saudi German Health (3.5M+ users, current role), WalaPlus (4M+ users), WEDDnGO (Egypt's largest wedding marketplace, Shark Tank Egypt), PDentalCore (freelance, end-to-end delivery).
- Career timeline with dated roles and quantified impact per role (`lib/features/about/timeline_section.dart`).
- Aggregate impact metrics: 7M+ combined active users, 60% faster load times, 90% test coverage, 70% fewer bug reports (`lib/features/impact/impact_section.dart`).
- CV file at `web/cv.pdf`; avatar image at `assets/images/avatar.jpg`.
- No testimonials, press quotes (beyond the factual Shark Tank Egypt mention), or client logos are present — future work must not fabricate any.

## Product Principles

1. Every claim on the site must trace to real, verifiable data (config.json, CV, timeline) — never invented metrics, testimonials, or clients.
2. Lead with evidence of ownership and scale (users served, measurable impact, greenfield-to-production stories), not generic skill lists.
3. Serve full-time recruiters and freelance/contract prospects with the same content, without splitting the site into separate tracks.
4. Keep the AI-augmented workflow framed as engineering judgment plus acceleration, never as a substitute for hands-on expertise.
5. Accessibility and responsiveness are baseline requirements for every section, not an afterthought pass.

## Accessibility & Inclusion

Keyboard-focusable and semantically labeled interactive elements are an established practice on this site (see Capabilities and Constraints), but no specific standard (e.g. WCAG 2.1 AA) has been confirmed as a binding requirement.
