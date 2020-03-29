# Team Temp

## Style Guide

Follow the Dart style guide: https://dart.dev/guides/language/effective-dart/style

Of note, you should:

- Use `UpperCamelCase` for types.
- Use `lowercase_snake_case` for libraries, packages, directories, and files.
- Use `lowerCamelCase` for constant names.
- Use `lowerCamelCase` for everything else (like variable names).
- Capitalize acronyms and abbreviations longer than two letters (Http rather than HTTP or http).
- A leading underscore makes a member variable private. Only use it if it is private.
- You can use single line if statements for returns.
- Use `///` instead of `/** */` for multi-line comments.

For VS Code, install the Dart and Flutter plugin. Set your editor to format on save. https://flutter.dev/docs/development/tools/formatting#automatically-formatting-code-in-vs-code

## Architecture

The goal with this architecture is to ensure a clean separation of concerns for readability, maintainability, and reusability. It also simplifies unit testing business logic and allows for re-skinning the application without changing the underlying business logic. The following are the general guidelines for the architecture:

- `screen`: A screen widget is a top level widget that is loaded via a route.
- `widget`: A widget is considered a view and should only contain the necessary logic to construct the widget hierarchy statically or in response to changes in application state. It also facilitates passing events from user input to the View Model.
- `view model`: The view model is the brains of each widget. It manages changes in localized state and communicates with services. The properties exposed by the model should strive to be semantic and the view should determine how to translate them into user interaction.
- `service`: Services contain shared business logic and network communication.

A good bit of the architecture is influenced by this post: https://www.filledstacks.com/post/flutter-provider-v3-architecture/

## Folder Structure

The following is the folder structure under the `/lib` folder:

- `/constants` - _generic constants_
- `/enums` - _generic enums_
- `/models` - _dumb models usually coming from an api_
- `/screens` - _top level widgets that are loaded via a route_
  - `/<screen_name>` - _contains all code specific to this screen that is not shared_
    - `/<widget_name>` - _widgets that aren't shared_
      - `<widget_name>.dart` - _the widget_
      - `<widget_name>.vm.dart` - _the view model for the widget_
      - `<widget_name>.vm.test.dart` - _the test for the view model for the widget_
    - `<screen_name>.dart` - _the screen widget_
    - `<screen_name>.vm.dart` - _the view model for the screen widget_
    - `<screen_name>.vm.test.dart` - _the test for the viewmodel for the screen widget_
- `/services` - _shared services_
  - `root_services.dart` - _exports all services that should be provided at the root_
  - `<service_name>.service.dart` - some service
- `/utils` - _shared static utils that don't need to be provided_
- `/shared` - _shared widgets_
  - `/<widget_name>`
    - `<widget_name>.dart`
    - `<widget_name>.vm.dart`
    - `<widget_name>.vm.test.dart`
- `/themes` - _theme variables and builders_
  - `theme.dart` - _theme variables_
  - `material_theme.dart` - _theme builder for material_
- `provider_setup.dart` - _setup global providers here_
- `routes.dart` - _maps routes to screen widgets_
- `main.dart`

## Firestore Offline

Firestore provides offline capabilities through a local cache. To learn more about it, check out this link https://firebase.google.com/docs/firestore/manage-data/enable-offline. Based on the available features we decided to await changes that add new data but not await changes that update existing data.

## Local Testing

### Android

Ensure that you have added the Android emulator and tools to your PATH in your `.bash_profile`. The order is important.

```
export ANDROID_SDK=$HOME/Library/Android/sdk
export PATH=$ANDROID_SDK/emulator:$ANDROID_SDK/tools:$PATH
```

To view a list of available emulators, run the following command:

```
emulator -list-avds
```

To start the Android emulator, run the following command:

```
emulator @<avd_name>
```

Sometimes you will be in the situation where the emulator can't connect to the internet. If you experience this then you will need to modify your network settings and specify the dns server (`-dns-server 8.8.8.8`) in your command to start the emulator. See this SO post for more detail https://stackoverflow.com/questions/50670547/android-studio-android-emulator-wifi-connected-with-no-internet.

### iOS

To start the iOS simulator, run the following command:

```
open -a Simulator
```

### Run Local

Once you have started up an emulator/simulator or plugged in a real device, you can run the following command to view the devices that Flutter recognizes:

```
flutter devices
```

To run the app on a specific device then you can run the following command:

```
flutter run -d <part of the device name or id>
```

## Model Generation

All models are created in the `services/models.dart` file. They are annotated using the `json_annotation` package and a corresponding code file is generated using `json_serializable`. To generate the file, run the following command:

```
flutter pub run build_runner build --delete-conflicting-outputs
```

## Lint

To run the linter, run the following command:

```
flutter analyze
```

## Code Signing

### Android

Get the debug certificate:

```
keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore
```

Create the release certificate:

```
keytool -genkey -v -keystore ~/.android/release.keystore -alias teamtemp -keyalg RSA -keysize 2048 -validity 10000
```

Get the release certificate:

```
keytool -exportcert -list -v -alias teamtemp -keystore ~/.android/release.keystore
```

## Common Errors

### I try to run the app on my iOS simulator but get this error: `Error running pod install`

Change to your iOS directory and run a pod update

```
cd ios
pod update
```

Grab a snickers... it will take a while...
