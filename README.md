<img src="https://github.com/BrunoRabbit/pomodoro-timer/assets/72535437/a810d3e5-5fb6-4ffe-9dcc-9df8698825d8"  height=100 />

# Pomodoro Timer

[![Pomodoro Timer][dart_logo_img]][repo_url]

Pomodoro Timer offers a custom settings for work and break time, supporting multiple work-rest cycles. 

It also has **multilingual support** (pt-BR and en-EN) and **notifications** to alert the user about cycle completion, even in the background.

In addition, it records session history and presents statistics such as completed cycles and average work and break times.

## ⚡️ Quick start

❗ Note: The apk available for download is a large apk that works on most android architectures. If you want a small size apk, clone this repository and manage one using Android Studio or Visual Studio Code.

### apk

## ⚙️ Project overview

### video

## 🔧 Features

### `Custom settings`
 - User can configure duration of working time,
 - The user can configure the pause time and the number of work-rest cycles.

### `Multilingual Support`
 - Supports English (en-EN) and Portuguese (pt-BR).
 - Allows the user to select their language in the application.

### `Notifications`
 - Notifications to alert the user when the work cycle and pause are finished.
 - Notifications work even when the app is in the background.
 - Possibility to disable notifications.

### `History and statistics` 
 + Shows a history of completed work sessions.
 + Displays statistics such as the total number of completed cycles, average work time, average break time, etc.

## 📝 Packages

### Arquitecture

+ **MVVM**: It was chosen because it is more ideal for just one developer and it aims to separate the components in order to improve maintainability and testability, it separates the business logic from the user interface through three main components: Model, View and ViewModel.

### State management

+ **Provider**: Chosen to be an InheritedWidget, avoiding code repetitions and reduces boilerplate to a strict minimum. 

+ I used provider and the Observer pattern, but this pattern was made as a way of studying, as there are several state managers where they exclude the possibility of needing an Observer

### Object Oriented Design Principles

- In the **ViewModels**, I adopted dependency injection to guarantee the independence of these classes in relation to their dependent components. This approach follows the principles of **SOLID**.

+ In some classes, I implemented the **DIO** (Dependency Inversion Principle) which improves the code quality, ensuring flexibility and facilitating future maintenance.

### Other helpeful packages
[auto_route][auto_route_package] - Used to create routes more quickly and efficiently.

[flutter_localization][flutter_localization_package] - Provides internationalization and localization support for the Flutter app.

[intl][intl_package] - Used for internationalization and formatting of dates, numbers, and other data.

[shared_preferences][shared_preferences_package] - Used for Data Persistence and retrieve simple data types.

[flutter_local_notifications][notifications_package] - Enables handling and displaying local notifications in a Flutter app.

[toggle_switch][toggle_switch_package] - Easy way to implement fully customized Toggle Switch

## ⭐️ Credits

Made with ♥ by [Bruno Coelho][author_linkedin]. Get in touch!

UI design made by [Carmen Baladan][carmen_baladan_behance] on behance, you can see her project [here][ui_project_link]

<!-- Repository -->

[dart_logo_img]: https://img.shields.io/badge/Dart-2.19.4_<_3.0.0-045998?style=for-the-badge&logo=dart
[repo_url]: https://github.com/BrunoRabbit/pomodoro-timer/

<!-- Design author -->

[carmen_baladan_behance]: https://www.behance.net/carmen-balaban
[ui_project_link]: https://www.behance.net/gallery/127493649/My-Timer

<!-- Flutter app author -->

[author_linkedin]: https://www.linkedin.com/in/bruno-coelho-2337741b5/
[author_github]: https://github.com/BrunoRabbit

<!-- Packages -->

[auto_route_package]: https://pub.dev/packages/auto_route
[flutter_localization_package]: https://pub.dev/packages/flutter_localization
[intl_package]: https://pub.dev/packages/intl
[shared_preferences_package]: https://pub.dev/packages/shared_preferences
[notifications_package]: https://pub.dev/packages/flutter_local_notifications
[toggle_switch_package]:https://pub.dev/packages/toggle_switch 
