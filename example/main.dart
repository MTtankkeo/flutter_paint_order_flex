import 'package:flutter/material.dart';
import 'package:paint_order_flex/paint_order_flex.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Example(),
        ),
      ),
    );
  }
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return const PaintOrderFlex(
      direction: .vertical,
      children: [
        PaintOrder(
          order: 2,
          child: FractionalTranslation(
            translation: .new(0, 0.5),
            child: FlexCard(
              color: Colors.redAccent,
              text: 'Paint Order 2',
            ),
          ),
        ),
        PaintOrder(
          order: 1,
          child: FlexCard(
            color: Colors.green,
            text: 'Paint Order 1',
          ),
        ),
        PaintOrder(
          order: 0,
          child: FractionalTranslation(
            translation: .new(0, -0.5),
            child: FlexCard(
              color: Colors.blueAccent,
              text: 'Paint Order 0',
            ),
          ),
        ),
      ],
    );
  }
}

class FlexCard extends StatelessWidget {
  const FlexCard({
    super.key,
    required this.color,
    required this.text,
  });

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => debugPrint('Tapped on $text'),
      child: Container(
        height: 100,
        color: color,
        child: Center(
          child: Text(text, style: const .new(fontSize: 24)),
        ),
      ),
    );
  }
}
