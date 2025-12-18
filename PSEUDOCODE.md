# Application Pseudocode

This document outlines the pseudocode for the Flutter-based Apartment Rental application, following a Clean Architecture pattern with Riverpod for state management and Hive for local persistence.

---

## Part 1: Application Initialization & Structure

### `main.dart`

```plaintext
FUNCTION main():
  INITIALIZE Flutter framework bindings
  INITIALIZE Hive for Flutter

  // Register all custom data model adapters for Hive
  REGISTER OwnerModelAdapter
  REGISTER ApartmentModelAdapter
  REGISTER BookingModelAdapter
  REGISTER UserModelAdapter
  REGISTER ChatConversationModelAdapter
  REGISTER ChatMessageModelAdapter

  // Open all necessary Hive boxes
  OPEN Hive box for Apartments
  OPEN Hive box for Users
  OPEN Hive box for Bookings
  OPEN Hive box for Chat Conversations
  OPEN Hive box for Chat Messages
  OPEN Hive box for User Preferences

  // Reset and Seed Database (for POC)
  CALL resetAndSeedDatabase()

  // Run the main application widget within Riverpod's scope
  RUN new ProviderScope(child: MyApp())

FUNCTION resetAndSeedDatabase():
  CLEAR all data from existing Hive boxes (Apartments, Users, Bookings, etc.)
  POPULATE apartmentBox with `seedApartments` data
  POPULATE userBox with `seedUsers` data
  POPULATE bookingBox with `seedBookings` data
  POPULATE conversationBox with `seedConversations` data
  POPULATE messageBox with `seedMessages` data
  PRINT "Database Cleared & Seeded"
```

### Core Folder Structure

```
/lib
  /core -> Shared logic (constants, router, widgets, seed_data)
  /features
    /authentication -> User login, registration
    /property_listing -> Browsing, viewing, adding/editing properties
    /booking -> Making a reservation
    /chat -> Messaging between users
    /tenant_dashboard -> Tenant's view of their rented properties
    /profile -> User profile screens
```

---

## Part 2: Routing & Navigation

### `app_router.dart`

```plaintext
// Define global navigator keys for root and nested shells
DEFINE rootNavigatorKey
DEFINE clientShellNavigatorKey
DEFINE ownerShellNavigatorKey

// Define GoRouter Provider
PROVIDER routerProvider:
  // Listen to the authentication state from AuthNotifier
  LISTEN authState = ref.watch(authNotifierProvider)

  INITIALIZE GoRouter with:
    initialLocation = '/splash'
    navigatorKey = rootNavigatorKey

    // Add a redirect function for authentication guard
    FUNCTION redirect(context, state):
      isLoggedIn = authState.value IS NOT NULL
      isGoingToAuthPage = state.uri.path IS '/login' OR '/register'

      // If not logged in and not on splash/auth page, redirect to login
      IF !isLoggedIn AND !isGoingToAuthPage AND state.uri.path IS NOT '/splash':
        RETURN '/login'
      
      // If logged in and on an auth page, redirect to the appropriate home screen
      IF isLoggedIn AND isGoingToAuthPage:
        userRole = authState.value.role
        IF userRole IS 'owner':
          RETURN '/owner_home'
        ELSE:
          RETURN '/client_home'
      
      // Otherwise, allow navigation
      RETURN NULL

    // Define all application routes
    ROUTES:
      - /splash -> SplashScreen
      - /login -> LoginScreen
      - /register -> RegistrationScreen

      // Client-side nested navigation with a Bottom Bar
      - ShellRoute (ClientScaffold):
        - /client_home -> ClientHomeScreen
        - /client_bookings -> TenantDashboardScreen
        - /client_profile -> ClientProfileScreen
      
      // Owner-side nested navigation with a Bottom Bar
      - ShellRoute (OwnerScaffold):
        - /owner_home -> OwnerHomeScreen
        - /chats -> ChatListScreen (Shared for now, can be nested)
        - /owner_profile -> OwnerProfileScreen
      
      // Top-level routes (that cover the bottom bar)
      - /details/:apartmentId -> ApartmentDetailsScreen
      - /add_property -> AddPropertyScreen
      - /edit_property/:apartmentId -> AddPropertyScreen (in edit mode)
      - /chat/:chatId -> ChatScreen
      - ... and other management screens
```

---

## Part 3: Authentication Flow

### `RegistrationScreen.dart`

```plaintext
WIDGET RegistrationScreen (Stateful):
  STATE:
    formKey, textControllers (name, email, password), isLoading, selectedRole

  FUNCTION build():
    RETURN Scaffold with AppBar and Form
    FORM contains:
      - Role selector (Tenant/Owner) updating `selectedRole` state
      - TextFormField for Full Name
      - TextFormField for Email
      - TextFormField for Password (obscured)
      - ElevatedButton 'Sign Up':
        onPressed: IF isLoading, DO NOTHING, ELSE CALL _handleRegister()
  
  FUNCTION _handleRegister():
    IF form is valid:
      SET isLoading = true
      TRY:
        CALL ref.read(authNotifierProvider.notifier).register(
          name, email, password, role
        )
        // Navigation is handled automatically by the router's redirect logic
      CATCH (error):
        SHOW SnackBar with error message
      FINALLY:
        SET isLoading = false
```

