import 'package:flutter/material.dart';
import 'package:project/constants/app_assets.dart';
import 'package:project/pages/animations/animated_container_page.dart';
import 'package:project/pages/animations/animated_opacity_page.dart';
import 'package:project/pages/task/animated_task.dart';
import 'package:project/pages/watch/stop_watch_page.dart';
import 'package:project/pages/animations/tween_animation_builder_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Animations Playground"),
        ),
        body: AnimationExampleList(),
      ),
    );
  }
}

class AnimationExampleList extends StatelessWidget {
  AnimationExampleList({super.key});

  final List<String> _animations = [
    "AnimatedContainer",
    "AnimatedOpacity",
    "TweenAnimationBuilder",
    "stop watch",
    "task"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_animations[index]),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              if (index == 0) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AnimatedContainerPage()));
              } else if (index == 1) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AnimatedOpacityPage()));
              } else if (index == 2) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TweenAnimationBuilderPage()));
              } else if (index == 3) {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const StopWatch()));
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AnimatedTask(iconName: AppAssets.dog,)));
              }
            },
          );
        },
        itemCount: _animations.length,
        shrinkWrap: true,
        primary: false,
      ),
    );
  }
}
