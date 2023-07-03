import 'dart:async';
import 'package:flutter/services.dart';

void backgroundFetchHeadlessTask(String taskId) async {
  print('[BackgroundFetch] Headless event received: $taskId');
  BackgroundFetch.finish(taskId);
}

class BackgroundFetch {
  static const MethodChannel _channel =
  const MethodChannel('com.transistorsoft/flutter_background_fetch');

  static Future<bool> configure(
      BackgroundFetchConfig config,
      Function callback,
      ) async {
    return await _channel.invokeMethod('configure', config.toMap()).then((_) {
      _channel.setMethodCallHandler((MethodCall call) async {
        switch (call.method) {
          case "onFetch":
            final taskId = call.arguments as String;
            await callback();
            BackgroundFetch.finish(taskId);
            break;
          default:
            throw new ArgumentError('Invalid method ${call.method}');
        }
      });
      return true;
    });
  }

  static Future<void> finish(String taskId) async {
    return await _channel.invokeMethod('finish', taskId);
  }
}

class BackgroundFetchConfig {
  int minimumFetchInterval;
  bool stopOnTerminate;
  bool enableHeadless;
  bool requiresBatteryNotLow;
  bool requiresCharging;
  bool requiresDeviceIdle;
  bool requiresStorageNotLow;

  BackgroundFetchConfig({
    this.minimumFetchInterval = 15,
    this.stopOnTerminate = true,
    this.enableHeadless = false,
    this.requiresBatteryNotLow = false,
    this.requiresCharging = false,
    this.requiresDeviceIdle = false,
    this.requiresStorageNotLow = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "minimumFetchInterval": this.minimumFetchInterval,
      "stopOnTerminate": this.stopOnTerminate,
      "enableHeadless": this.enableHeadless,
      "requiresBatteryNotLow": this.requiresBatteryNotLow,
      "requiresCharging": this.requiresCharging,
      "requiresDeviceIdle": this.requiresDeviceIdle,
      "requiresStorageNotLow": this.requiresStorageNotLow,
    };
  }
}
