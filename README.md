```dart

  final DartChannel<String> dartChannel = DartChannel(bufferSize: 2);

  dartChannel.emit("hi !");

  dartChannel.addListener((value) {
    print(value);
  });

  dartChannel.addListener((value) {
    print(value);
  });
```