import 'dart:async';
import 'package:flutter/foundation.dart';

import 'client.dart';
import 'device_info.dart';

class AmplitudeFlutter {
  DeviceInfo deviceInfo;
  Client client;

  AmplitudeFlutter(String apiKey) {
    client = Client(apiKey);
    deviceInfo = DeviceInfo();
  }

  @visibleForTesting
  AmplitudeFlutter.private(this.deviceInfo, this.client);

  Future<void> logEvent({ @required String name, Map<String, dynamic> properties = const {} }) async {
    Map<String, dynamic> eventData = { 'event_type': name };
    eventData.addAll(properties);

    Map<String, dynamic> deviceData = deviceInfo.get();
    eventData.addAll(deviceData);

    await client.post(eventData);
  }
}
