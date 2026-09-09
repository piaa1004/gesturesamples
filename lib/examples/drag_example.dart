import 'package:flutter/material.dart';

class DragExample extends StatefulWidget {
  const DragExample({super.key});

  @override
  State<DragExample> createState() => _DragExampleState();
}

class _DragExampleState extends State<DragExample> {
  Offset position = const Offset(80, 200);

  String status = '파란 박스를 Drag 하세요';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drag Gesture'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const boxSize = 130.0;

          final maxX = (constraints.maxWidth - boxSize)
              .clamp(0.0, double.infinity);

          final maxY = (constraints.maxHeight - boxSize)
              .clamp(120.0, double.infinity);

          return Stack(
            children: [
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    status,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              Positioned(
                left: position.dx.clamp(0.0, maxX),
                top: position.dy.clamp(120.0, maxY),

                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,

                  onPanStart: (details) {
                    setState(() {
                      status =
                      'onPanStart\n'
                          'local = ${details.localPosition}\n'
                          'global = ${details.globalPosition}';
                    });
                  },

                  onPanUpdate: (details) {
                    setState(() {
                      final next = position + details.delta;

                      position = Offset(
                        next.dx.clamp(0.0, maxX),
                        next.dy.clamp(120.0, maxY),
                      );

                      status =
                      'onPanUpdate\n'
                          'delta = ${details.delta}\n'
                          'local = ${details.localPosition}\n'
                          'global = ${details.globalPosition}';
                    });
                  },

                  onPanEnd: (details) {
                    setState(() {
                      status =
                      'onPanEnd\n'
                          'velocity = '
                          '${details.velocity.pixelsPerSecond}';
                    });
                  },

                  onPanCancel: () {
                    setState(() {
                      status = 'onPanCancel';
                    });
                  },

                  child: Container(
                    width: boxSize,
                    height: boxSize,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      border: Border.all(
                        color: Colors.blue,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.open_with,
                          color: Colors.blue,
                          size: 38,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'GestureDetector\nDRAG AREA',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}