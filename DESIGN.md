---
name: Abdallah Ali Rehab Portfolio
description: "Moss Night": an engineer's field ledger set in big tight type and honest charts, bone ink on olive-black with one phosphor-lime signal.
colors:
  moss-night-ground: "#0E110C"
  moss-night-recessed: "#090B07"
  moss-night-surface: "#141811"
  moss-night-surface-hover: "#191E15"
  moss-night-line: "#2C3326"
  moss-night-line-faint: "#1B2017"
  bone-ink: "#EEF0E4"
  lichen-muted: "#A9AF9C"
  lichen-faint: "#858C78"
  phosphor-lime: "#C5F04A"
  on-lime-ink: "#0E110C"
  bone-day-ground: "#F3F2EA"
  bone-day-recessed: "#E9E8DD"
  bone-day-surface: "#FBFBF6"
  bone-day-surface-hover: "#FFFFFF"
  bone-day-line: "#CFCFC0"
  bone-day-line-faint: "#E2E1D5"
  olive-ink: "#151912"
  olive-muted: "#4E5343"
  olive-faint: "#6B6F5E"
  deep-moss: "#4D6B00"
  signal-moss: "#6E9410"
typography:
  display:
    fontFamily: "Bricolage Grotesque, sans-serif"
    fontSize: "clamp(46px, 4.381vw + 28.91px, 92px)"
    fontWeight: 500
    lineHeight: 0.98
    letterSpacing: "-0.045em"
  headline:
    fontFamily: "Bricolage Grotesque, sans-serif"
    fontSize: "clamp(36px, 3.048vw + 24.11px, 68px)"
    fontWeight: 500
    lineHeight: 1.02
    letterSpacing: "-0.035em"
  title:
    fontFamily: "Bricolage Grotesque, sans-serif"
    fontSize: "clamp(22px, 0.381vw + 20.51px, 26px)"
    fontWeight: 500
    lineHeight: 1.15
    letterSpacing: "-0.02em"
  numeral:
    fontFamily: "Bricolage Grotesque, sans-serif"
    fontWeight: 500
    lineHeight: 0.95
    letterSpacing: "-0.04em"
    fontFeature: "\"tnum\""
  lead:
    fontFamily: "Hanken Grotesk, sans-serif"
    fontSize: "clamp(17px, 0.19vw + 16.26px, 19px)"
    fontWeight: 400
    lineHeight: 1.5
  body:
    fontFamily: "Hanken Grotesk, sans-serif"
    fontSize: "16px"
    fontWeight: 400
    lineHeight: 1.6
  ui:
    fontFamily: "Hanken Grotesk, sans-serif"
    fontSize: "14px"
    fontWeight: 500
    lineHeight: 1.2
  label:
    fontFamily: "Hanken Grotesk, sans-serif"
    fontSize: "12px"
    fontWeight: 600
    lineHeight: 1.2
    letterSpacing: "1.7px"
  caption:
    fontFamily: "Hanken Grotesk, sans-serif"
    fontSize: "13px"
    fontWeight: 400
    lineHeight: 1.4
    fontFeature: "\"tnum\""
rounded:
  radius: "6px"
  pill: "999px"
spacing:
  gap: "12px"
  gutter: "clamp(16px, 1.524vw + 10.06px, 32px)"
  section: "clamp(64px, 5.333vw + 43.2px, 120px)"
  max-width: "1200px"
