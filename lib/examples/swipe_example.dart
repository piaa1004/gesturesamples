import 'package:flutter/material.dart';

class SwipeExample extends StatefulWidget {
  const SwipeExample({super.key});

  @override
  State<SwipeExample> createState() => _SwipeExampleState();
}

class _SwipeExampleState extends State<SwipeExample> {
  static const double threshold = 500;

  String message = '이 영역을 빠르게 Swipe 하세요';

  void _horizontalSwipe(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;

    setState(() {
      if (velocity > threshold) {
        message =
        '→ 오른쪽 Swipe\n'
            'velocity = ${velocity.toStringAsFixed(0)} px/s';
      } else if (velocity < -threshold) {
        message =
        '← 왼쪽 Swipe\n'
            'velocity = ${velocity.toStringAsFixed(0)} px/s';
      } else {
        message =
        '가로 Drag\n'
            'Swipe 기준 속도보다 느립니다.';
      }
    });
  }

  void _verticalSwipe(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;

    setState(() {
      if (velocity > threshold) {
        message =
        '↓ 아래쪽 Swipe\n'
            'velocity = ${velocity.toStringAsFixed(0)} px/s';
      } else if (velocity < -threshold) {
        message =
        '↑ 위쪽 Swipe\n'
            'velocity = ${velocity.toStringAsFixed(0)} px/s';
      } else {
        message =
        '세로 Drag\n'
            'Swipe 기준 속도보다 느립니다.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swipe Gesture'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,

            onHorizontalDragEnd: _horizontalSwipe,
            onVerticalDragEnd: _verticalSwipe,

            child: Container(
              width: double.infinity,
              height: 420,
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                border: Border.all(
                  color: Colors.purple,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                children: [
                  const Positioned(
                    top: 16,
                    left: 16,
                    child: Text(
                      'GestureDetector 영역',
                      style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const Positioned(
                    top: 70,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.arrow_back, size: 40),
                        Icon(Icons.arrow_upward, size: 40),
                        Icon(Icons.arrow_downward, size: 40),
                        Icon(Icons.arrow_forward, size: 40),
                      ],
                    ),
                  ),

                  Center(
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}