### `AuthNotifier.dart` (State Management)

```plaintext
PROVIDER authNotifierProvider:
  CLASS AuthNotifier:
    FUNCTION build():
      // On first load, try to get the currently logged-in user from storage
      RETURN getCurrentUserUseCase.call()
    
    FUNCTION register(name, email, password, role):
      SET state = Loading
      TRY:
        new_user = registerUserUseCase.call(...)
        SET state = Data(new_user)
      CATCH (error):
        SET state = Error(error)

    FUNCTION login(email, password):
      SET state = Loading
      TRY:
        user = loginUserUseCase.call(...)
        SET state = Data(user)
      CATCH (error):
        SET state = Error(error)

    FUNCTION logout():
      CALL logoutUserUseCase.call()
      SET state = Data(null)
```

### Data Flow (Repository Pattern)

```plaintext
// UseCase Layer
CLASS RegisterUserUseCase:
  FUNCTION call(params):
    RETURN authRepository.register(params)

// Repository Layer
CLASS AuthRepositoryImpl IMPLEMENTS AuthRepository:
  - dataSource: UserLocalDataSource
  FUNCTION register(params):
    userModel = CREATE UserModel from params
    registeredModel = dataSource.registerUser(userModel)
    RETURN map UserModel to User entity

// DataSource Layer
CLASS UserLocalDataSourceImpl IMPLEMENTS UserLocalDataSource:
  - userBox: HiveBox<UserModel>
  - preferencesBox: HiveBox<String>
  FUNCTION registerUser(userModel):
    IF user with email already exists in userBox:
      THROW Exception
    SAVE userModel to userBox
    SAVE userModel.id to preferencesBox as 'currentUserId'
    RETURN userModel
```

---

## Part 4: Property Listing & Details Flow (Client)

### `ClientHomeScreen.dart`

```plaintext
WIDGET ClientHomeScreen (ConsumerWidget):
  FUNCTION build(ref):
    // Watch providers for apartment data
    featuredApartments = ref.watch(featuredApartmentsProvider)
    allApartments = ref.watch(allApartmentsProvider)

    RETURN Scaffold with SingleChildScrollView
    COLUMN contains:
      - Header with location and Chat icon
      - Search Bar and Filter button (navigates to /filters)
      - Horizontal ListView for Featured Apartments:
        - RENDER featuredApartments data using PropertyCard widgets
      - Vertical ListView for All Apartments:
        - RENDER allApartments data using PropertyCard widgets
```

### `ApartmentDetailsScreen.dart`

```plaintext
WIDGET ApartmentDetailsScreen (ConsumerWidget):
  - apartmentId: String
  FUNCTION build(ref):
    apartments = ref.watch(allApartmentsProvider)
    find apartment where id == apartmentId

    RETURN Scaffold with CustomScrollView
    SLIVERS contains:
      - SliverAppBar with `SmartImage` as background
      - SliverToBoxAdapter with a Column:
        - Title, Address, Price (formatted to XAF)
        - Description, Amenities
        - Owner Info section with "Chat with Landlord" button
          - onPressed:
            CALL ref.read(chatControllerProvider.notifier).getOrCreateConversation(ownerId)
            NAVIGATE to /chat/:conversationId
        - "Book Now" button
          - onPressed:
            SHOW BookingDialog
```

---

## Part 5: Owner Flow

### `OwnerHomeScreen.dart`

```plaintext
WIDGET OwnerHomeScreen (ConsumerWidget):
  FUNCTION build(ref):
    currentUser = ref.watch(authNotifierProvider).value
    IF currentUser IS NULL:
      RETURN "Please log in" screen
    
    // Get apartments filtered by the current owner's ID
    ownedApartments = ref.watch(apartmentsByOwnerProvider(currentUser.id))

    RETURN Scaffold with AppBar (Add and Chat buttons)
    BODY renders a ListView of `ownedApartments`:
      - For each apartment, RENDER a PropertyCard
      - onTap of card, NAVIGATE to /owner_property_management/:apartmentId
```

### `AddPropertyScreen.dart` (Add/Edit)

```plaintext
WIDGET AddPropertyScreen (Stateful):
  - apartment: Apartment? (optional, for edit mode)
  STATE:
    isEditMode = apartment IS NOT NULL
    textControllers, formKey, selectedImagePath

  FUNCTION initState():
    IF isEditMode:
      PRE-FILL all text controllers and state from `widget.apartment`
  
  FUNCTION build(ref):
    RETURN Scaffold with AppBar (title is "Add" or "Edit")
    FORM contains:
      - Image Picker UI (tap to pick from device gallery)
      - TextFormFields for all apartment details
      - Amenities selector (FilterChips)
      - ElevatedButton (text is "Add" or "Update"):
        onPressed: CALL _submitForm()

  FUNCTION _submitForm():
    IF form is valid AND image is selected:
      CREATE `apartmentData` object from form fields
      IF isEditMode:
        CALL ref.read(propertyControllerProvider.notifier).updateApartment(apartmentData)
      ELSE:
        CALL ref.read(propertyControllerProvider.notifier).addApartment(apartmentData)
```
