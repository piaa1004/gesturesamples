import 'package:flutter/material.dart';

class PointerExample extends StatefulWidget {
  const PointerExample({super.key});

  @override
  State<PointerExample> createState() =>
      _PointerExampleState();
}

class _PointerExampleState
    extends State<PointerExample> {
  String _event = '화면을 터치하세요';

  Offset _localPosition = Offset.zero;
  Offset _globalPosition = Offset.zero;

  int? _pointer;

  void _update(
      String eventName,
      PointerEvent event,
      ) {
    setState(() {
      _event = eventName;
      _localPosition = event.localPosition;
      _globalPosition = event.position;
      _pointer = event.pointer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pointer Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Listener(
          behavior: HitTestBehavior.opaque,

          onPointerDown: (event) {
            _update(
              'PointerDownEvent',
              event,
            );
          },

          onPointerMove: (event) {
            _update(
              'PointerMoveEvent',
              event,
            );
          },

          onPointerUp: (event) {
            _update(
              'PointerUpEvent',
              event,
            );
          },

          onPointerCancel: (event) {
            _update(
              'PointerCancelEvent',
              event,
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
                    'Listener Pointer 영역',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Center(
                  child: Text(
                    '$_event\n\n'
                        'pointer = $_pointer\n\n'
                        'localPosition\n'
                        '$_localPosition\n\n'
                        'globalPosition\n'
                        '$_globalPosition',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}