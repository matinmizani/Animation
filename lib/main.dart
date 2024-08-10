import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/constants/app_assets.dart';
import 'package:project/model/task.dart';
import 'package:project/pages/animations/animated_container_page.dart';
import 'package:project/pages/animations/animated_opacity_page.dart';
import 'package:project/pages/task/home_page.dart';
import 'package:project/pages/watch/stop_watch_page.dart';
import 'package:project/pages/animations/tween_animation_builder_page.dart';
import 'package:project/persistence/hive_data_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dataStore = HiveDataStore();
  await dataStore.init();
  await dataStore.createDemoTasks(tasks: [
    Task.create(iconName: AppAssets.dog),
    Task.create(iconName: AppAssets.carrot),
    Task.create(iconName: AppAssets.html),
    Task.create(iconName: AppAssets.dumbbell),
    Task.create(iconName: AppAssets.smoking),
    Task.create(iconName: AppAssets.book),
  ]);
  runApp( ProviderScope(overrides: [
    dataStoreProvider.overrideWithValue(dataStore),
  ],child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: const Scaffold(
        body: HomePage(),
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
