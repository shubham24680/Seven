# Core and Other Folders Documentation - File-wise

This document provides a comprehensive overview of all files in the `core`, `model`, `providers`, `app`, and other folders, explaining their purpose and functionality.

## Table of Contents
1. [Core Folder](#core-folder)
2. [Model Folder](#model-folder)
3. [Providers Folder](#providers-folder)
4. [App Folder](#app-folder)

---

## Core Folder

The core folder contains reusable utilities, services, constants, and custom widgets used throughout the app.

### Constants

#### `constants/api_constants.dart`
**Purpose**: API configuration and endpoint definitions.

**Contents**:
- **API Keys**: `API_KEY` and `BEARER_TOKEN` for TMDB API authentication
- **Base URLs**: 
  - `BASE_URL`: TMDB API base URL (`https://api.themoviedb.org/`)
  - `VERSION_3`: API version (`3/`)
  - `IMAGE_PATH`: Image CDN base URL (`https://image.tmdb.org/t/p/`)
  - `PIXEL_500`: Image size constant (`w500`)
- **Timeouts**: Connection and receive timeout durations (30 seconds)
- **Default Params**: Default language (`en-US`)
- **Endpoints**:
  - Trending: `trending/all/day`, `trending/movie/day`, `trending/tv/day`
  - Movies: `discover/movie`, `movie/top_rated`, `movie/now_playing`, `movie/upcoming`
  - Detail: `movie/{id}`, `collection/{id}`
  - Search: `search/movie`
  - Genres: `genre/movie/list`

**Usage**: Imported by all service classes and API-related code.

---

#### `constants/app_constants.dart`
**Purpose**: Application-wide constants and static data.

**Contents**:
- **UI Constants**:
  - `SIDE_PADDING`: Standard padding value (20.0)
  - `CARD_RATIO_LANDSCAPE`: Aspect ratio for landscape cards (1.78)
  - `CARD_RATIO_PORTRAIT`: Aspect ratio for portrait cards (0.67)
- **Routes**: `APP_ROUTES` list defining all app routes with paths and widgets
- **Onboarding Text**: Three pages of onboarding content (headings and descriptions)
- **Collections**: Collection names list
- **Profile**: Profile menu items with icons and routes
- **Gender**: Gender options with icons
- **Error Data**: Error screen configuration (title, message, image, buttons)

**Usage**: Used throughout the app for consistent spacing, routing, and static content.

---

#### `constants/app_assets.dart`
**Purpose**: Asset path definitions and asset lists.

**Contents**:
- **AppAssets Class**:
  - `BOTTOM_NAVIGATION_ICONS`: List of bottom nav items with icons and screens
  - `ONBOARDING_IMAGES`: List of onboarding background images
  - `AVATARS`: List of avatar image paths
- **AppImages Class**: Static constants for image asset paths
  - Avatar images
  - Genre card images
  - Onboarding images
  - Placeholder image
- **AppSvgs Class**: Static constants for SVG icon paths
  - Navigation icons (arrow, home, profile, search)
  - Action icons (star, calendar, play, save)
  - Feature icons (notification, help, male, female)
  - Status icons (no internet, no connection)
- **AppGifs Class**: GIF asset paths
  - No internet animation
- **AppFonts Class**: Font family names
  - `POPPINS`: Default body font
  - `STAATLICHES`: Heading font

**Usage**: Referenced throughout the app for asset paths and icon identifiers.

---

#### `constants/storage_constants.dart`
**Purpose**: SharedPreferences key constants.

**Contents**:
- `FIRST_VISIT`: First-time visit flag key
- `PROFILE_PIC_INDEX`: Profile picture index key
- `NAME`: User name key
- `GENDER_INDEX`: Gender selection index key
- `DATE_OF_BIRTH`: Date of birth key

**Usage**: Used by `shared_preferences_data.dart` to store and retrieve user data.

---

### Services

#### `services/base_services.dart`
**Purpose**: Core HTTP service handling all API requests.

**Key Features**:
- Singleton pattern implementation
- HTTP client management
- Request/response handling
- Error handling and exception mapping
- Support for GET, POST, PUT, DELETE methods
- Timeout management
- Response status code handling

**Methods**:
- `fetchData()`: Main method for API calls
  - Parameters: `apiHost`, `endPoint`, `responseType`, `version`, `body`, `queryParams`
  - Returns: `Map<String, dynamic>`
- `_get()`, `_post()`, `_put()`, `_delete()`: HTTP method implementations
- `_buildUri()`: URI construction with query parameters
- `_processResponse()`: Response processing with status code handling

**Error Handling**:
- `SocketException` → `NetworkException`
- `ClientException` → `NetworkException`
- `FormatException` → `ApiException`
- Status codes:
  - 200/201: Success
  - 400: Bad request
  - 401: Unauthorized
  - 403: Forbidden
  - 404: Not found
  - 429: Too many requests
  - 500/502/503: Server errors

**Usage**: Foundation for all API service classes.

---

#### `services/shows_services.dart`
**Purpose**: Movie/show data service layer.

**Key Features**:
- Singleton pattern
- Methods for fetching different movie categories
- Search functionality
- Detail and collection fetching
- Error logging

**Methods**:
- `fetchTrendingShows(page)`: Fetch trending movies
- `fetchTopShows(page)`: Fetch top-rated movies
- `fetchNewReleaseShows(page)`: Fetch now-playing movies
- `fetchUpcomingShows(page)`: Fetch upcoming movies
- `fetchShowDetail(id)`: Fetch movie details
- `fetchCollectionDetail(id)`: Fetch collection details
- `fetchGenres()`: Fetch movie genres
- `search(query)`: Search movies by query
- `_fetchShows()`: Internal method for fetching show lists
- `_fetchResult()`: Internal method for fetching single results

**Error Handling**: Catches and logs errors, rethrows as `ApiException`.

**Usage**: Called by Riverpod providers to fetch movie data.

---

#### `services/api_exception.dart`
**Purpose**: Custom exception classes for API errors.

**Classes**:
- `ApiException`: Base exception with message, statusCode, and error
- `NetworkException`: Network connectivity errors
- `TimeoutException`: Request timeout errors (408)
- `ServerException`: Server-side errors (500, 502, 503)
- `UnauthorizedException`: Authentication errors (401)

**Usage**: Thrown by services and caught by providers/UI.

---

#### `services/api_result.dart`
**Purpose**: Type-safe API result wrapper (sealed class pattern).

**Classes**:
- `ApiResult<T>`: Sealed base class
- `Success<T>`: Success case with data
- `Failure<T>`: Failure case with exception

**Extensions**:
- `isSuccess`, `isFailure`: Boolean checks
- `dataOrNull`, `exceptionOrNull`: Safe getters
- `when()`: Pattern matching method for handling results

**Usage**: Alternative result handling pattern (currently not extensively used).

---

#### `services/network.dart`
**Purpose**: Network state management class.

**Features**:
- Tracks API status (INITIAL, SUCCESS, LOADING, ERROR)
- Success and error messages
- Error count tracking
- Status checkers: `isInitial`, `isSuccess`, `isLoading`, `isError`
- Methods: `setApiStatus()`, `count()`, `defaultCount()`

**Usage**: Base class for state classes that need network status tracking (e.g., `ShowsModel`, `Result`).

---

### Storage

#### `storage/shared_preferences_data.dart`
**Purpose**: SharedPreferences wrapper for persistent storage.

**Features**:
- Singleton pattern with async initialization
- Getter methods for all stored values
- Setter methods for all stored values
- Clear methods (profile data, all data)
- Helper methods (`containsKey()`, `getAllKeys()`)

**Stored Data**:
- First-time visit flag
- Profile picture index
- User name
- Gender index
- Date of birth

**Methods**:
- `getInstance()`: Async singleton getter
- `isFirstTimeVisit`, `profilePicIndex`, `name`, `genderIndex`, `dateOfBirth`: Getters
- `setFirstTimeVisit()`, `setProfilePicIndex()`, `setName()`, `setGenderIndex()`, `setDateOfBirth()`: Setters
- `clearProfileData()`, `clearAll()`: Clear methods

**Usage**: Used by providers and services for persistent data storage.

---

### Routes

#### `routes/routes.dart`
**Purpose**: Application routing configuration using GoRouter.

**Features**:
- Initial location: `/` (home)
- Route guard: Redirects to onboarding if first-time visit
- Dynamic routes:
  - `/detail/:id`: Movie detail screen
  - `/collection/:id`: Collection screen with name parameter
- Static routes: Generated from `AppConstants.APP_ROUTES`
- Fade transition animations between screens

**Routes**:
- `/`: Home (Shows screen)
- `/onboarding`: Onboarding screen
- `/detail/:id`: Movie detail
- `/collection/:id`: Collection view
- `/notification`: Notification screen
- `/editProfile`: Edit profile screen
- `/notificationSettings`: Notification settings
- `/help`: Help screen

**Usage**: Configured in `main.dart` as the app's router.

---

### Theme

#### `theme/dark_theme.dart`
**Purpose**: Dark theme configuration.

**Features**:
- Dark color scheme
- Scaffold background: `black3`
- App bar theme: `lightSteel9`
- Color scheme:
  - Primary: `lightSteel1`
  - Secondary: `vividNightfall4`
  - Tertiary: `lightSteel9`
- Text selection theme with purple highlight

**Usage**: Applied globally in `main.dart`.

---

### Utils

#### `utils/colors.dart`
**Purpose**: Application color palette definitions.

**Color Families**:
- **Red Palette** (`red1` to `red5`): Error and danger colors
- **Light Steel Palette** (`lightSteel1` to `lightSteel9`): Grayscale from white to dark
- **Vivid Nightfall Palette** (`vividNightfall1` to `vividNightfall8`): Purple gradient (primary brand color)
- **Black Palette** (`black1` to `black5`): Dark backgrounds

**Usage**: Referenced throughout the app for consistent coloring.

---

#### `utils/widgets.dart`
**Purpose**: Utility functions for data formatting and widget helpers.

**Functions**:
- `getImageUrl(endPoint)`: Constructs full image URL from TMDB endpoint
- `getRuntime(runtime)`: Formats runtime in hours and minutes
- `getDateFormat(date, type)`: Formats dates (DATE or YEAR format)
- `getCurrencyFormat(currency, locale)`: Formats currency values with $ symbol

**Usage**: Used throughout the app for data presentation.

---

### Customs (Custom Widgets)

#### `customs/text.dart`
**Purpose**: Custom text widget with consistent styling.

**Features**:
- Customizable font family, size, color, weight
- Text alignment options
- Max lines and overflow handling
- Optional first word capitalization
- Default font: Poppins
- Responsive sizing using `sh` (screen height)

**Props**:
- `text`: Required text content
- `family`: Font family (default: Poppins)
- `size`: Font size (default: 0.02.sh)
- `color`: Text color
- `weight`: Font weight
- `align`: Text alignment
- `maxLines`, `overflow`: Text clipping
- `capitalFirstWord`: Capitalize first letter

**Usage**: Replaces standard `Text` widget throughout the app.

---

#### `customs/button.dart`
**Purpose**: Custom button widget with multiple types.

**Types**:
- `ELEVATED`: Standard elevated button
- `ICON`: Icon button (circular)
- `TEXT`: Text-only button

**Features**:
- Customizable background and foreground colors
- Blur effect support
- Responsive sizing
- Disabled state handling
- Custom border radius

**Usage**: All buttons in the app use this widget.

---

#### `customs/image.dart`
**Purpose**: Custom image widget supporting multiple image types.

**Image Types**:
- `REMOTE`: Network images (uses `CachedNetworkImage`)
- `LOCAL`: Asset images
- `SVG_REMOTE`: Remote SVG (not currently used)
- `SVG_LOCAL`: Local SVG assets

**Features**:
- Shimmer placeholder during loading
- Error fallback to placeholder image
- Color tinting for SVGs
- Border radius support
- Tap event handling
- BoxFit customization

**Usage**: All images in the app use this widget.

---

#### `customs/card.dart`
**Purpose**: Movie/show card widget.

**Features**:
- Portrait and landscape orientations
- Show cards and genre cards
- Blur effect support
- Title overlay
- Responsive sizing
- Tap navigation to detail screen

**Card Types**:
- `SHOWS`: Movie/show cards
- `GENRE`: Genre category cards

**Orientations**:
- `POTRAIT`: Vertical cards (for collections)
- `LANDSCAPE`: Horizontal cards (for carousels)

**Usage**: Used in collections, carousels, and grids.

---

#### `customs/collection.dart`
**Purpose**: Collection widget for displaying movie lists.

**Features**:
- Horizontal or vertical scrolling
- Grid layout support
- Loading states with shimmer
- Collection name header
- "See all" button
- Portrait or landscape card orientation
- Loading item count customization

**Props**:
- `collectionName`: Collection title
- `results`: Movie list data
- `scrollDirection`: Horizontal or vertical
- `crossAxisCount`: Grid columns
- `orientation`: Card orientation
- `isLoading`: Loading state
- `onPressed`: "See all" button action

**Usage**: Used on home screen and collection screens.

---

#### `customs/text_field.dart`
**Purpose**: Custom text input field widget.

**Field Types**:
- `INPUT`: Standard text input
- `DROPDOWN`: Dropdown selection

**Features**:
- Filled/unfilled styles
- Custom colors (fill, hint, error, suffix icon)
- Label text support
- Error text display
- Suffix icon support
- Read-only mode
- On-tap callback
- Initial value support (for dropdowns)

**Usage**: Used in forms and edit screens.

---

#### `customs/tag.dart`
**Purpose**: Tag/badge widget for displaying metadata.

**Tag Types**:
- `FILLED`: Solid background tag
- `OUTLINED`: Border-only tag

**Features**:
- Icon support (SVG)
- Text value
- Custom colors
- Blur effect on filled tags
- Rounded corners

**Usage**: Used for genres, ratings, production companies, etc.

---

#### `customs/extension.dart`
**Purpose**: Extension methods for Flutter widgets.

**Extensions**:
- `PaddingExtension`: Adds padding methods to widgets
  - `paddingAll()`, `paddingSymmetric()`, `paddingFromLTRB()`
- `ClickExtension`: Adds tap gesture to widgets
  - `onTap()`: Adds tap handler

**Usage**: Provides convenient methods for layout and interactions.

---

#### `customs/helper_custom.dart`
**Purpose**: Helper functions and reusable UI components.

**Functions**:
- `blurEffect()`: Applies backdrop blur filter to widgets
- `customShimmer()`: Creates shimmer loading effect
- `customAppBar()`: Creates standard app bar with back button
- `customBottomSheet()`: Creates bottom sheet modal with blur effect

**Usage**: Common UI patterns used across the app.

---

### Packages

#### `packages/app_packages.dart`
**Purpose**: Central export file for all third-party packages.

**Exported Packages**:
- Material Design (Flutter)
- ScreenUtil (responsive sizing)
- Window Size (desktop window management)
- Flutter Riverpod (state management)
- GoRouter (navigation)
- CachedNetworkImage (image caching)
- Flutter SVG (SVG rendering)
- Shimmer (loading effects)
- Smooth Page Indicator (page indicators)
- Carousel Slider (carousels)
- Shared Preferences (storage)

**Usage**: Single import point for all packages in the app.

---

### Core Export

#### `core.dart`
**Purpose**: Central export file for all core modules.

**Exports**:
- All constants
- All services
- All custom widgets
- All utilities
- All storage
- Routes
- Theme
- Packages

**Usage**: Imported by `app.dart` to make all core functionality available.

---

## Model Folder

### `models.dart`
**Purpose**: Central export file for all model classes.

**Exports**:
- `helper_model.dart`
- `shows_model.dart`

---

### `shows_model.dart`
**Purpose**: Data models for movie/show data from TMDB API.

**Classes**:
- `ShowsModel`: Container for paginated movie lists
  - Properties: `dates`, `page`, `results`, `totalPages`, `totalResults`
  - Extends `Network<ShowsModel>` for status tracking
  - JSON serialization/deserialization
- `Dates`: Date range for collections
  - Properties: `maximum`, `minimum`
- `Result`: Individual movie/show data
  - Properties: All movie metadata (title, overview, genres, ratings, etc.)
  - Nested objects: `belongsToCollection`, `genres`, `productionCompanies`, etc.
  - Extends `Network<Result>` for status tracking
- `Genre`: Movie genre data
  - Properties: `id`, `name`
- `ProductionCompany`: Production company data
  - Properties: `id`, `name`, `logoPath`, `originCountry`
- `ProductionCountry`: Production country data
  - Properties: `iso3166_1`, `name`
- `SpokenLanguage`: Language data
  - Properties: `iso639_1`, `name`, `englishName`

**Usage**: Used by services and providers to parse API responses.

---

### `helper_model.dart`
**Purpose**: Helper data classes for UI and navigation.

**Classes**:
- `HelperModel`: Generic model with 5 string fields and 1 widget field
  - Used for: Profile menu items, Gender options, Error data
- `ScreenRoutes`: Route configuration
  - Properties: `path`, `child`
- `BottomNavigation`: Bottom nav item configuration
  - Properties: `icon`, `screen`
- `ErrorData`: Error screen data
  - Properties: `title`, `subtitle`, `image`, `buttonText`
- `ProfileModel`: Profile menu item
  - Properties: `icon`, `title`

**Usage**: Used for static UI configuration and navigation setup.

---

## Providers Folder

### `providers.dart`
**Purpose**: Central export file for all providers.

**Exports**:
- `show_detail_provider.dart`
- `shows_provider.dart`

---

### `shows_provider.dart`
**Purpose**: Riverpod providers for movie/show data and navigation state.

**Providers**:

1. **Show Notifiers** (Abstract base class for pagination):
   - `ShowNotifier`: Abstract base with pagination logic
   - `TrendingShowNotifier`: Fetches trending movies
   - `NewReleaseShowsNotifier`: Fetches now-playing movies
   - `UpcomingShowsNotifier`: Fetches upcoming movies
   - `TopShowNotifier`: Fetches top-rated movies
   - Methods: `load()`, `refresh()`, `loadMore()`

2. **Show Providers**:
   - `trendingShowProvider`: Trending movies
   - `topShowsProvider`: Top-rated movies
   - `newReleaseShowsProvider`: Now-playing movies
   - `upcomingShowsProvider`: Upcoming movies
   - `collectionProvider`: Generic collection provider (family)

3. **Navigation State**:
   - `ShowsState`: Navigation and carousel state
     - Properties: `navigationCurrentIndex`, `carouselCurrentIndex`, `genres`
   - `ShowsProvider`: Manages navigation state
     - Methods: `moveToPage()`, `nextTo()`, `_loadData()`
   - `showsProvider`: StateNotifierProvider

4. **Genre Provider**:
   - `genreProvider`: Fetches movie genres

**Usage**: Used by screens to fetch and display movie data.

---

### `show_detail_provider.dart`
**Purpose**: Riverpod providers for movie detail and collection data.

**Providers**:

1. **Result Notifiers** (Abstract base):
   - `ResultNotifier`: Abstract base for single result fetching
   - `refresh()`: Refresh method

2. **Detail Providers**:
   - `ShowDetailNotifier`: Fetches movie details by ID
   - `showDetailProvider`: Family provider for movie details
   - `ShowCollectionDetailNotifier`: Fetches collection details by ID
   - `showCollectionDetailProvider`: Family provider for collections

3. **Collection Provider**:
   - `ShowCollectionNotifier`: Fetches collection for a movie
     - First gets movie detail, then fetches collection
   - `showCollectionProvider`: Family provider

**Usage**: Used by `DetailScreen` to fetch movie and collection data.

---

## App Folder

### `app.dart`
**Purpose**: Central export file making all app modules available.

**Exports**:
- `core/core.dart`: All core functionality
- `features/features.dart`: All feature screens and components
- `model/models.dart`: All data models
- `providers/providers.dart`: All Riverpod providers

**Usage**: Single import for the entire app (`import 'package:seven/app/app.dart';`).

---

## Feature Providers

### Onboarding Provider

#### `features/onboarding/providers/onboarding_providers.dart`
**Purpose**: Onboarding page state management.

**Classes**:
- `PageState`: Page controller and current index
- `PageProvider`: StateNotifier managing onboarding flow
  - Methods:
    - `changeFirstTimeVisitStatus()`: Marks onboarding as complete
    - `moveToPage()`: Updates page index
    - `jumpToPage()`: Animates to specific page
- `pageProvider`: StateNotifierProvider

**Usage**: Used by `OnboardingScreen` for page navigation.

---

### Profile Provider

#### `features/profile/providers/profile_provider.dart`
**Purpose**: User profile state management.

**Classes**:
- `ProfileState`: Profile data and editing state
  - Properties: `profilePicIndex`, `genderIndex`, `tryEditing`, `name`, `dateOfBirth`, text controllers
- `ProfileProvider`: StateNotifier managing profile
  - Methods:
    - `loadData()`: Loads profile from SharedPreferences
    - `saveData()`: Saves profile to SharedPreferences
    - `loadIntoField()`: Loads data into text controllers
    - `clearFromField()`: Clears text controllers
    - `toggle()`: Toggles edit/view mode
    - `setProfileIndexTo()`: Updates profile picture
    - `setGenderIndexTo()`: Updates gender selection
- `profileProvider`: StateNotifierProvider

**Usage**: Used by `ProfileScreen` and `EditProfileScreen`.

---

## Architecture Overview

### Data Flow

1. **UI Layer** (Features):
   - Screens consume providers
   - User interactions trigger provider methods

2. **State Layer** (Providers):
   - Riverpod providers manage state
   - Call services to fetch data
   - Handle loading/error/success states

3. **Service Layer** (Core/Services):
   - `BaseService`: HTTP client and request handling
   - `ShowsServices`: Movie data fetching
   - Return parsed model objects

4. **Data Layer** (Models):
   - `ShowsModel`, `Result`: Data structures
   - JSON serialization/deserialization

5. **Storage Layer** (Core/Storage):
   - `SharedPreferencesData`: Persistent storage
   - Stores user preferences and profile data

### Design Patterns

- **Singleton**: Services (`BaseService`, `ShowsServices`, `SharedPreferencesData`)
- **Factory**: Model constructors from JSON
- **State Management**: Riverpod (AsyncNotifier, StateNotifier, Provider)
- **Repository Pattern**: Services act as repositories
- **Sealed Classes**: `ApiResult` for type-safe results

### Key Conventions

- Screen height (`sh`) and width (`sw`) for responsive sizing
- Consistent padding using `AppConstants.SIDE_PADDING`
- Dark theme with purple (`vividNightfall4`) as primary color
- Custom widgets prefixed with `Custom`
- Error handling with `ErrorScreen` widget
- Loading states with shimmer effects
- Fade transitions for navigation

