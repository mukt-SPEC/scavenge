# Scavenge
[![Ask DeepWiki](https://devin.ai/assets/askdeepwiki.png)](https://deepwiki.com/mukt-SPEC/scavenge)

Scavenge is a comprehensive, multi-platform waste management application built with Flutter. It aims to connect users looking to recycle waste (Customers) with individuals or businesses that collect it (Agents), creating a streamlined ecosystem for recycling and earning.

## Key Features

*   **Dual User Roles:** Separate onboarding and functionality for **Customers** and **Agents** (Mobile or Drop Zone).
*   **Authentication:** Secure email and password based sign-up and sign-in using Firebase Auth.
*   **Onboarding:** A step-by-step process for new users to set up their profile, including user type selection, basic information, and location configuration.
*   **Home Dashboard:** A central hub displaying user information, quick actions (Recycle, Trade, Withdraw, Find Agents), and analytics like total earnings and most recycled materials.
*   **Location Services:** Integrated mapping using `flutter_map` and `geolocator` for location selection, user tracking, and finding agents.
*   **State Management:** Utilizes Flutter Riverpod for robust and scalable state management.
*   **Cross-Platform:** Built from a single codebase for Android, iOS, Web, and Desktop (Windows, macOS, Linux).

## Tech Stack & Architecture

*   **Framework:** Flutter
*   **State Management:** Flutter Riverpod
*   **Backend:**
    *   Firebase Authentication for user management.
    *   Cloud Firestore for real-time data storage.
    *   Firebase Storage for image uploads.
*   **Mapping & Location:** `flutter_map`, `geolocator`, `location`
*   **Architecture:** The project follows a feature-first architectural pattern, with clear separation of concerns for different application features. The data models use sealed classes to distinguish between `Customer` and `Agent` user types.

## Project Structure

The project's codebase is organized with a feature-driven approach for clarity and scalability.

```
lib/
├── features/         # Main application features
│   ├── authentication/ # User sign-in/sign-up logic and UI
│   ├── Home/           # Main dashboard UI and widgets
│   ├── onboarding/     # Multi-step user onboarding flow
│   ├── Profile/        # User profile management
│   └── Scan/           # UI for the scanning feature
├── model/            # Data models (User, Customer, Agent, Location)
├── provider/         # Riverpod providers for state management
├── core/             # Core utilities (Result, Exceptions, Logger)
├── common/           # Shared widgets and enums
├── Theme/            # App-wide theme, colors, and text styles
└── main.dart         # Application entry point
```

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

*   Flutter SDK installed on your machine.
*   An editor like VS Code or Android Studio.

### Installation

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/mukt-spec/scavenge.git
    ```

2.  **Navigate to the project directory:**
    ```sh
    cd scavenge
    ```

3.  **Install dependencies:**
    ```sh
    flutter pub get
    ```

4.  **Configure Firebase:**
    This project is configured with Firebase. To run it with your own backend, you'll need to set up your own Firebase project.

    1.  Create a new project on the [Firebase Console](https://console.firebase.google.com/).
    2.  Install the Firebase CLI and FlutterFire CLI if you haven't already:
        ```sh
        # Install Firebase CLI
        npm install -g firebase-tools
        # Install FlutterFire CLI
        dart pub global activate flutterfire_cli
        ```
    3.  From the root of the project directory, run the configure command to connect your app to your Firebase project:
        ```sh
        flutterfire configure
        ```

5.  **Run the application:**
    ```sh
    flutter run
