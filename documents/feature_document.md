# Features Documentation - Screen-wise

This document provides a comprehensive overview of all screens in the Seven app, organized by feature folders.

## Table of Contents
1. [Onboarding](#onboarding)
2. [Movies](#movies)
3. [Detail](#detail)
4. [Collections](#collections)
5. [Profile](#profile)
6. [Notification](#notification)
7. [Error](#error)

---

## Onboarding

### OnboardingScreen (`features/onboarding/screens/onboading_screen.dart`)
**Purpose**: First-time user onboarding experience with multiple pages introducing the app.

**Key Features**:
- Multi-page onboarding flow with PageView
- Three distinct onboarding screens with different messages and images
- Background images from assets (`onboarding (1).png`, `onboarding (2).png`, `onboarding (3).png`)
- Custom typography using Staatliches font for headings
- Smooth page transitions
- Tracks first-time visit status using SharedPreferences
- "Next" button on first two pages, "Get the vibe" button on final page
- Automatically navigates to home (`/`) after completion

**User Flow**:
1. User sees first onboarding page with heading and description
2. Clicks "Next" to proceed to next page
3. Repeats for all three pages
4. On final page, clicks "Get the vibe" which marks onboarding as complete and navigates to home

**State Management**:
- Uses `pageProvider` (onboarding provider) to manage current page index
- Updates SharedPreferences to mark first-time visit as complete

---

## Movies

### Shows (`features/movies/screens/shows.dart`)
**Purpose**: Main navigation container with bottom navigation bar.

**Key Features**:
- Bottom navigation bar with Home and Profile tabs
- Manages navigation state using `showsProvider`
- Displays different screens based on selected tab:
  - Home tab: `HomeScreen`
  - Profile tab: `ProfileScreen`
- Custom icons with active/inactive states
- Active tab highlighted with `vividNightfall4` color

**Navigation Structure**:
- Uses `AppAssets.BOTTOM_NAVIGATION_ICONS` to define tabs
- Currently has Home and Profile tabs (Search tab commented out)

---

### HomeScreen (`features/movies/screens/home_screen.dart`)
**Purpose**: Main content screen displaying movie collections.

**Key Features**:
- Displays carousel of trending movies at the top (`HomeCarousel` widget)
- Shows three movie collections:
  - **Top 20 Movies**: Highest rated movies
  - **New Release**: Currently playing movies
  - **Upcoming**: Movies coming soon
- Each collection is a horizontal scrollable list of movie cards
- Loading states handled with shimmer effects
- Error states handled gracefully (empty space shown)
- "See all" button on each collection navigates to full collection view

**Data Sources**:
- Uses Riverpod providers:
  - `topShowsProvider` - Top rated movies
  - `newReleaseShowsProvider` - Now playing movies
  - `upcomingShowsProvider` - Upcoming movies

**User Interactions**:
- Tapping "See all" navigates to `CollectionScreen` with collection ID
- Tapping a movie card navigates to `DetailScreen`

---

### ProfileScreen (`features/movies/screens/profile_screen.dart`)
**Purpose**: User profile display screen.

**Key Features**:
- Displays user avatar from selected profile picture index
- Shows user name if available
- "Edit profile" button navigates to edit screen
- "Log out" button (currently not functional)
- App version display at bottom (Version 1.0.0)
- Clean, centered layout with avatar at top

**Profile Data**:
- Reads from `profileProvider`:
  - Profile picture index
  - User name
- Avatar images loaded from `AppAssets.AVATARS` list

**Navigation**:
- Edit profile button → `/editProfile`

---

### SearchScreen (`features/movies/screens/search_screen.dart`)
**Purpose**: Movie search functionality (currently commented out).

**Status**: Not currently active in the app. Code exists but is commented out.

**Intended Features** (based on commented code):
- Search text field with "Go" button
- Search results displayed in portrait grid (2 columns)
- Search functionality via `showsProvider`

---

## Detail

### DetailScreen (`features/detail/screens/detail_screen.dart`)
**Purpose**: Comprehensive movie/show detail page.

**Key Features**:
- **Hero Section**:
  - Large backdrop poster image
  - Movie title with Staatliches font
  - Metadata (status, year, runtime) in single line
  - Rating tag with star icon
  - Genre tags displayed horizontally
  - Back button in app bar

- **Overview Section**:
  - Movie description/synopsis
  - "Read more" button expands to full overview in bottom sheet
  - Truncated to 3 lines initially

- **Collection Section**:
  - Shows movies in the same collection/series
  - Filters out current movie from collection
  - Displays collection name (e.g., "Marvel Cinematic Universe")
  - Horizontal scrollable cards

- **Production Information**:
  - Production companies displayed as tags
  - Production countries displayed as tags

- **Information Section**:
  - Status and release date
  - Runtime
  - Budget (formatted as currency)
  - Revenue (formatted as currency)
  - Original audio/languages
  - Homepage link

**Data Loading**:
- Uses `showDetailProvider(id)` for movie details
- Uses `showCollectionProvider(id)` for collection data
- Loading state shows circular progress indicator
- Error state shows `ErrorScreen` with retry option

**UI Elements**:
- Gradient overlay on hero image
- Custom tags for genres, production companies/countries
- Responsive design with proper spacing
- Scrollable content with clamping physics

---

## Collections

### CollectionScreen (`features/collections/screens/collection_screen.dart`)
**Purpose**: Full collection view displaying all movies in a specific category.

**Key Features**:
- Displays complete list of movies in a collection
- Grid layout with 2 columns
- Portrait orientation cards
- Custom app bar with collection name and back button
- Handles loading and error states
- Uses `collectionProvider` with collection ID

**Collections Supported**:
- `top_20_movies` - Top rated movies
- `new_release` - Now playing movies
- `upcoming` - Upcoming movies

**Layout**:
- Vertical scrollable grid
- Portrait card orientation
- Safe height calculation for proper scrolling

**Navigation**:
- Back button returns to previous screen
- Tapping a movie card navigates to `DetailScreen`

---

## Profile

### EditProfileScreen (`features/profile/screens/edit_profile_screen.dart`)
**Purpose**: User profile editing interface.

**Key Features**:
- **Profile Picture Selection**:
  - Grid of available avatars (4 columns)
  - Tap to select avatar
  - Selected avatar highlighted with checkmark icon
  - Opens in bottom sheet modal

- **Profile Information**:
  - **Name Field**: Text input for user name
  - **Gender Field**: Dropdown with Male/Female options
  - **Date of Birth**: Date picker (CalendarDatePicker)
    - Range: 1950-2020
    - Custom dark theme styling
    - Formats date as `yMMMd`

- **Edit/View Modes**:
  - View mode: Displays current profile data as read-only
  - Edit mode: Shows input fields for modification
  - Toggle between modes with "Edit"/"Save" button

- **Save Functionality**:
  - Saves all profile data to SharedPreferences
  - Profile picture index
  - Name
  - Gender index
  - Date of birth

**State Management**:
- Uses `profileProvider` for state
- Automatically loads saved data on screen open
- Resets to saved data if user cancels (PopScope)

**UI Design**:
- Gradient background (transparent to purple)
- Large profile picture at top
- Spacious layout with proper padding

---

### HelpScreen (`features/profile/screens/help_screen.dart`)
**Purpose**: Help and support screen.

**Status**: Placeholder screen with "Help" text. Currently minimal implementation.

**Features**:
- Custom app bar with back button
- Centered "Help" text

**Future Enhancement**: Intended to provide user help and support information.

---

### NotificationSettingsScreen (`features/profile/screens/notification_settings_screen.dart`)
**Purpose**: Notification preferences screen.

**Status**: Placeholder screen with "Notification Settings" text. Currently minimal implementation.

**Features**:
- Custom app bar with back button
- Centered "Notification Settings" text

**Future Enhancement**: Intended to allow users to configure notification preferences.

---

## Notification

### NotificationScreen (`features/notification/screens/notification_screen.dart`)
**Purpose**: Display user notifications.

**Status**: Placeholder screen showing "No Notification" message.

**Features**:
- Custom app bar with back button
- Centered "No Notification" text

**Future Enhancement**: Intended to display user notifications and alerts.

---

## Error

### ErrorScreen (`features/error/error_screen.dart`)
**Purpose**: Error handling and display screen.

**Key Features**:
- Displays error message and description
- Shows error illustration/image (no connection SVG)
- "Try again" button to retry failed operation
- "Back" button (when not on home page) to navigate back
- Configurable error content via `AppConstants.ERRORDATA`

**Error Content**:
- Title: "OH NO!"
- Message: "No internet connection.\nCheck your network and try again."
- Illustration: No connection SVG
- Primary action: "Try again"
- Secondary action: "Back" (when not on home page)

**Use Cases**:
- Network errors
- API failures
- Loading errors in detail screens
- Can be used as home page error (with `isHomePage` flag)

**Design**:
- Centered layout with vertical spacing
- Large error illustration
- Prominent call-to-action buttons
- Consistent with app's dark theme

---

## Navigation Flow

### First Launch Flow
1. App checks `isFirstTimeVisit` in SharedPreferences
2. If true → Shows `OnboardingScreen`
3. After onboarding → Navigates to `Shows` (Home)
4. Sets `isFirstTimeVisit` to false

### Main Navigation Flow
1. `Shows` screen with bottom navigation
2. Home tab → `HomeScreen`
3. Profile tab → `ProfileScreen`

### Detail Flow
1. From any screen → Tap movie card → `DetailScreen`
2. From `DetailScreen` → Can navigate to collection → `CollectionScreen`

### Profile Flow
1. `ProfileScreen` → "Edit profile" → `EditProfileScreen`
2. `ProfileScreen` → Help/Notification settings → Respective screens

---

## Screen Dependencies

### Shared Providers
- `showsProvider`: Navigation and carousel state
- `profileProvider`: User profile data
- `pageProvider`: Onboarding page state
- `topShowsProvider`, `newReleaseShowsProvider`, `upcomingShowsProvider`: Movie collections
- `showDetailProvider`: Movie details
- `showCollectionProvider`: Collection data

### Shared Components
- `CustomButton`: All action buttons
- `CustomText`: All text displays
- `CustomImage`: All images
- `CustomCollection`: Movie collections
- `CustomCard`: Movie cards
- `CustomTag`: Genres, ratings, etc.
- `ErrorScreen`: Error handling

---

## Technical Notes

### State Management
- Uses Flutter Riverpod for state management
- AsyncNotifierProvider for async data
- StateNotifierProvider for UI state
- Family providers for parameterized data

### Routing
- Uses GoRouter for navigation
- Fade transitions between screens
- Route guards for first-time visit

### Responsive Design
- Uses `flutter_screenutil` for responsive sizing
- Screen height (`sh`) and width (`sw`) based sizing
- Proper padding constants (`AppConstants.SIDE_PADDING`)

### Theming
- Dark theme throughout
- Consistent color scheme (vividNightfall4 as primary)
- Custom fonts (Staatliches for headings, default for body)

