# unlockme mobile application

This README provides a comprehensive guide to setting up the development environment, along with details on compiling and testing the application for both iOS and Android platforms.

### Table of contents

- [System requirements](#system-requirements)
- [Figma design guidelines for better UI accuracy](#figma-design-guideline-for-better-accuracy)
- [Check the UI of the entire app](#app-navigations)
- [Google authentication configuration](#google-authentication-configuration)
- [Application structure](#project-structure)
- [How to format your code?](#how-you-can-do-code-formatting)
- [How you can improve code readability?](#how-you-can-improve-the-readability-of-code)
- [Libraries and tools used](#libraries-and-tools-used)
- [Support](#support)
- [How to install the development environment](#how-to-install-the-development-environment)
- [Compiling for Android](#compiling-for-android)
- [Compiling for iOS](#compiling-for-ios)
- [User Manual](#user-manual)
- [License](#license)

### System requirements

Dart SDK Version 3.3.2 or greater.  
Flutter SDK Version 3.19.4 or greater.

### User Manual

For detailed instructions on how to use the UnlockMe mobile application, please refer to the [User Manual](user_manual.md).

### Figma design guidelines for better UI accuracy

[UnlockMe App for sharing on Figma](https://www.figma.com/design/STIe1enjP75D7AcmdOyGt4/UnlockMe-App-for-sharing?node-id=0-1&t=VCF5wr8Enp0TidMu-1)

### Check the UI of the entire app

Check the UI of all the app screens from a single place by setting up the `initialRoute` to AppNavigation in the `AppRoutes.dart` file.

### Google authentication configuration

Steps:

- Follow the steps on [Google Sign-In for Flutter](https://pub.dev/packages/google_sign_in) for Google sign-in.
- For iOS:
  - Download the `GoogleService-Info.plist` file. Drag and drop the downloaded file into the Runner subfolder and update the `Info.plist` file.

### Application structure

```
.
├── android                         - It contains files required to run the application on an Android platform.
├── assets                          - It contains all images and fonts of your application.
├── ios                             - It contains files required to run the application on an iOS platform.
├── lib                             - Most important folder in the application, used to write most of the Dart code.
    ├── main.dart                   - Starting point of the application
    ├── core
    │   ├── app_export.dart         - It contains commonly used file imports
    │   ├── app_storage.dart        - It contains db contracts and storage related imports (including constants)
    │   ├── constants               - It contains all constants classes
    │   ├── errors                  - It contains error handling classes
    │   ├── network                 - It contains network-related classes
    │   ├── services                - It contains common internal services used across the app (like timers)
    │   ├── storage                 - It contains storage related classes (db , hive)
    │   └── utils                   - It contains common files and utilities of the application
    ├── data
    │   ├── apiClient               - It contains API calling methods
    │   ├── models                  - It contains request/response models
    │   └── repository              - Network repository
    ├── localization                - It contains localization classes
    ├── presentation                - It contains widgets of the screens with their controllers and the models of the whole application.
    │                                 Every Screen has its screen (UI) Model (variables) Controller (business logic) and binding (binds controller with the screen (DI))
    ├── routes                      - It contains all the routes of the application
    └── theme                       - It contains app theme and decoration classes
    └── widgets                     - It contains all custom widget classes
```

### Libraries and tools used

- **get** - State management  
  [Get package](https://pub.dev/packages/get)  
  [GetX docs](https://chornthorn.github.io/getx-docs/docs/)
- **connectivity_plus** - For status of network connectivity  
  [Connectivity Plus](https://pub.dev/packages/connectivity_plus)
- **shared_preferences** - Provide persistent storage for simple data  
  [Shared Preferences](https://pub.dev/packages/shared_preferences)
- **cached_network_image** - For storing internet image into cache  
  [Cached Network Image](https://pub.dev/packages/cached_network_image)
- **flutter_map**  
  [Flutter Map](https://docs.fleaflet.dev/)
- **flutter_osm_plugin** - Open street maps  
  [Open Street Maps Plugin](https://pub.dev/packages/flutter_osm_plugin)
- **SQFLite** for Mocking the Backend
- **Hive** for local storage key/value registries  
  [Hive Docs](https://docs.hivedb.dev/#/)

### Further reading

For the map interactions I got some ideas from here:

- [Flutter Map Custom and Dynamic Popup](https://medium.com/zipper-studios/flutter-map-custom-and-dynamic-popup-over-the-marker-732d26ef9bc7)
- Conditional imports to allow multiplatform in flutter: (by abstract class)  
  [Adding Conditional Imports](https://medium.com/techskool/adding-conditional-imports-in-flutter-for-cross-platform-development-5d7b6bff689c)
- Mastering Flutter’s Routing with GetX: A Comprehensive Guide  
  [Mastering Flutter's Routing](https://medium.com/@sajjadjavadi/mastering-flutters-routing-with-getx-9c0796ff3a9d)

### Support

For any issues, please contact the project maintainer.

### How to install the development environment

To set up your development environment for the "UnlockMe" mobile application, follow these steps:

1. **Install Flutter and Dart:**
   - Download and install Flutter SDK from the official [Flutter website](https://flutter.dev/docs/get-started/install).
   - Ensure Dart SDK is included with Flutter installation.
2. **Set up Android environment**
   - Install AndroidStudio to have an Android emulator, the sdk-tool, the platform-tools and the cmdline-tools
   - In windows: Make sure PATH variable points to these binaries
3. **Set Up an Editor:**

   - Use an editor such as [Visual Studio Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio).
   - Install the Flutter and Dart plugins for your chosen editor.

4. **Clone the Repository:**

   - Open your terminal and run:
     ```bash
     git clone https://github.com/yourusername/unlockme.git
     cd unlockme
     ```

5. **Install Dependencies:**

   - Run the following command to install required dependencies:
     ```bash
     flutter pub get
     ```

6. **Run the Application:**
   - Connect your device or start an emulator.
   - Use the following command to run the application:
     ```bash
     flutter run
     ```

### Compiling for Android

To compile the application for Android, follow these steps:

1. **Set Up Android Studio:**

   - Download and install [Android Studio](https://developer.android.com/studio).
   - Ensure you have the latest version of the Android SDK and the necessary SDK tools.

2. **Open the Project in Android Studio:**

   - Open Android Studio and select "Open an existing Android Studio project".
   - Navigate to the `unlockme` project directory and open it.

3. **Configure the Android Emulator:**

   - In Android Studio, go to `Tools > AVD Manager`.
   - Create a new virtual device or select an existing one.
   - Ensure the virtual device is configured with the desired Android version.

Here is the formatted text for a README file:

---

4. **Build the APK**

   4.1 Using Flutter

   - **Open the terminal in Android Studio or use your system terminal.**
   - **Run the following command to build the APK:**

   ```bash
   flutter build apk --release
   ```

   4.2 Using Codemagic

   - **Build on Codemagic and get the `file.aab` (Android App Bundle).**

   - Convert AAB to APK

     - **Download bundletool:**
     - [Bundletool Releases](https://github.com/google/bundletool/releases)

     - Run the following command:

     ```bash
     java -jar bundletool-all-<version>.jar build-apks --bundle=/path/to/your/app.aab --output=/path/to/your/output.apks --mode=universal
     ```

   - **Extract APK from the `.apks` file:**

   ```bash
   unzip /path/to/your/output.apks -d /path/to/your/output_directory
   ```

   - **After extracting, you will find your APK file in the specified output directory.**
   - You can then transfer this APK file to your Android device and install it.

---

This format ensures clarity and proper organization for the steps involved in building and converting the APK. 4. **Build the APK:**

- Open the terminal in Android Studio or use your system terminal.
- Run the following command to build the APK:
  ```bash
  flutter build apk --release
  ```

#### Using Codemagic

Build on codemagic and get the file.aab (Android app bundle)

Download bundletool:
https://github.com/google/bundletool/releases

Using bundletool to Convert AAB to APK:
java -jar bundletool-all-<version>.jar build-apks --bundle=/path/to/your/app.aab --output=/path/to/your/output.apks --mode=universal

Extract APK from the .apks file:
unzip /path/to/your/output.apks -d /path/to/your/output_directory

After extracting, you will find your APK file in the specified output directory. You can then transfer this APK file to your Android device and install it.

5. **Run the Application:**

   - Connect your Android device via USB or start the Android emulator.
   - Use the following command to run the application:
     ```bash
     flutter run
     ```

6. **Generate the App Bundle (Optional):**
   - To generate an Android App Bundle (AAB) for distribution on the Google Play Store, use the following command:
     ```bash
     flutter build appbundle --release
     ```

### Compiling for iOS

If you don't have macOS, you can use the following steps:

1. **Use Codemagic for Compilation:**

   - Use [Codemagic](https://codemagic.io/) to compile the app for iOS.

2. **Download the build artifacts**

3. **Prepare the App:**

   - Copy `Runner.app.zip` to the desktop and uncompress it.
   - Create a folder named `Payload` (case-sensitive) on the desktop.
   - Move `Runner.app` into the `Payload` folder.
   - Compress the `Payload` folder to a `.zip` file.
   - Convert/rename `Payload.zip` to `Payload.ipa`.

4. **Testing and distribution:**
   - Use [BrowserStack](https://www.browserstack.com/) to test the app on iOS devices.
   - Or Distribute the app to testers using [Diawi](https://www.diawi.com/).

### License

This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License. To view a copy of this license, visit [Creative Commons Attribution-NonCommercial 4.0 International License](https://creativecommons.org/licenses/by-nc/4.0/deed.ca).

© [Angel de Paz Toldra], 2024
