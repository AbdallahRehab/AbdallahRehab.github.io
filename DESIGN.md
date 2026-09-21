---
name: Abdallah Ali Rehab Portfolio
description: A dark-first "Mission Control" portfolio for a senior Flutter engineer — precise, evidence-led, quietly technical.
colors:
  space-black: "#0B0B15"
  deep-space: "#1A1A2E"
  signal-cyan: "#00F0FF"
  alert-pink: "#FF007F"
  starlight: "#EAEAEA"
  mist: "#FAFAFA"
  paper: "#FFFFFF"
  ink: "#1A1A2E"
  ink-muted: "#5A5A6E"
  deep-teal: "#007A87"
  berry-rose: "#D81B60"
  hairline: "#E0E0E0"
typography:
  display:
    fontFamily: "Outfit, sans-serif"
    fontSize: "45px"
    fontWeight: 700
    lineHeight: 1.15
    letterSpacing: "0.5px"
  headline:
    fontFamily: "Outfit, sans-serif"
    fontSize: "36px"
    fontWeight: 700
    lineHeight: 1.2
    letterSpacing: "normal"
  title:
    fontFamily: "Outfit, sans-serif"
    fontSize: "22px"
    fontWeight: 700
    lineHeight: 1.3
    letterSpacing: "normal"
  body:
    fontFamily: "Outfit, sans-serif"
    fontSize: "16px"
    fontWeight: 400
    lineHeight: 1.7
    letterSpacing: "normal"
  label:
    fontFamily: "Outfit, sans-serif"
    fontSize: "12px"
    fontWeight: 600
    lineHeight: 1.3
    letterSpacing: "1.2px"
rounded:
  xs: "8px"
  sm: "12px"
  md: "20px"
  lg: "24px"
  pill: "30px"
spacing:
  xs: "4px"
  sm: "8px"
  md: "16px"
  lg: "20px"
  xl: "32px"
  2xl: "48px"
  3xl: "80px"
components:
  button-primary:
    backgroundColor: "rgba(0, 240, 255, 0.1)"
    textColor: "{colors.signal-cyan}"
    rounded: "{rounded.pill}"
    padding: "16px 32px"
  button-secondary:
    backgroundColor: "rgba(234, 234, 234, 0.05)"
    textColor: "{colors.starlight}"
    rounded: "{rounded.pill}"
    padding: "16px 32px"
  card-project:
    backgroundColor: "rgba(26, 26, 46, 0.5)"
    textColor: "{colors.starlight}"
    rounded: "{rounded.md}"
    padding: "20px"
  chip-tag:
    backgroundColor: "rgba(0, 240, 255, 0.1)"
    textColor: "{colors.signal-cyan}"
    rounded: "{rounded.xs}"
    padding: "4px 8px"
  input-field:
    textColor: "{colors.starlight}"
    rounded: "{rounded.sm}"
    padding: "16px"
  nav-link:
    textColor: "{colors.starlight}"
    typography: "{typography.label}"
    padding: "8px 12px"
---

# Design System: Abdallah Ali Rehab Portfolio

## Overview

**Creative North Star: "Mission Control"**

The site reads as a calm, high-stakes systems console at night: near-black surfaces, a slow-drifting starfield, and an orbiting ring of labeled engineering-discipline nodes (Flutter, Architecture, Performance, Security, Testing, CI/CD, Firebase, API) behind the hero. Two accent signals — signal cyan and alert pink — behave like telemetry, not decoration: they mark what's active, what's primary, what just responded to your cursor. Everything else stays disciplined — near-black or near-white surfaces, hairline borders, and generous whitespace — so the accents and the evidence (real user counts, real percentages, real case studies) are what a visitor's eye lands on.

The philosophy is precise and restrained, not loud. Motion exists to confirm interaction (a button scales, a card lifts, a metric counts up once) rather than to perform. The one deliberate rejection the codebase already states outright: no glassmorphism, no heavy gradients. Where the UI feels "glassy" (the pill buttons, the translucent card fills), it's a thin tinted border and a soft fill — never a blurred backdrop panel pretending to be frosted glass. The single exception is the app bar, which does apply a real `BackdropFilter` blur once scrolled, and it is intentional: a light instrument-panel cue that the console has compacted, not a decorative motif repeated elsewhere.

