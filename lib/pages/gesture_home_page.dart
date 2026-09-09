import 'package:flutter/material.dart';

import '../examples/combined_gesture_example.dart';
import '../examples/drag_example.dart';
import '../examples/fling_example.dart';
import '../examples/pointer_example.dart';
import '../examples/scale_example.dart';
import '../examples/swipe_example.dart';
import '../examples/tap_example.dart';

class GestureHomePage extends StatelessWidget {
  const GestureHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Gesture 실습'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _menu(
            context,
            title: '1. Tap / Double Tap / Long Press',
            subtitle: '기본 Tap 계열 Gesture',
            page: const TapExample(),
          ),
          _menu(
            context,
            title: '2. Drag / GestureDetails',
            subtitle: 'delta, localPosition, globalPosition',
            page: const DragExample(),
          ),
          _menu(
            context,
            title: '3. Swipe',
            subtitle: 'Drag 종료 속도로 방향 판정',
            page: const SwipeExample(),
          ),
          _menu(
            context,
            title: '4. Fling',
            subtitle: 'velocity + Simulation을 이용한 관성 이동',
            page: const FlingExample(),
          ),
          _menu(
            context,
            title: '5. Scale / Pinch / Rotation',
            subtitle: '멀티터치 확대, 축소, 회전',
            page: const ScaleExample(),
          ),
          _menu(
            context,
            title: '6. Pointer Event',
            subtitle: 'Listener를 이용한 저수준 입력',
            page: const PointerExample(),
          ),
          _menu(
            context,
            title: '7. Gesture 종합',
            subtitle: 'Tap + Drag + Scale + Rotation',
            page: const CombinedGestureExample(),
          ),
        ],
      ),
    );
  }

  Widget _menu(
      BuildContext context, {
        required String title,
        required String subtitle,
        required Widget page,
      }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(subtitle),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => page,
            ),
          );
        },
      ),
    );
  }
}