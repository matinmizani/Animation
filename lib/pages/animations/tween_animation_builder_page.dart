import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TweenAnimationBuilderPage extends StatefulWidget {
  const TweenAnimationBuilderPage({super.key});

  @override
  State<TweenAnimationBuilderPage> createState() =>
      _TweenAnimationBuilderPageState();
}

class _TweenAnimationBuilderPageState extends State<TweenAnimationBuilderPage> {
  double _hue = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("TweenAnimationBuilder"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
                tween: Tween<double>(begin: 0.0, end: _hue),
                duration: const Duration(milliseconds: 300),
                builder: (context, hue, child) {
                  final hsvColor = HSVColor.fromAHSV(1.0, hue, 1.0, 1.0);
                  return Container(
                    width: 200,
                    height: 200,
                    color: hsvColor.toColor(),
                  );
                }),
            const SizedBox(
              height: 48,
            ),
            Container(
              height: 30,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                for (var h = 0; h <= 360; h++)
                  HSVColor.fromAHSV(1.0, h.toDouble(), 1.0, 1.0).toColor(),
              ], stops: [
                for (var h = 0; h <= 360; h++) h.toDouble() / 360,
               ])),
            ),
            Slider.adaptive(value: _hue,min: 0.0,max: 360, onChanged: (value){
              setState(() {
                _hue = value;
              });
            }),
          ],
        ),
      ),
    );
  }
}