Depth is ambient, not staged. The system doesn't reserve shadow purely as a hover reward — dark-mode surfaces are already translucent tints over the void (card fills sit at partial opacity over `space-black`, not flat opaque panels), hairline borders are present at rest, and the starfield/orbit backgrounds give the whole scene a sense of depth before a single element is touched. Hover/focus states then add a directional accent glow on top of that ambient base — an amplification, not the only source of depth.

**Key Characteristics:**
- Dark-first "Mission Control" identity: near-black space tones, a starfield, and an orbiting engineering-node motif behind the hero.
- Two-signal accent system (signal cyan / alert pink) used sparingly against otherwise neutral surfaces.
- Ambient depth at rest (translucent tinted surfaces, visible hairline borders) amplified by accent-tinted glow on hover/focus — never flat-then-nothing.
- Outfit throughout, at Material 3's default type scale — no custom font pairing.
- Tactile-but-understated components: outlined and tinted, never solid-filled or glassmorphic; every interactive element scales, lifts, or glows in direct response to touch.
- A parallel light theme that keeps the same structure and interaction language but trades the starfield/space palette for a plain, high-contrast, WCAG AA-checked surface.

## Colors

Two complete, theme-switched palettes — not light/dark variants of one hue set, but two related-but-distinct color stories that share the same structural roles (background / surface / primary / secondary / text / border).

### Primary
- **Signal Cyan** (`#00F0FF`, dark theme): the primary accent — CTAs, active nav state, primary icon wells, focus rings, the "this is interactive/important" signal. Used sparingly against near-black.
- **Deep Teal** (`#007A87`, light theme): the light-mode primary accent, deliberately darkened from a brighter cyan (originally `#0097A7`) so text/icons set in this color clear WCAG AA contrast (~4.6:1) against white, not just the 3:1 large-text minimum.

### Secondary
- **Alert Pink** (`#FF007F`, dark theme): the secondary accent — hover states on nav links, social-icon hover, the "second signal" that differentiates from primary without competing for the same attention.
- **Berry Rose** (`#D81B60`, light theme): the light-mode secondary accent, same role as Alert Pink.

### Neutral
- **Space Black** (`#0B0B15`): dark-theme background — the "void" the starfield sits on.
- **Deep Space** (`#1A1A2E`): dark-theme surface color — card fills, the app bar, the scaffold's structural layer (always used at partial opacity for translucent surfaces, never fully flat).
- **Starlight** (`#EAEAEA`): dark-theme primary text.
- **Mist** (`#FAFAFA`): light-theme background.
- **Paper** (`#FFFFFF`): light-theme surface (cards render fully opaque here, unlike dark mode).
- **Ink** (`#1A1A2E`): light-theme primary text — the same hex as Deep Space, but playing a text role instead of a surface role.
- **Ink Muted** (`#5A5A6E`): light-theme secondary/body text.
- **Hairline** (`#E0E0E0`): light-theme borders and dividers.

### Named Rules
**The Signal Rarity Rule.** Signal Cyan / Deep Teal appears on active state, primary CTAs, and icon accents only — never as a large fill. If more than roughly one element per view carries full-strength accent color, it has stopped signaling and started decorating.

**The No-Fabricated-Glass Rule.** Translucency and thin borders read as "glass-adjacent," but there is no backdrop blur anywhere except the scrolled app bar. Don't add `BackdropFilter` blur to cards, buttons, or the mobile menu to chase a frosted-glass look — that is the one rejected direction this system already committed against.

## Typography

**Display/Body/Label Font:** Outfit (Google Fonts variable family), applied via Flutter's Material 3 default type scale (`GoogleFonts.outfitTextTheme`) with no other family in use anywhere on the site.

**Character:** One typeface carries the entire system, at its unmodified default scale — the personality comes from weight and letter-spacing choices (bold display names, wide-tracked uppercase labels), not from mixing families.

