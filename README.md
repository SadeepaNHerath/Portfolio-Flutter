# Portfolio Flutter

Personal portfolio application built with Flutter. The app presents profile details, skills, education, certifications, and selected projects with a modern animated UI.

## Highlights

- Landing page with dedicated Contact section
  - LinkedIn, GitHub, and Email quick actions
  - CV download/open action with fallback behavior
- Profile section with session-aware animated counters (animate once per app session)
- Tabbed portfolio detail view
  - Summary
  - Skills
  - Recent Work
- Recent Work filtering by category
  - All
  - Web
  - AI
  - Mobile
- Smooth transitions
  - First-load section reveal (staggered)
  - Subtle directional transitions between tabs
- Side drawers for:
  - Academic qualifications
  - Achievements and community highlights

## Tech Stack

- Flutter (Material 3)
- Dart
- `url_launcher` for external links

## Project Structure

- `lib/main.dart`: app entry point and theme
- `lib/pages/portfolio_page.dart`: landing page and contact actions
- `lib/pages/portfolio_detail_page.dart`: main portfolio content, drawers, transitions
- `lib/widgets/profile_info_section.dart`: profile card, social links, animated counters
- `lib/widgets/about_me_section.dart`: summary/experience/education/certifications content
- `lib/widgets/skills_section.dart`: visual skills list
- `lib/widgets/recent_work_section.dart`: filterable project gallery
- `lib/widgets/tab_navigation.dart`: top tab navigation

## Run Locally

1. Install Flutter SDK and verify environment:

```bash
flutter doctor
```

2. Install dependencies:

```bash
flutter pub get
```

3. Run the app:

```bash
flutter run
```

## Build

```bash
flutter build apk
flutter build ios
flutter build web
```

## Configuration Notes

- Update social links and contact URIs in:
  - `lib/pages/portfolio_page.dart`
  - `lib/widgets/profile_info_section.dart`
- Update project cards, categories, and repository links in:
  - `lib/widgets/recent_work_section.dart`
- Update summary, experience, education, and certifications content in:
  - `lib/widgets/about_me_section.dart`
  - `lib/pages/portfolio_detail_page.dart` (drawer content)

## Assets

- Profile image and app icon: `assets/icon.png`
- Project images: `assets/work_0.jpg` ... `assets/work_3.jpg`

Make sure assets are declared in `pubspec.yaml`.

## Useful Flutter Docs

- [Flutter documentation](https://docs.flutter.dev/)
- [Dart language tour](https://dart.dev/guides/language/language-tour)
- [url_launcher package](https://pub.dev/packages/url_launcher)
