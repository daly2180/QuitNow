# QUIT NOW — Android application

Modern Android app foundation for smoking cessation support, built with Kotlin and Jetpack Compose.

## Open the complete project

Open the extracted `QuitNow_Android_Project` root folder in an IDE. Do not open only `MainActivity.kt`. The app is split across multiple Kotlin packages under `app/src/main/java`.

## Toolchain

- Android Gradle Plugin 9.1.1
- Gradle 9.3.1
- Kotlin Gradle Plugin 2.2.10
- JDK 17
- compileSdk 37 / targetSdk 36 / minSdk 26
- Jetpack Compose and Preferences DataStore

## Build and test

A cloud workflow is provided at `.github/workflows/android-ci.yml`. It installs JDK, Android SDK and Gradle in GitHub Actions, then runs unit tests, Android Lint, a debug APK build and an unsigned release AAB build.

If you have a local Android SDK and JDK 17, use the Gradle wrapper scripts:

- Windows: `gradlew.bat testDebugUnitTest assembleDebug`
- macOS/Linux: `./gradlew testDebugUnitTest assembleDebug`

See `GITHUB_SETUP_AR.md` for the browser-only GitHub workflow. It is designed for machines where software installation is restricted.

## Current feature boundary

The project contains onboarding, progress dashboard, craving rescue, a local rule-based coach, insights, recovery, profile and an educational health timeline. User data is stored locally with Preferences DataStore.

The coach is not a generative AI service. Cloud sync, scheduled reminders, data export/import and production signing are not yet implemented. Health milestones are educational estimates, not individual medical predictions.

## Google Play identity

The Android application ID remains `com.toquitsmoking.quitnow`. Check the current Play Console versionCode before preparing an update. Keep the existing Play App Signing key; upload-key reset and release signing are separate later steps.

## Release status

This is a development project, not a verified production release. The first real Gradle build and test run must pass in GitHub Actions, followed by installation and behavior testing on physical Android devices. The CI-generated AAB is unsigned and must not be uploaded as a production release.