### Hierarchy
- **Display** (700, 45px / 1.15): the hero name only — "Abdallah Ali Rehab." The single largest, boldest moment on the page.
- **Headline** (700, 36px / 1.2): every section title (About, Experience, Skills, Projects, Contact, and the project case-study modal's title) — Material's `displaySmall` role, reused consistently as the section-heading register.
- **Title** (700/600, 22–24px / 1.3): card and sub-block titles — project card names, the hero's role line ("Senior Mobile Engineer · Flutter").
- **Body** (400, 16–17px / 1.6–1.8): paragraph copy — the hero positioning statement, About narrative, case-study descriptions. Long-form body text consistently uses a generous 1.6–1.8 line-height for readability against the busy dark background.
- **Label** (500–700, 10–14px / 1.2–1.4 letter-spacing, often uppercase): eyebrow badges ("FLUTTER · ANDROID & iOS SPECIALIST"), nav links, metric captions, chip/tag text, section eyebrows ("AI-ASSISTED ENGINEERING").

### Named Rules
**The One-Display Rule.** `displayMedium` (the Display role) is used exactly once per page — the hero name. Every other heading, however large it reads visually, is a Headline or Title. This keeps the name as the unambiguous single largest text element on the site.

## Layout

Single-column, section-stacked page (Hero → About → Timeline → Skills/AI-assisted → Impact → Projects → Contact → Footer), each section a full-bleed background block with centered, max-width-constrained content — most content columns cap around 600–980px even on wide desktop, so line lengths and card grids stay readable rather than stretching edge-to-edge.

Responsive breakpoints (`responsive_framework`): **Mobile** 0–450px, **Tablet** 451–800px, **Desktop** 801–1920px, **4K** 1921px+. The app bar swaps from a horizontal nav row to a hamburger + slide-down mobile menu at the Tablet boundary. Card grids (About's pillar grid, Projects) reflow via `LayoutBuilder`-driven column counts (commonly 4 → 2 → 1 columns) rather than fixed CSS-grid breakpoints.

Section vertical rhythm runs large — 80px top/bottom padding is the standard section gutter — with tighter internal spacing (4–20px) inside cards and component clusters. Horizontal section padding is 24px at the edges on narrow viewports.

## Elevation & Depth

Hybrid, not purely flat and not purely shadow-driven. Two things create depth simultaneously:

1. **Ambient depth at rest**: dark-theme card surfaces are translucent (`Deep Space` at 50% opacity over `Space Black`, not an opaque fill), and a visible hairline border sits on every card, button, and panel even when untouched. The starfield and hero orbit backgrounds add atmospheric depth behind the content layer before any interaction happens.
2. **Interaction-triggered glow**: no component carries a `boxShadow` at rest. On hover/focus, an accent-tinted glow (`blurRadius` 16–40px, low spread, accent color at 10–35% alpha) appears alongside a lift (cards translate up ~4px, buttons scale to 1.04–1.12×) as direct, immediate feedback — never ambient, never present without a pointer/focus event.

### Shadow Vocabulary
- **Card hover glow** (`0 0 20px rgba(accent, 0.15)`, spread 1–2px): the standard card/pillar hover treatment.
- **Button hover glow** (`0 0 24px rgba(accent, 0.15–0.35)`, spread 1px): primary buttons glow stronger (0.35) than secondary/ghost buttons (0.15).
- **Modal glow** (`0 0 40px rgba(accent, 0.1)`, spread 5px): the project case-study dialog's ambient accent halo, present as soon as the modal opens (not hover-gated, since a modal has no "at rest" state).
- **App bar scroll shadow** (`0 2px 10px rgba(black, 0.1–0.3)`): appears only once the bar compacts on scroll, paired with the real backdrop blur.

### Named Rules
**The No-Shadow-At-Rest Rule.** Nothing casts a `boxShadow` before it's touched or focused. If a static (non-hover) shadow shows up on a new component, that's a regression against this system's interaction language.

## Shapes

Rounded-rectangle system with five radius steps, no sharp corners anywhere: **8px** (small tag/chip corners), **12px** (icon wells, form inputs, medium containers), **20px** (cards — project cards, pillar cards), **24px** (larger panels — the contact form card, the project detail modal), and **30px** (buttons and pill badges — functionally full-pill at the height these components render). Circles (`CircleBorder`) are reserved for social icons and the floating scroll-to-top button.

Borders are thin (1–2px) and low-contrast at rest, strengthening to the accent color on hover/focus/active rather than changing thickness. No drop-shadowed edges or beveling — the border is the primary shape-definition device, shadow is secondary and interaction-only.

## Components

### Buttons
- **Shape:** full-pill (30px radius).
- **Primary:** signal-cyan/deep-teal text on a 10%-alpha tinted fill, 1.5px border at 50% accent alpha (90% on hover), 32px/16px horizontal/vertical padding, bold 16px label with 0.5px letter-spacing.
- **Secondary (ghost):** same shape and padding, but text/border/fill all use the neutral text color instead of the accent — same interaction language, lower visual weight.
- **Hover/Focus:** scale to 1.04×, border alpha increases, accent glow appears (see Elevation), all over a 180ms ease-out.

### Chips (tags, scale badges, story-stage pills)
- **Style:** accent-tinted 10%-alpha background, accent border at 35% alpha, accent-colored text, bold, small (10–12px).
- **Shape:** 8px radius for compact tech-tag chips, 20px (full-pill) for scale-label and story-stage badges.
- **Signature variant — Engineering Story Strip:** a horizontal chain of story-stage chips connected by small forward-arrow glyphs, used only on case studies that have a real greenfield/legacy-to-shipped narrative (`storyStages` in config) — never fabricated for projects without one.

### Cards / Containers
- **Corner Style:** 20px (project/pillar cards) or 24px (larger panels: contact form, modal).
- **Background:** translucent Deep Space at 50% alpha in dark mode; fully opaque Paper in light mode.
- **Shadow Strategy:** none at rest; accent glow + 4px upward lift on hover (see Elevation).
- **Border:** 1–1.5px, neutral hairline at rest, accent at 50% alpha on hover.
- **Internal Padding:** 20px standard, 32px for larger panels (contact form, modal).
- **Icon well:** a recurring sub-pattern inside cards — a small (10px padding, 12px radius) accent-tinted square housing a Material icon, used identically in project cards and About's pillar cards.

### Inputs / Fields
- **Style:** filled (hairline-tinted background at 50% alpha), no visible border by default, 12px radius, leading icon in the accent color, floating label.
- **Focus:** border appears in the accent color (enabled state shows a neutral hairline border instead of none).
- **Error/Disabled:** not custom-styled beyond Flutter's default `TextFormField` validation message; no distinct disabled treatment currently implemented.

### Navigation
- **Style:** text nav links with a 2px animated underline (transparent → accent on hover → solid accent when active), 15px Outfit, 12px/8px padding, 4px horizontal margin between links.
- **Default/Hover/Active:** default uses secondary text color; hover shifts to the secondary accent (Alert Pink / Berry Rose) with a 1px upward nudge; active uses the primary accent with a solid underline and bolder weight.
- **Mobile treatment:** collapses to a hamburger icon that reveals a full-width, top-bordered dropdown menu with 24px/16px padding per link; the app bar itself gains a real backdrop blur once the page scrolls past the hero.

### Social Icons (signature component)
Circular (not rounded-rect) icon buttons: neutral 5%-alpha fill at rest, border shifts to the secondary accent at 70% alpha on hover along with a 1.12× scale and an accent glow — the one place in the system where secondary (not primary) accent is the interactive color, matching its role as a "second signal" for external/outbound links.

## Do's and Don'ts

### Do:
- **Do** treat Signal Cyan / Deep Teal as the primary interactive signal and Alert Pink / Berry Rose as the secondary one — don't swap their roles or use them interchangeably.
- **Do** keep every card and button flat (no `boxShadow`) at rest, adding glow only on hover/focus.
- **Do** use Outfit at Material 3's default type scale; don't introduce a second font family.
- **Do** reserve full-pill (30px) radius for buttons/badges and 20–24px for cards/panels — keep the radius scale to these five steps.
- **Do** gate the Engineering Story Strip component on real `storyStages` data — never invent a narrative arc for a project that doesn't have one.
- **Do** keep the starfield/orbit motif dark-theme-only; the light theme reads on a plain surface by design.

### Don't:
- **Don't** add glassmorphism (backdrop-blur panels) or heavy gradients anywhere outside the already-established scrolled app bar. This is a standing, explicit rejection, not an oversight.
- **Don't** apply a static (non-hover) shadow to any component — it breaks the "ambient translucency at rest, glow on touch" depth model.
- **Don't** fabricate metrics, testimonials, or project facts to fill out a component — every number and case study must trace to `assets/config.json` or the CV.
- **Don't** let the accent colors cover more than roughly one element's worth of a given view — their power comes from rarity.
