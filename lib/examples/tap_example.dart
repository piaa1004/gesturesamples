import 'package:flutter/material.dart';

class TapExample extends StatefulWidget {
  const TapExample({super.key});

  @override
  State<TapExample> createState() => _TapExampleState();
}

class _TapExampleState extends State<TapExample> {
  String message = '이 영역을 터치하세요';

  void _setMessage(String value) {
    setState(() {
      message = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tap Gesture'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              '아래 파란 영역 전체가 GestureDetector의 터치 감지 영역입니다.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,

                onTapDown: (details) {
                  _setMessage(
                    'onTapDown\n\n'
                        'localPosition\n'
                        '${details.localPosition}\n\n'
                        'globalPosition\n'
                        '${details.globalPosition}',
                  );
                },

                onTapUp: (details) {
                  _setMessage(
                    'onTapUp\n\n'
                        'localPosition\n'
                        '${details.localPosition}',
                  );
                },

                onTap: () {
                  _setMessage(
                    'onTap\n\n'
                        'Tap 완료',
                  );
                },

                onTapCancel: () {
                  _setMessage(
                    'onTapCancel\n\n'
                        'Tap 취소',
                  );
                },

                onDoubleTap: () {
                  _setMessage(
                    'onDoubleTap\n\n'
                        '두 번 빠르게 터치했습니다.',
                  );
                },

                onLongPressStart: (details) {
                  _setMessage(
                    'onLongPressStart\n\n'
                        '${details.localPosition}',
                  );
                },

                onLongPress: () {
                  _setMessage(
                    'onLongPress\n\n'
                        '길게 누르기가 인식되었습니다.',
                  );
                },

                onLongPressEnd: (details) {
                  _setMessage(
                    'onLongPressEnd\n\n'
                        '${details.localPosition}',
                  );
                },

                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    border: Border.all(
                      color: Colors.blue,
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
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Center(
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}