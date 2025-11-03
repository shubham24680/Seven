# Seven 🎬

**Version 1.0.0**

A beautiful and modern Flutter application for discovering and exploring movies and TV shows, powered by The Movie Database (TMDB) API. Seven provides an immersive dark-themed experience with smooth animations, comprehensive movie details, and an intuitive user interface.

![Flutter](https://img.shields.io/badge/Flutter-3.6.0+-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.6.0+-0175C2?logo=dart&logoColor=white)

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

- **🎬 Movie Details**
  - Comprehensive movie information
  - High-quality poster and backdrop images
  - Genre tags and ratings
  - Production companies and countries
  - Runtime, budget, and revenue information
  - Related movies in collections
  - Expandable overview section

- **📚 Collections**
  - Browse movies by category
  - Grid and list view support
  - Portrait and landscape card orientations
  - Quick navigation to full collections

- **👤 User Profile**
  - Customizable profile with avatar selection
  - Personal information management
  - Profile editing with validation
  - Gender and date of birth selection

- **⚡ Performance**
  - Optimized image loading with caching
  - Smooth animations and transitions
  - Efficient state management
  - Responsive design for all screen sizes

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
- **JSON Annotation** 4.8.1 - JSON serialization

### Storage
- **Shared Preferences** 2.2.2 - Local data persistence

### UI & Design
- **Flutter ScreenUtil** 5.9.3 - Responsive UI scaling
- **Cached Network Image** 3.4.1 - Image caching and loading
- **Flutter SVG** 2.0.10 - SVG image rendering
- **Shimmer** 3.0.0 - Loading skeleton effects
- **Carousel Slider** 5.1.1 - Carousel components
- **Smooth Page Indicator** 1.2.1 - Page indicators

### Media
- **Video Player** 2.8.2 - Video playback support
- **Chewie** 1.7.5 - Video player UI

### Utilities
- **Intl** 0.20.2 - Internationalization and formatting
- **URL Launcher** 6.3.2 - Launch external URLs
- **Window Size** - Desktop window management

---

## ⚙️ Configuration

### API Setup

Seven uses The Movie Database (TMDB) API to fetch movie data. You need to configure your API credentials:

1. **Get TMDB API Key**
   - Visit [TMDB](https://www.themoviedb.org/) and create an account
   - Go to Settings → API → Request an API Key
   - Copy your API key and Bearer token

2. **Configure API Credentials**

   Open `lib/core/constants/api_constants.dart` and update:

   ```dart
   class ApiConstants {
    static const String API_KEY = "YOUR_API_KEY_HERE";
    static const String BEARER_TOKEN = "Bearer YOUR_BEARER_TOKEN_HERE";
     
    // BASE URLs
    static const String BASE_URL = "https://api.themoviedb.org/";
    static const String VERSION_3 = "3/";
    static const String IMAGE_PATH = "https://image.tmdb.org/t/p/";
    static const String PIXEL_500 = "w500";

    // Timeouts
    static const Duration CONNECTION_TIMEOUT = Duration(seconds: 30);
    static const Duration RECEIVE_TIMEOUT = Duration(seconds: 30); //Not used yet.

    // Default params
    static const String DEFAULT_LANGUAGE = 'en-US';

    // ENDPOINTS
    static const String TRENDING = "trending/all/day";
    static const String TRENDING_MOVIES = "trending/movie/day";
    static const String TRENDING_TV = "trending/tv/day";

    static const String MOVIES = "discover/movie";
    static const String TOP_RATED = "movie/top_rated";
    static const String NOW_PLAYING = "movie/now_playing";
    static const String UPCOMING = "movie/upcoming";

    static const String MOVIE_DETAIL = "movie/";
    static const String COLLECTION_DETAIL = "collection/";

    static const String SEARCH = "search/movie";
    static const String GENRES = "genre/movie/list";
   }

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

### State Management

Seven uses **Flutter Riverpod** for state management with the following patterns:

- **AsyncNotifierProvider**: For async data fetching (movies, details)
- **StateNotifierProvider**: For UI state management (navigation, profile)
- **Family Providers**: For parameterized providers (details by ID)
- **Provider.autoDispose**: For temporary state that should be disposed

### Service Layer

- **BaseService**: Core HTTP client with error handling
- **ShowsServices**: Movie data fetching service
- **SharedPreferencesData**: Persistent storage wrapper

### Custom Widgets

All UI components are built with custom widgets for consistency:

- `CustomButton` - Buttons with multiple types (elevated, icon, text)
- `CustomText` - Styled text with consistent typography
- `CustomImage` - Image widget supporting multiple sources
- `CustomCard` - Movie/show cards
- `CustomCollection` - Collection display widgets
- `CustomTextField` - Input fields with validation
- `CustomTag` - Badge/tag widgets

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
