# Notification Proxy for macOS

Notification Proxy is a command-line tool to send macOS user notifications. It uses the app icon from keychain by [faking its bundle identifier](https://github.com/frankmorgner/NotificationProxy/blob/25d1d2219fc1eaecff02e5fe441d4a462da63eb8/NotificationProxy.xcodeproj/project.pbxproj#L236). Clicking on a notification [opens keychain via apple script](https://github.com/frankmorgner/NotificationProxy/blob/25d1d2219fc1eaecff02e5fe441d4a462da63eb8/NotificationProxy/main.m#L43).



## Usage

```
# Download
git clone http://github.com/frankmorgner/NotificationProxy.git

# Build
xcodebuild -target NotificationProxy -configuration Release -project NotificationProxy/NotificationProxy.xcodeproj install DSTROOT=${PWD}

# Execute
title="Test Notification"
open -a "${PWD}/Applications/NotificationProxy.app" --args "${title}" "${subtitle}" "${text}" "${image}" "${sound}" "${group}"
```

All arguments are optional; supply empty strings if you wish to not initialize an item.

<dl>
  <dt>title</dt>
  <dd>Specifies the title of the notification.</dd>

  <dt>subtitle</dt>
  <dd>Specifies the subtitle of the notification.</dd>

  <dt>text</dt>
  <dd>The body text of the notification.</dd>

  <dt>image</dt>
  <dd>Path to the image file shown in the content of the notification.</dd>

  <dt>sound</dt>
  <dd>Specifies the name of the sound to play when the notification is delivered. Valid names can be found in the sound preferences. Use "NSUserNotificationDefaultSoundName" for the system's default sound.</dd>

  <dt>group</dt>
  <dd>Notifications with a group string will remove older notifications with the same group string from the notification center.</dd>
</dl>

## Credits

- http://stackoverflow.com/a/36670245
- https://github.com/julienXX/terminal-notifier
