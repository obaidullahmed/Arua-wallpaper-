# Aura Wallpapers

Aura Wallpapers is a premium Android live wallpaper application built with Flutter and native Android Kotlin. The app supports local wallpaper browsing, previewing, favorites persistence, and actual Android live wallpaper application through a native `WallpaperService` engine.

## Features

- Premium dark UI with home, category, detail, preview, favorites, and settings screens
- Local wallpaper catalog with image, video, and motion wallpaper support
- Live wallpaper application through Android native WallpaperService
- Video live wallpaper engine with looping playback
- Parallax motion wallpaper engine using device sensors
- Persistent favorites with `SharedPreferences`
- Settings for motion sensitivity and battery saver mode

## Project Structure

- `lib/` - Flutter UI, state management, data models, and services
- `android/app/src/main/kotlin/com/aurawallpapers/app/` - Native Kotlin code for live wallpaper engine and channel handling
- `android/app/src/main/res/xml/` - Wallpaper metadata definition files
- `assets/` - Local wallpaper assets and icons

## Setup and Run

1. Open the Flutter project in your IDE or VS Code.
2. Install dependencies:
   ```bash
   cd aura_wallpapers
   flutter pub get
   ```
3. Run the app on an Android device or emulator:
   ```bash
   flutter run
   ```

## Notes

- The app currently uses bundled local wallpaper assets and is architected to support remote content later.
- The live wallpaper application flow is implemented through native Android `WallpaperService` components and the system wallpaper picker.
- Configure `Settings` to enable or disable motion wallpaper behavior and battery saving.