components:
  button-accent:
    backgroundColor: "{colors.phosphor-lime}"
    textColor: "{colors.on-lime-ink}"
    typography: "{typography.ui}"
    rounded: "{rounded.pill}"
    padding: "13px 22px"
  button-accent-hover:
    backgroundColor: "{colors.bone-ink}"
    textColor: "{colors.moss-night-ground}"
  button-outline:
    backgroundColor: "transparent"
    textColor: "{colors.bone-ink}"
    typography: "{typography.ui}"
    rounded: "{rounded.pill}"
    padding: "13px 22px"
  button-outline-hover:
    backgroundColor: "{colors.bone-ink}"
    textColor: "{colors.moss-night-ground}"
  button-inverse:
    backgroundColor: "{colors.moss-night-ground}"
    textColor: "{colors.bone-ink}"
    typography: "{typography.ui}"
    rounded: "{rounded.pill}"
    padding: "13px 22px"
  button-inverse-hover:
    backgroundColor: "{colors.phosphor-lime}"
    textColor: "{colors.on-lime-ink}"
  arrow-circle:
    backgroundColor: "{colors.phosphor-lime}"
    textColor: "{colors.on-lime-ink}"
    rounded: "{rounded.pill}"
    size: "44px"
  icon-button:
    backgroundColor: "transparent"
    textColor: "{colors.bone-ink}"
    rounded: "{rounded.pill}"
    size: "40px"
  tag:
    backgroundColor: "{colors.moss-night-surface}"
    textColor: "{colors.lichen-muted}"
    typography: "{typography.caption}"
    rounded: "{rounded.pill}"
    padding: "5px 11px"
  card-project:
    backgroundColor: "{colors.moss-night-surface}"
    textColor: "{colors.bone-ink}"
    rounded: "{rounded.radius}"
    padding: "clamp(20px, 1.143vw + 15.54px, 32px)"
  card-project-hover:
    backgroundColor: "{colors.moss-night-surface-hover}"
  nav-bar:
    backgroundColor: "{colors.moss-night-ground}"
    textColor: "{colors.bone-ink}"
    typography: "{typography.ui}"
    height: "72px"
---

# Design System: Abdallah Ali Rehab Portfolio

## Overview

**Creative North Star: "Moss Night, the Field Ledger"**

An engineer's field ledger: evidence set in big, confident, tightly tracked type and drawn as honest charts, not described in cards of adjectives. Bone ink sits on an olive-black ground; one phosphor-lime signal marks what matters (the primary action, the data, the current role). Structure comes from hairlines, not boxes, shadows, or light effects. The page reads as a sequence of full-width bands, each opened by a large heading and a short lead, then a ledger of rows, a chart, or (for case studies only) a grid of panels.

The world ships in two themes with the same roles. "Moss Night" (dark, default) and "Bone Day" (light) swap ground and ink; the lime fill stays identical in both, while text-set and data-set accent drop to deeper greens in Bone Day so they clear contrast on the bone ground. The closing contact band is the inverse of whichever theme is active.

Motion is entrance and evidence only: the hero name rises line by line from behind masks, sections fade up a short distance as they enter, chart bars and timeline spans grow to their true lengths. Every one of these has a reduced-motion fallback that renders the final state immediately.

**Key Characteristics:**
- Olive-black ground, bone ink, one phosphor-lime signal; no secondary hue.
- Lime is a fill with dark ink on it, or a 1px rule; never body text in Bone Day.
- Bricolage Grotesque at poster scale with negative tracking; Hanken Grotesk for everything read or scanned.
- Hairline rows over card grids; project cards are the only panel type.
- Flat: no shadows, no glass, no glow, no decorative gradients.
- Full pills and circles for every control; 6px radius for the one panel type.
- Sweep-fill buttons and the arrow-circle "go" motif carry interaction.

## Colors

A two-theme, single-signal palette: warm olive neutrals with one acid-lime accent split into three jobs (fill, text, data mark).

### Primary
- **Phosphor Lime** (`phosphor-lime`): the one signal, used as a solid fill. Primary pill buttons, the arrow circle, the nav "Let's talk" pill, the live dot, and the hover sweep on inverse-band buttons. Identical in both themes. Anything drawn on it uses **On-Lime Ink** (`on-lime-ink`).
- **Deep Moss** (`deep-moss`): the accent as text or a thin line in Bone Day (lime itself plays this role in Moss Night). Accent words in headings ("Engineer.", "engineering judgment."), active nav underline, inline-link underline, dash-list markers, pillar rules, outcome tags, focus rings, text cursor.
- **Signal Moss** (`signal-moss`): the accent for data marks in Bone Day (chart bars, timeline spans and nodes, impact dots), deep enough to clear 3:1 against the bone ground. In Moss Night data marks are lime.

