import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String status = '';
  late StreamSubscription _subscription;

  Future checkConnection () async {
    final connectionStatus = await Connectivity().checkConnectivity();
    if(connectionStatus == ConnectivityResult.mobile) {
      setState(() {
        status = 'Connected to mobile data';
      });
    }else if (connectionStatus == ConnectivityResult.wifi){
      setState(() {
        status = 'Connected to wifi';
      });
    }else {
      setState(() {
        status = 'No internet connection';
      });
    }
  }

  @override
  void initState() {
    checkConnection();
    _subscription = Connectivity().onConnectivityChanged.listen((connectionStatus) {
      setState(() {
        status = 'Connection statue = ' + connectionStatus.name.toString();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connection Checker'),
      ),
      body: Center(
        child: Text(status),
      ),
    );
  }
}



