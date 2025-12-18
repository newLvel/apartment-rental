# Application Diagrams (Mermaid)

This file contains the Mermaid code for generating various diagrams that describe the application's architecture and user flows.

---

## 1. Class Diagram

This diagram illustrates the relationship between the main classes in a single feature (e.g., Authentication) following the Clean Architecture principles.

```mermaid
classDiagram
    direction LR

    class LoginScreen {
        +build()
        -_handleLogin()
    }

    class AuthNotifier {
        +state: AsyncValue~User~
        +build()
        +login()
        +register()
        +logout()
    }

    class LoginUserUseCase {
        +call(email, password)
    }

    class AuthRepository {
        <<Interface>>
        +login(email, password)
    }

    class AuthRepositoryImpl {
        -UserLocalDataSource dataSource
        +login(email, password)
    }

    class UserLocalDataSource {
        <<Interface>>
        +loginUser(email, password)
    }

    class UserLocalDataSourceImpl {
        -HiveBox userBox
        +loginUser(email, password)
    }
    
    class User {
      +String id
      +String name
      +String email
      +String role
    }

    class UserModel {
      +String id
      +String name
      +String email
      +String role
    }

    LoginScreen ..> AuthNotifier : "interacts with"
    AuthNotifier ..> LoginUserUseCase : "uses"
    LoginUserUseCase ..> AuthRepository : "depends on"
    AuthRepository <|-- AuthRepositoryImpl : "implements"
    AuthRepositoryImpl ..> UserLocalDataSource : "depends on"
    UserLocalDataSource <|-- UserLocalDataSourceImpl : "implements"
    AuthRepositoryImpl ..> UserModel : "maps from"
    AuthRepositoryImpl ..> User : "maps to"
    UserLocalDataSourceImpl ..> UserModel : "persists"
```

---

## 2. Sequence Diagram: User Login Flow

This diagram shows the sequence of events when a user logs in.

```mermaid
sequenceDiagram
    actor User
    participant LoginScreen
    participant AuthNotifier
    participant LoginUserUseCase
    participant AuthRepositoryImpl
    participant UserLocalDataSourceImpl
    participant GoRouter

    User->>LoginScreen: Enters email and password
    User->>LoginScreen: Taps "Login" button
    LoginScreen->>AuthNotifier: calls login(email, password)
    
    AuthNotifier->>LoginUserUseCase: call(email, password)
    LoginUserUseCase->>AuthRepositoryImpl: login(email, password)
    AuthRepositoryImpl->>UserLocalDataSourceImpl: loginUser(email, password)
    UserLocalDataSourceImpl->>UserLocalDataSourceImpl: Finds UserModel in Hive Box
    UserLocalDataSourceImpl-->>AuthRepositoryImpl: returns UserModel
    AuthRepositoryImpl-->>LoginUserUseCase: returns User entity
    LoginUserUseCase-->>AuthNotifier: returns User entity
    
    AuthNotifier->>AuthNotifier: Updates its state to AsyncData(User)
    
    GoRouter->>GoRouter: Auth state change detected via listener
    GoRouter->>User: Redirects to /client_home or /owner_home
```

---

## 3. Sequence Diagram: Add New Property Flow

This diagram shows how a landlord adds a new property to the system.

```mermaid
sequenceDiagram
    actor Landlord
    participant AddPropertyScreen
    participant PropertyController
    participant PropertyRepositoryImpl
    participant PropertyLocalDataSourceImpl

    Landlord->>AddPropertyScreen: Fills out property form and selects image
    Landlord->>AddPropertyScreen: Clicks "Add Property" button
    
    AddPropertyScreen->>PropertyController: calls addApartment(Apartment)
    
    PropertyController->>PropertyRepositoryImpl: addApartment(Apartment)
    PropertyRepositoryImpl->>PropertyRepositoryImpl: Maps Apartment entity to ApartmentModel
    PropertyRepositoryImpl->>PropertyLocalDataSourceImpl: addApartment(ApartmentModel)
    
    PropertyLocalDataSourceImpl->>PropertyLocalDataSourceImpl: Puts ApartmentModel into Hive Box
    
    PropertyLocalDataSourceImpl-->>PropertyRepositoryImpl: Completes
    PropertyRepositoryImpl-->>PropertyController: Completes
    
    PropertyController->>PropertyController: Invalidates `allApartmentsProvider`
    Note over PropertyController: This causes dependent providers (like `apartmentsByOwnerProvider`) to refresh.
    
    PropertyController-->>AddPropertyScreen: Completes, UI shows success message
    AddPropertyScreen->>Landlord: Navigates back to Owner Dashboard
```

---

## 4. Flowchart: Authentication Redirect Logic

This flowchart visualizes the logic inside GoRouter's `redirect` callback.

```mermaid
graph TD
    A[Request to Navigate to a new route] --> B{Is user logged in?};
    B -- No --> C{Is destination /login, /register, or /splash?};
    C -- No --> D[Redirect to /login];
    C -- Yes --> E[Allow navigation];
    
    B -- Yes --> F{Is destination /login or /register?};
    F -- Yes --> G{What is user's role?};
    G -- "owner" --> H[Redirect to /owner_home];
    G -- "client" --> I[Redirect to /client_home];
    
    F -- No --> E[Allow navigation];
```
