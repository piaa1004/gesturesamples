import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class FlingExample extends StatefulWidget {
  const FlingExample({super.key});

  @override
  State<FlingExample> createState() => _FlingExampleState();
}

class _FlingExampleState extends State<FlingExample>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  double _x = 40;

  double _minX = 0;
  double _maxX = 0;

  String _status = '주황색 박스를 빠르게 좌우로 던져보세요';

  @override
  void initState() {
    super.initState();

    _controller = AnimationController.unbounded(
      vsync: this,
    );

    _controller.addListener(() {
      final value = _controller.value.clamp(
        _minX,
        _maxX,
      );

      if (value != _x) {
        setState(() {
          _x = value;
        });
      }

      if (_controller.value <= _minX ||
          _controller.value >= _maxX) {
        _controller.stop();
      }
    });
  }

  void _startFling(double velocity) {
    _controller.stop();

    _controller.value = _x;

    final simulation = FrictionSimulation(
      0.135,
      _x,
      velocity,
    );

    _controller.animateWith(simulation);

    setState(() {
      _status =
      'Fling 시작\n'
          'velocity = ${velocity.toStringAsFixed(0)} px/s';
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fling Gesture'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const boxSize = 130.0;

          _minX = 0;

          _maxX = (constraints.maxWidth - boxSize)
              .clamp(0.0, double.infinity);

          _x = _x.clamp(
            _minX,
            _maxX,
          );

          return Stack(
            children: [
              Positioned(
                top: 20,
                left: 20,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    _status,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              Positioned(
                top: 180,
                left: 16,
                right: 16,
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    border: Border.all(
                      color: Colors.grey,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '이 영역 안에서 Fling',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 205,
                left: _x,

                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,

                  onHorizontalDragStart: (_) {
                    _controller.stop();

                    setState(() {
                      _status = 'Drag 시작';
                    });
                  },

                  onHorizontalDragUpdate: (details) {
                    setState(() {
                      _x = (_x + details.delta.dx)
                          .clamp(
                        _minX,
                        _maxX,
                      );

                      _status = 'Drag 중';
                    });
                  },

                  onHorizontalDragEnd: (details) {
                    final velocity =
                        details.primaryVelocity ?? 0;

                    _startFling(velocity);
                  },

                  child: Container(
                    width: boxSize,
                    height: boxSize,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      border: Border.all(
                        color: Colors.orange,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.speed,
                          size: 38,
                          color: Colors.orange,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'GestureDetector\nFLING AREA',
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