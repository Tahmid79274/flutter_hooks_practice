import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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

class CountDown extends ValueNotifier<int> {
  late StreamSubscription sub;
  CountDown({required int from}) : super(from) {
    sub = Stream.periodic(
      const Duration(seconds: 1),
      (computationCount) => from - computationCount,
    )
        .takeWhile(
      (element) => element >= 0,
    )
        .listen(
      (value) {
        this.value = value;
      },
    );
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }
}

class MyHomePage extends HookWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final countDown = useMemoized(
      () => CountDown(from: 100),
    );
    final notifier = useListenable(countDown);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Hooks'),
      ),
      body: Center(
        child: Text(
          notifier.value.toString(),
          style: TextStyle(fontSize: 100),
        ),
      ),
    );
  }
}
