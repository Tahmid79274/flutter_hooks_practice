import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:developer' as developer;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

const url = 'https://rb.gy/ggnngr';

class MyHomePage extends HookWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = useAppLifecycleState();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Hooks'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Opacity(
            opacity: state == AppLifecycleState.resumed ? 1.0 : 0.0,
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    color: Colors.black.withAlpha(100),
                    spreadRadius: 10)
              ]),
              child: Image.network(url),
            ),
          ),
        ));
  }
}
