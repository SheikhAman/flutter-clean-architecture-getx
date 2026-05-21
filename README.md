<div align="center">

# Flutter Core

**Master API boilerplate** — stop rebuilding Flutter apps from zero. One wrapper for all your projects.

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.3%2B-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![GetX](https://img.shields.io/badge/GetX-4.7-8A2BE2?style=for-the-badge)](https://pub.dev/packages/get)
[![API](https://img.shields.io/badge/Version-API%20(rest)-2563EB?style=for-the-badge)](https://github.com/SheikhAman/flutter-clean-architecture-getx)
[![Firebase](https://img.shields.io/badge/Coming-Firebase%20variant-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](#roadmap)

*Firebase edition planned next — this repo is the **REST / Dio API** foundation.*

[Showcase](#-component-showcase) · [Quick start](#-quick-start) · [Auth OTP](#-auth--demo-otp) · [Structure](#-project-structure)

</div>

---

## Why this exists

Starting a new Flutter app usually means repeating the same work: HTTP client, interceptors, auth screens, theme, localization, loaders, empty states, and custom inputs.

**Flutter Core** removes that repetition. Clone it, rename the package, open the **Component Showcase**, and ship features. A **Firebase variant** will follow this API version.

---

## What’s included

| Area | Details |
|------|---------|
| **Showcase hub** | One screen listing every widget & feature — ideal for GitHub demos / screen recordings |
| **Auth** | Modern login & register → OTP screen (**demo OTP: `112345`**) |
| **Device info** | Collected on login/register and sent with API payload |
| **Networking** | Dio — GET, POST, PUT, multipart + **logging interceptor** (JSONPlaceholder + httpbin) |
| **Custom UI** | Text fields, loader button, dropdown, date picker, shimmer, dialog, bottom sheet, toast |
| **States** | Empty list, network error page |
| **Theme** | Dark mode + **6 color seeds** |
| **i18n** | English & Bengali toggle |
| **Extras** | WebView, file download, EasyLoading |

---

## Component showcase

After launch you land on the **Showcase** — tap any card to open a live demo:

- Widgets · Auth · API · Theme · Download · WebView · Network error · Empty state

Record a video from this screen for your repo README or social posts.

---

## Auth & demo OTP

1. **Login** or **Register** (uses live dummy POST + device metadata).
2. Enter OTP **`112345`** on the verification screen.
3. You’re in the Showcase. Replace OTP logic when SMS/API is ready (`AppConstants.demoOtp`).

---

## Quick start

```bash
git clone https://github.com/SheikhAman/flutter-clean-architecture-getx.git
cd flutter-clean-architecture-getx
flutter pub get
flutter run
```

**New app from this core:** rename package in `pubspec.yaml`, update `lib/core/constants/app_constants.dart`, point `ApiConstants` to your API, add features under `lib/features/`.

---

## Project structure

```text
lib/
├── core/
│   ├── constants/     # OTP, URLs, app-wide consts
│   ├── theme/         # Colors, light/dark themes
│   ├── widgets/       # All custom UI components
│   ├── services/      # Device info, download, cache…
│   └── utils/         # Toast, loaders, validators
├── network/
│   ├── dio_client.dart
│   └── interceptors/  # Request/response logs
├── features/
│   ├── showcase/      # Demo catalog + API/widget screens
│   ├── auth/          # Login, register, OTP
│   ├── splash/
│   └── common/        # WebView, empty, network error
├── languages/         # en_US · bn_BD
└── routes/
```

**Flow:** `Splash` → `Showcase` (explore everything) · Auth available from Showcase card.

---

## Tech stack

[![dio](https://img.shields.io/pub/v/dio?label=Dio)](https://pub.dev/packages/dio)
[![get](https://img.shields.io/pub/v/get?label=GetX)](https://pub.dev/packages/get)
[![shimmer](https://img.shields.io/pub/v/shimmer?label=Shimmer)](https://pub.dev/packages/shimmer)
[![easyloading](https://img.shields.io/pub/v/flutter_easyloading?label=EasyLoading)](https://pub.dev/packages/flutter_easyloading)
[![device_info](https://img.shields.io/pub/v/device_info_plus?label=Device+Info)](https://pub.dev/packages/device_info_plus)

---

## Roadmap

- [x] API version (Dio, REST, interceptors)
- [x] Component Showcase for demos
- [x] Auth + demo OTP
- [ ] Firebase version (Auth, Firestore, etc.)
- [ ] Real SMS OTP provider plug-in

---

## Topics

`flutter-boilerplate` · `flutter-starter` · `getx` · `dio` · `clean-architecture` · `otp-auth` · `custom-widgets` · `flutter-template` · `bangla-localization`

---

<div align="center">

**Build once. Ship every app from the same core.**

</div>
