import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:media_notification/media_notification.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String status = 'hidden';

  @override
  void initState() {
    super.initState();

    MediaNotification.setListener('pause', () {
      setState(() => status = 'pause');
    });

    MediaNotification.setListener('play', () {
      setState(() => status = 'play');
    });
    
    MediaNotification.setListener('next', () {
      
    });

    MediaNotification.setListener('prev', () {
      
    });

    MediaNotification.setListener('select', () {
      
    });
  }

  Future<void> stopSound() async {
    try {
      await MediaNotification.stopSound();
    } on PlatformException {
      print("Exception stopSound");
    }
  }

  Future<void> lock() async {
    try {
      await MediaNotification.getWifiLock();
    } on PlatformException {
      print("Exception getWifiLock");
    }
  }

  Future<void> release() async {
    try {
      await MediaNotification.releaseWifiLock();
    } on PlatformException {
      print("Exception releaseWifiLock");
    }
  }

  Future<void> hide() async {
    try {
      await MediaNotification.hide();
      setState(() => status = 'hidden');
  } on PlatformException {
      print("Exception hide");
    }
  }

  Future<void> show(title, author) async {
    try {
      await MediaNotification.show(title: title, author: author);
      setState(() => status = 'play');
    } on PlatformException {
      print("Exception show");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Center(
          child: Container(
            height: 350.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  child: Text('Show notification'),
                  onPressed: () => show('Title', 'Song author'),
                ),
                FlatButton(
                  child: Text('Update notification'),
                  onPressed: () => show('New title', 'New song author'),
                ),
                FlatButton(
                  child: Text('Hide notification'),
                  onPressed: hide,
                ),
                FlatButton(
                  child: Text('Kill Other Sound'),
                  onPressed: stopSound,
                ),
                FlatButton(
                  child: Text('WiFi Lock'),
                  onPressed: lock,
                ),
                FlatButton(
                  child: Text('WiFi Release'),
                  onPressed: release,
                ),
                Text('Status: ' + status)
              ],
            ),
          )
        ),
      ),
    );
  }
}