### Neutral (Moss Night)
- **Olive-Black Ground** (`moss-night-ground`): page canvas, nav bar fill, and the browser boot screen.
- **Recessed Black** (`moss-night-recessed`): footer and the toolbox marquee band, one step below the ground.
- **Panel Olive** (`moss-night-surface`) / **Panel Olive Lifted** (`moss-night-surface-hover`): project card fill at rest and on hover; tag fill.
- **Moss Line** (`moss-night-line`): visible hairlines: outlines, chart gridlines, scrolled nav border, idle icon-button rings.
- **Faint Moss Line** (`moss-night-line-faint`): section-top rules, row separators, card borders at rest.
- **Bone Ink** (`bone-ink`): headings and primary text; also the inverse-band ground in Moss Night.
- **Lichen Muted** (`lichen-muted`): body copy and leads.
- **Lichen Faint** (`lichen-faint`): captions, axis ticks, labels, platform icons.

### Neutral (Bone Day)
- **Bone Ground** (`bone-day-ground`), **Bone Recessed** (`bone-day-recessed`), **Bone Panel** (`bone-day-surface`) / **White Panel** (`bone-day-surface-hover`), **Bone Line** (`bone-day-line`), **Faint Bone Line** (`bone-day-line-faint`): the same roles as their Moss Night counterparts.
- **Olive Ink** (`olive-ink`), **Olive Muted** (`olive-muted`), **Olive Faint** (`olive-faint`): primary, body, and caption text.

### Named Rules
**The Three-Jobs Lime Rule.** The accent has three tokens and each has one job: `accent` is a fill (always with On-Lime Ink on it), `accentInk` is text or a 1px line, `signal` is a data mark. Never set lime text on the bone ground; reach for `accentInk`.

**The Inverse Band Rule.** The contact band uses `inverse` / `onInverse`: bone with olive-black ink in Moss Night, olive-black with bone ink in Bone Day. Its buttons use the inverse variants, whose hover sweeps lime.

**The One Signal Rule.** There is no secondary or tertiary hue. Status, emphasis, and data all come from lime and its two deeper greens; everything else is olive neutral.

## Typography

**Display Font:** Bricolage Grotesque (with sans-serif)
**Body Font:** Hanken Grotesk (with sans-serif)

**Character:** A characterful grotesque set big, medium weight, and tight carries every display moment; a calm, neutral grotesque carries everything read at length or scanned as data. Display sizes scale fluidly between a 390px and a 1440px viewport.

### Hierarchy
- **Display** (500, 46px to 92px, 0.98): the hero name only, once per page, revealed line by line; the final line may be set in `accentInk`.
- **Headline** (500, 36px to 68px, 1.02): section titles, max 820px wide. One accent phrase per headline at most.
- **Title** (500, 22px to 26px, 1.15): role names, pillar titles, project names (set larger, 30px to 40px, on project cards), form headings.
- **Numeral** (500, size set per use, 0.95, tabular figures): chart headline figures and bar values ("6+", "4M+"), always beside the chart or row they quantify.
- **Lead** (400, 17px to 19px, 1.5): one paragraph under a headline, max 560px.
- **Body** (400, 16px default, 15 to 17.5px in context, 1.6): prose in `inkMuted`.
- **UI** (500, 14px default, 1.2): buttons, nav links, emphasized one-liners such as a project's headline outcome.
- **Label** (600, 12px, 1.7px tracking): form field labels and the uppercase row labels in the case-study dialog's label column.
- **Caption** (400, 13px, 1.4, tabular figures): dates, domain and scale lines, axis ticks, ledger lines.

