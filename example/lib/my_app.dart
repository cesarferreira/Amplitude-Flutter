import 'dart:async';

import 'package:amplitude_flutter/amplitude_flutter.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp(this.apiKey);

  final String apiKey;

  @override
  _MyAppState createState() => _MyAppState(apiKey);
}

class _MyAppState extends State<MyApp> {
  _MyAppState(this.apiKey);

  String apiKey;
  String _message = '';
  AmplitudeFlutter analytics;

  @override
  void initState() {
    super.initState();
    analytics =
        AmplitudeFlutter(apiKey, Config(bufferSize: 8));
  }

  Future<void> _sendEvent() async {
    await analytics.logEvent(name: 'Dart Click');

    setState(() {
      _message = 'Sent.';
    });
  }

  Future<void> _sendIdentify() async {
    final Identify identify = Identify()
      ..set('identify_test',
          'identify sent at ${DateTime.now().millisecondsSinceEpoch}')
      ..add('identify_count', 1);

    await analytics.identify(identify);

    setState(() {
      _message = 'Identify Sent.';
    });
  }

  Future<void> _flushEvents() async {
    await analytics.flushEvents();

    setState(() {
      _message = 'Events flushed.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Amplitude Flutter'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                child: const Text('Send Event'),
                onPressed: _sendEvent,
              ),
              RaisedButton(
                child: const Text('Identify Event'),
                onPressed: _sendIdentify,
              ),
              RaisedButton(
                child: const Text('Flush Events'),
                onPressed: _flushEvents,
              ),
              Text(
                _message,
                style: TextStyle(color: Colors.black, fontSize: 22),
              )
            ],
          ),
        ),
      ),
    );
  }
}
