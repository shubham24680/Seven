# Seven 🎬

**Version 1.1.0**

A beautiful and modern Flutter application for discovering and exploring movies and TV shows, powered by The Movie Database (TMDB) API. Seven provides an immersive dark-themed experience with smooth animations, comprehensive movie details, and an intuitive user interface.

![Flutter](https://img.shields.io/badge/Flutter-3.6.0+-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.6.0+-0175C2?logo=dart&logoColor=white)
<!-- ![License](https://img.shields.io/badge/license-MIT-blue) -->

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
  - Quick access to search

- **🎬 Movie Details**
  - Comprehensive movie information
  - High-quality poster and backdrop images
  - Genre tags and ratings
  - Cast and crew information with profile pictures
  - Production companies and countries
  - Runtime, budget, and revenue information
  - Related movies in collections
  - Expandable overview section
  - Navigate to full cast & crew screen

- **📚 Collections**
  - Browse movies by category
  - Genre-based collections
  - Cast-specific movie collections
  - Infinite scroll with pagination
  - Grid and list view support
  - Portrait and landscape card orientations
  - Quick navigation to full collections
  - Floating action button to scroll to top

- **🔍 Search & Discovery**
  - Browse movies by genre
  - Advanced search with text input
  - Multi-genre filtering with chips
  - Real-time search results
  - Infinite scroll pagination
  - Empty state handling
  - Genre cards with custom artwork

- **👥 Cast & Crew**
  - Detailed cast information
  - Crew organized by department
  - Profile pictures and character names
  - Job titles and roles
  - Grid layout for easy browsing

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
  - Infinite scroll with smart pagination
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
- **Flutter Native Splash** 2.4.4 - Native splash screen

### Media
- **Video Player** 2.8.2 - Video playback support
- **Chewie** 1.7.5 - Video player UI

### Utilities
- **Intl** 0.20.2 - Internationalization and formatting
- **URL Launcher** 6.3.2 - Launch external URLs
- **Window Size** - Desktop window management

---

## 📦 Installation

### Prerequisites

- Flutter SDK (3.6.0 or higher)
- Dart SDK (3.6.0 or higher)
- Android Studio / Xcode (for mobile development)
- VS Code or Android Studio with Flutter extensions
- Git

### Clone the Repository

```bash
git clone https://github.com/shubham24680/seven.git
cd seven
```

### Install Dependencies

```bash
flutter pub get
```

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
   ```

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

## 📁 Project Structure

```
lib/
├── app/                         # Application setup
│   ├── native/                  # Native platform bridge
│   └── app.dart                 # Central export file
├── core/                        # Core functionality
│   ├── constants/               # App constants (API, assets, etc.)
│   ├── customs/                 # Custom reusable widgets
│   ├── packages/                # Package exports
│   ├── routes/                  # Navigation configuration
│   ├── services/                # API and business logic
│   ├── storage/                 # Local storage utilities
│   ├── theme/                   # App theming
│   └── utils/                   # Utility functions
├── features/                    # Feature modules
│   ├── collections/             # Collection screens (genre, search, cast)
│   ├── detail/                  # Movie detail screens
│   ├── error/                   # Error handling screens
│   ├── movies/                  # Main movie screens (home, search, profile)
│   ├── notification/            # Notification screens
│   ├── onboarding/              # Onboarding flow
│   └── profile/                 # Profile management
├── model/                       # Data models
│   ├── credits_model.dart       # Cast and crew models
│   ├── helper_model.dart        # Helper data classes
│   ├── models.dart              # Model exports
│   └── shows_model.dart         # Movie/show models
├── providers/                   # Riverpod providers
│   ├── collection_providers.dart      # Collection scroll state
│   ├── genre_collection_providers.dart # Genre collections
│   ├── helper_providers.dart          # Navigation and home state
│   ├── onboarding_providers.dart      # Onboarding state
│   ├── profile_provider.dart          # Profile state
│   ├── providers.dart                 # Provider exports
│   ├── search_providers.dart          # Search functionality
│   ├── show_detail_provider.dart      # Movie details and credits
│   └── shows_provider.dart            # Movie collections
└── main.dart                    # App entry point
```

---

## 🎨 Architecture

### State Management

Seven uses **Flutter Riverpod** for state management with the following patterns:

- **AsyncNotifierProvider**: For async data fetching (movies, details, collections, search)
- **StateNotifierProvider**: For UI state management (navigation, profile, onboarding, scroll)
- **Family Providers**: For parameterized providers (details by ID, genre collections, search)
- **Provider.autoDispose**: For temporary state that should be disposed
- **StateProvider**: For simple state like navigation index

### Service Layer

- **BaseService**: Core HTTP client with error handling and timeout configuration
- **ShowsServices**: Movie and TV show data fetching service
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
- `CustomCollection` - Collection display widgets with grid/list support
- `CustomTextField` - Input fields with validation and dropdown support
- `CustomTag` - Badge/tag widgets for genres and categories
- `HelperCustom` - Helper widgets (blur effects, shimmer, app bar, bottom sheet)

### Routing

Seven uses **GoRouter** for declarative, type-safe navigation with:
- Named routes for all screens
- Deep linking support
- Route guards and redirects (first-time visit check)
- Nested navigation support
- Fade transition animations

### Data Flow

```
UI (Screens) 
  ↓
Providers (State Management)
  ↓
Services (API Calls)
  ↓
Models (Data Parsing)
  ↓
UI (Display)
```

---

## 📖 Usage

### Navigation

- **Home**: Browse trending movies and collections
- **Profile**: View and edit your profile
- **Movie Details**: Tap any movie card to view details
- **Collections**: Tap "See all" to view full collections
- **Onboarding**: Shown on first launch

### Features Guide

1. **Browse Movies**
   - Swipe through trending carousel on home
   - Scroll through collections horizontally
   - Tap "See all" for full collection view
   - Browse by genre from search tab

2. **Search Movies**
   - Navigate to Search tab
   - Tap search field to open advanced search
   - Type movie title and tap "Go"
   - Filter by multiple genres using chips
   - Scroll to load more results

3. **View Details**
   - Tap any movie card
   - Scroll to see complete information
   - View cast and crew with profile pictures
   - Tap "See all" on cast to view full cast & crew
   - View related movies in collection
   - Read full overview in bottom sheet

4. **Explore Cast & Crew**
   - From detail screen, tap cast section
   - View actors with character names
   - Browse crew organized by department
   - See profile pictures and job titles

5. **Manage Profile**
   - Navigate to Profile tab
   - Tap "Edit profile" to modify
   - Select avatar, name, gender, and DOB
   - Save changes
   - Access help and notification settings

---

## 🎯 Key Features Implementation

### Image Caching
- Uses `CachedNetworkImage` for efficient image loading
- Automatic placeholder and error handling
- Shimmer loading effects

### Responsive Design
- ScreenUtil for device-independent sizing
- Supports phones, tablets, and desktop
- Adaptive layouts for different screen sizes

### Error Handling
- Comprehensive error screens
- Network error detection
- Retry mechanisms
- Graceful fallbacks

### Performance
- Lazy loading for lists
- Image caching
- Efficient state updates
- Optimized rebuilds

---

## 🐛 Troubleshooting

### Common Issues

**API Errors**
- Verify API key and Bearer token in `api_constants.dart`
- Check internet connection
- Ensure TMDB API is accessible

**Build Errors**
- Run `flutter clean` then `flutter pub get`
- Ensure all dependencies are compatible
- Check Flutter and Dart SDK versions

**Image Loading Issues**
- Check network connectivity
- Verify image URLs from TMDB
- Ensure proper image paths in constants

---

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

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## 👤 Author

**Shubham Patel**
- GitHub: [@shubham24680](https://github.com/shubham24680)
- Email: subhampatel8092@gmail.com

---

## 🙏 Acknowledgments

- [The Movie Database (TMDB)](https://www.themoviedb.org/) for providing the API
- Flutter team for the amazing framework
- All open-source contributors whose packages made this project possible

---

## 📊 Version History

### v1.1.0 (Current)
- Advanced search with genre filtering
- Cast and crew information screens
- Genre-based collections
- Infinite scroll pagination
- Floating action buttons for navigation
- Enhanced error handling
- Search collection screen
- Cast collection screen
- Genre collection screen
- Detail collection screen
- Improved state management

### v1.0.0
- Initial release
- Onboarding flow
- Movie browsing and discovery
- Movie details view
- Collections view
- User profile management
- Dark theme implementation
- Responsive design support

---

## 🔮 Future Enhancements

- [ ] Favorites/watchlist
- [ ] Movie trailers playback
- [ ] User reviews and ratings
- [ ] Social features
- [ ] Offline mode
- [ ] Push notifications implementation
- [ ] Multiple language support
- [ ] Advanced filtering and sorting
- [ ] TV show support
- [ ] Personalized recommendations

---

## 📞 Support

For support, email subhampatel8092@gmail.com or open an issue on GitHub.

---

## ⭐ Show Your Support

If you find this project helpful, please give it a star on GitHub!

---

**Made with ❤️ using Flutter**