### Named Rules
**The No-Eyebrow Rule.** No small label sits above a heading. Section headers are a headline and an optional lead; the heading carries its own weight. Label style appears only as a field label or as the left-hand label of a definition row.

**The Tight Display Rule.** Bricolage is always weight 500 with negative tracking proportional to size (-0.045em hero, -0.035em headline, -0.02em title). Never set it light, bold, or uppercase.

## Layout

A single 1200px column centred with a fluid side gutter (16px on phones to 32px on desktop). Each section is a full-bleed band with a faint top hairline and fluid vertical padding (64px to 120px); headers sit above content with 36px to 64px below them. The page reads top to bottom as bands, not as a dashboard.

Content inside bands is mostly hairline rows: the experience timeline (date column, node, body), the pillar row (four columns each topped by a 1px rule whose lime segment grows on hover), the skills ledger (category over a dotted inline list), the AI-workflow list, and the users-per-product chart (product name and its measured outcomes on the left, a proportional bar on a shared 0 to 4M axis on the right). Only case studies use a grid: two equal columns of panels with a 12px gap.

Responsive behavior: the nav collapses to a menu below 860px; two-column compositions (hero 1.25fr/1fr, about, contact, case-study grid) stack below roughly 900px; the case-study dialog's label column stacks under 560px. On phones the hero keeps text first and the portrait after.

## Elevation & Depth

Flat. No shadows anywhere. Depth is tonal and linear: recessed bands sit one step darker than the ground, panels one step lighter, hover lifts a panel one more step and strengthens its border from faint to visible line. The only overlay is the case-study dialog over a 60% black barrier.

### Named Rules
**The Hairline-Not-Shadow Rule.** Separation is a 1px line in `line` or `lineFaint`. If something needs to feel raised, change its fill one tonal step; never add a shadow, blur, or glow.

**The Two Gradients Rule.** Gradients exist only as functional masks: the bottom scrim on the hero portrait (ground at 85% to 0% over the lower 45%) so its caption reads, and the alpha edge-fade on the toolbox marquee. No decorative gradient fills, text, or borders.

## Shapes

Two shapes only. Every control is a full pill or a circle (999px): buttons, tags, outcome tags, icon buttons, the arrow circle, chart bars, the scrollbar thumb, the snackbar. The one panel type (project card) and tooltips use a gently rounded 6px corner. Borders are 1px; focus rings are 1.5px drawn outside the element in `accentInk`. The hero portrait is a 4:5 rectangle with a 1px line border and a moss multiply grade.

## Components

### Buttons
Tactile through motion, not elevation: the fill sweeps in from the left on hover or focus and retracts to the right on leave (550ms, expo-out), while the label colour cross-fades.
- **Shape:** full pill (999px), 1px border in the fill colour.
- **Accent (primary):** lime fill, On-Lime Ink label, 13px by 22px padding (large 17/28, compact 9/16), UI type 15px. Sweep colour is `ink`, label turns `ground`.
- **Outline:** transparent with a 1px `ink` border and `ink` label; `ink` sweeps in, label turns `ground`.
- **Inverse / Inverse Outline:** for the contact band only. Inverse is an `onInverse` fill with `inverse` label and a lime sweep; Inverse Outline mirrors Outline on the band.
- **Focus:** the shared 1.5px `accentInk` ring outside the pill, plus the same sweep as hover.

### Arrow Circle (signature)
The recurring "go" motif: a 44px lime circle holding a north-east arrow in On-Lime Ink that rotates 45 degrees to point straight ahead when its parent is active. Sits beside primary CTAs, at the foot of every project card (32px), and alone as a scroll cue. An outlined variant uses a `line` ring that turns `accentInk` on hover.

### Icon Buttons
40px outlined circles (theme toggle, socials, copy-email, menu, scroll-to-top) with a `line` ring and `ink` glyph; ring and glyph turn `accentInk` on hover/focus. On the inverse band the ring is `onInverse` at 25%.

