<a href="https://www.buymeacoffee.com/playlinesdev" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: auto !important;width: auto !important;" ></a>

# pl_notifications

A service class to display overlay notifications like toasts but with custom widgets.

## Getting Started

Just install the package on the pubspec.yaml file, run the 
flutter packages get
command, for importing the package and use just like so

```dart
PlNotifications.showMessage(
    context,
    Text('A title'),
    subtitle: Text('A subtitle'),
    Duration(seconds: 5),
    icon: Icon(Icons.error),
);
```

Screenshots
<img src="https://github.com/playlinesdev/pl_notifications/blob/master/mobile_tests.gif?raw=true"/>

<img src="https://github.com/playlinesdev/pl_notifications/blob/master/web_test.gif?raw=true"/>
