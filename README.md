# Seven 🎬

**Version 1.1.0**

A beautiful and modern Flutter application for discovering and exploring movies and TV shows, powered by The Movie Database (TMDB) API. Seven provides an immersive dark-themed experience with smooth animations, comprehensive movie details, and an intuitive user interface.

![Flutter](https://img.shields.io/badge/Flutter-3.6.0+-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.6.0+-0175C2?logo=dart&logoColor=white)

---
## 📺 Screens

<img width="330" height="717" alt="onboarding" src="https://github.com/user-attachments/assets/b64258a2-ca22-437b-97eb-aaac7ef3920c" />     <img width="330" height="717" alt="home" src="https://github.com/user-attachments/assets/0459849b-21cd-4fb4-8b38-5971e61e82dc" />     <img width="330" height="717" alt="detail" src="https://github.com/user-attachments/assets/8adb99d5-4eec-40cd-a4bd-90e6508943b1" />     <img width="330" height="717" alt="profile" src="https://github.com/user-attachments/assets/24c107b0-d58f-4eb8-b1c0-94aa650ef564" />

---

## 📱 Features

### Core Features

- **🎯 Onboarding Experience**
  - Beautiful multi-page onboarding flow
  - Introduces app features to first-time users
  - Seamless navigation after onboarding

- **🏠 Home Screen**
  - Trending movies carousel with auto-play
  - Top 20 highest-rated movies collection
  - New releases section
  - Upcoming movies preview
  - Smooth horizontal and vertical scrolling
  - Quick search access

- **🎬 Movie Details**
  - Comprehensive movie information
  - High-quality poster and backdrop images
  - Genre tags and ratings
  - Cast and crew information
  - Production companies and countries
  - Runtime, budget, and revenue information
  - Related movies in collections
  - Expandable overview section

- **📚 Collections**
  - Browse movies by category
  - Genre-based collections
  - Cast-specific movie collections
  - Search within collections
  - Detailed collection views
  - Grid and list view support
  - Portrait and landscape card orientations

- **🔍 Search**
  - Real-time movie search
  - Search results with movie cards
  - Quick navigation to movie details

- **👤 User Profile**
  - Customizable profile with avatar selection
  - Personal information management
  - Profile editing with validation
  - Gender and date of birth selection

- **⚡ Performance**
  - Optimized image loading with caching
  - Smooth animations and transitions
  - Efficient state management with Riverpod
  - Responsive design for all screen sizes
  - Error handling with custom error screens

---

## 🛠️ Tech Stack

### Framework & Language
- **Flutter** 3.6.0+
- **Dart** 3.6.0+

### State Management
- **Flutter Riverpod** 2.6.1 - Modern state management solution

### Navigation
- **GoRouter** 16.2.4 - Declarative routing with type-safe navigation

### Networking
- **HTTP** 1.2.2 - HTTP client for API requests

### Storage
- **Shared Preferences** 2.2.2 - Local data persistence

### UI & Design
- **Flutter ScreenUtil** 5.9.3 - Responsive UI scaling
- **Cached Network Image** 3.4.1 - Image caching and loading
- **Flutter SVG** 2.0.10 - SVG image rendering
- **Shimmer** 3.0.0 - Loading skeleton effects
- **Carousel Slider** 5.1.1 - Carousel components
- **Smooth Page Indicator** 1.2.1 - Page indicators
- **Flutter Native Splash** 2.4.4 - Native splash screen

### Media
- **Video Player** 2.8.2 - Video playback support
- **Chewie** 1.7.5 - Video player UI

### Utilities
- **Intl** 0.20.2 - Internationalization and formatting
- **URL Launcher** 6.3.2 - Launch external URLs

---

## ⚙️ Configuration

### API Setup

Seven uses The Movie Database (TMDB) API to fetch movie data. You need to configure your API credentials:

1. **Get TMDB API Key**
   - Visit [TMDB](https://www.themoviedb.org/) and create an account
   - Go to Settings → API → Request an API Key
   - Copy your API key and Bearer token

2. **Configure API Credentials**

   Open `lib/core/constants/api_constants.dart` and update with `documents/api_constant_document.md`



### Build Configuration

#### Android

1. Minimum SDK: 21 (Android 5.0)
2. Target SDK: Latest
3. Update `android/app/build.gradle` if needed

#### iOS

1. Minimum iOS: 12.0
2. Update `ios/Podfile` if needed
3. Run `pod install` in the `ios` directory

---

## 🎨 Architecture

Seven follows a clean, modular architecture with clear separation of concerns:

### Project Structure

```
lib/
├── app/                    # Application setup and configuration
│   ├── native/            # Native platform bridge
│   └── app.dart           # Main app widget
├── core/                   # Core functionality and utilities
│   ├── constants/         # API, app, storage constants
│   ├── customs/           # Custom reusable widgets
│   ├── packages/          # Package exports
│   ├── routes/            # GoRouter configuration
│   ├── services/          # API services and networking
│   ├── storage/           # Local storage management
│   ├── theme/             # App theming
│   └── utils/             # Utility functions and widgets
├── features/              # Feature modules
│   ├── collections/       # Collection screens and widgets
│   ├── detail/            # Movie detail screens
│   ├── error/             # Error handling screens
│   ├── movies/            # Home, search, profile screens
│   ├── notification/      # Notification feature
│   ├── onboarding/        # Onboarding flow
│   └── profile/           # Profile management
├── model/                 # Data models
│   ├── credits_model.dart
│   ├── shows_model.dart
│   └── helper_model.dart
├── providers/             # Riverpod state providers
│   ├── shows_provider.dart
│   ├── show_detail_provider.dart
│   ├── collection_providers.dart
│   ├── genre_collection_providers.dart
│   ├── search_providers.dart
│   ├── profile_provider.dart
│   ├── onboarding_providers.dart
│   └── helper_providers.dart
└── main.dart              # Application entry point
```

### State Management

Seven uses **Flutter Riverpod** for state management with the following patterns:

- **AsyncNotifierProvider**: For async data fetching (movies, details, collections)
- **StateNotifierProvider**: For UI state management (navigation, profile, onboarding)
- **Family Providers**: For parameterized providers (details by ID, genre collections)
- **Provider.autoDispose**: For temporary state that should be disposed

### Service Layer

- **BaseService**: Core HTTP client with error handling and timeout configuration
- **ShowsServices**: Movie data fetching service
- **CreditsServices**: Cast and crew information service
- **Network**: Network connectivity utilities
- **ApiResult**: Result wrapper for API responses
- **ApiException**: Custom exception handling
- **SharedPreferencesData**: Persistent storage wrapper for user data

### Custom Widgets

All UI components are built with custom widgets for consistency:

- `CustomButton` - Buttons with multiple types (elevated, icon, text)
- `CustomText` - Styled text with consistent typography
- `CustomImage` - Image widget supporting multiple sources (network, asset, SVG)
- `CustomCard` - Movie/show cards with various layouts
- `CustomCollection` - Collection display widgets
- `CustomTextField` - Input fields with validation
- `CustomTag` - Badge/tag widgets for genres and categories
- `HelperCustom` - Helper widgets for common UI patterns

### Routing

Seven uses **GoRouter** for declarative, type-safe navigation with:
- Named routes for all screens
- Deep linking support
- Route guards and redirects
- Nested navigation support

## 📝 Documentation

- **Features Documentation**: See `documents/feature_document.md` for detailed screen documentation
- **Core Documentation**: See `documents/core_and_other_document.md` for architecture and core components

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Code Style

- Follow Flutter/Dart style guidelines
- Use meaningful variable and function names
- Add comments for complex logic
- Maintain consistent formatting

---

## 👤 Author

**Shubham Patel**
- GitHub: [shubham24680](https://github.com/shubham24680)
- Email: subhampatel8092@gmail.com

---

## 🙏 Acknowledgments

- [The Movie Database (TMDB)](https://www.themoviedb.org/) for providing the API
- Flutter team for the amazing framework
- All open-source contributors whose packages made this project possible

---

## 📞 Support

For support, email subhampatel@gmail.com or open an issue on GitHub.

---

## ⭐ Show Your Support

If you find this project helpful, please give it a star on GitHub!

---

**Made with ❤️ using Flutter**
