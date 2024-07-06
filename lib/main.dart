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

enum Action { rotateLeft, rotateRight, moreVisible, lessVisible }

@immutable
class State {
  final double rotationDegree, alpha;

  const State({required this.rotationDegree, required this.alpha});

  const State.zero()
      : rotationDegree = 0.0,
        alpha = 1.0;

  State rotateRight() =>
      State(alpha: alpha, rotationDegree: rotationDegree + 10);

  State rotateLeft() =>
      State(alpha: alpha, rotationDegree: rotationDegree - 10);

  State increaseAlpha() =>
      State(alpha: min(alpha + 0.1, 1.0), rotationDegree: rotationDegree);

  State decreaseAlpha() =>
      State(alpha: max(alpha - 0.1, 0.0), rotationDegree: rotationDegree);
}

State reducer(State oldState, Action? action) {
  switch (action) {
    case Action.rotateLeft:
      return oldState.rotateLeft();
    case Action.rotateRight:
      return oldState.rotateRight();
    case Action.moreVisible:
      return oldState.increaseAlpha();
    case Action.lessVisible:
      return oldState.decreaseAlpha();
    case null:
      return oldState;
  }
}

class MyHomePage extends HookWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = useReducer<State, Action?>(reducer,
        initialState: const State.zero(), initialAction: null);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Hooks'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    store.dispatch(Action.rotateLeft);
                  },
                  child: const Text('Rotate Left')),
              TextButton(
                  onPressed: () {
                    store.dispatch(Action.rotateRight);
                  },
                  child: const Text('Rotate Right')),
              TextButton(
                  onPressed: () {
                    store.dispatch(Action.moreVisible);
                  },
                  child: const Text('+ Opacity')),
              TextButton(
                  onPressed: () {
                    store.dispatch(Action.lessVisible);
                  },
                  child: const Text('- Opacity')),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Opacity(
            opacity: store.state.alpha,
            child: RotationTransition(
                turns: AlwaysStoppedAnimation(store.state.rotationDegree / 360),
                child: Image.network(url)),
          ),
        ],
      ),
    );
  }
}