### Inline Links
UI-type text with a 1px `accentInk` underline that grows from the left on hover (550ms expo). Nav links use the same underline to mark the active section.

### Tags
Small pills: `surface` fill, 1px `line` border, caption type at 12.5px in `inkMuted`, 5px by 11px padding, 6px gaps. Outcome tags on the timeline use the same pill drawn in `accentInk` (border at 60%).

### Cards / Containers (project card, the only panel)
- **Corner Style:** 6px.
- **Background:** `surface`, lifting to `surfaceHover` on hover/focus.
- **Shadow Strategy:** none (see Elevation & Depth).
- **Border:** 1px `lineFaint`, strengthening to `line` on hover.
- **Internal Padding:** 20px to 32px fluid.
- **Content order:** name at 30px to 40px display, a caption line of domain and user scale, platform glyphs at top right, context paragraph, one headline outcome beside a 7px `signal` dot, up to four tags, then "Read case study" with a 32px arrow circle that turns on hover.

### Inputs / Fields
Live on the inverse contact band. Underline only: a 1px `onInverse` line at 25%, thickening to 1.5px full `onInverse` on focus. Label type for the floating label in `onInverseMuted`; error ink is tuned per band.

### Navigation
A 72px bar filled with `ground`; its bottom hairline appears (`line`) only once scrolled or when the menu is open. Left: a 40px "AR" monogram circle. Right: UI-type section links with the growing `accentInk` underline on the active or hovered link, the theme-toggle icon button, and a compact lime "Let's talk" pill. Below 860px the links move into a full-width menu of 28px title-type rows separated by faint hairlines.

### Users-per-Product Chart (signature)
One calibrated instrument: every product's bar is a 12px `signal` pill on a shared 0 to 4M axis with `line` gridlines and caption ticks, its value in numeral type at the bar's end, and its own measured outcomes set under its name in `accentInk` caption. Bars grow to their true proportion on entry; hovering a row dims the others toward `line`.

### Motion
- **Easing:** expo-out `cubic-bezier(0.16, 1, 0.3, 1)` for sweeps, reveals, and growth; ease-out `cubic-bezier(0.2, 0.7, 0.2, 1)` for small state changes.
- **Durations:** 250ms (fast state), 550ms (sweeps, underlines, arrow turn), 900ms (scroll reveals).
- **Reveal:** fade up 24px once scrolled into view, staggered 70 to 100ms between siblings.
- **Hero:** each name line slides up from behind its own clip mask in sequence; the portrait settles from a slight scale.
- **Reduced motion:** reveals, chart growth, hero masks, the live-dot pulse, and the marquee resolve to their final static state.

## Do's and Don'ts

### Do:
- **Do** put dark On-Lime Ink on every lime fill, and use `accentInk` for any accent text or 1px accent line.
- **Do** draw data marks in `signal` so they hold 3:1 in Bone Day.
- **Do** separate content with 1px hairlines (`line`, `lineFaint`) and lay lists out as rows.
- **Do** put every number inside the chart or row it measures, with its product named beside it.
- **Do** use full pills or circles for controls and the 6px radius only for panels and tooltips.
- **Do** route every interactive element through the shared focus ring (1.5px `accentInk`, outside the element).
- **Do** give every entrance or growth animation a reduced-motion final state.
- **Do** flip the contact band to the inverse of the active theme.

### Don't:
- **Don't** put an eyebrow, kicker, or status pill above a heading.
- **Don't** build strips of metric tiles; a number without its product and its chart is not evidence here.
- **Don't** turn content into card grids; project cards are the only panel type.
- **Don't** add shadows, glass or backdrop blur, glows, or decorative gradients; the portrait scrim and the marquee edge-fade are the only gradients.
- **Don't** set lime as text on the bone ground, or put light ink on a lime fill.
- **Don't** introduce a second accent hue.
- **Don't** set Bricolage Grotesque in uppercase, light, or bold weights.
