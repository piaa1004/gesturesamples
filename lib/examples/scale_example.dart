import 'package:flutter/material.dart';

class ScaleExample extends StatefulWidget {
  const ScaleExample({super.key});

  @override
  State<ScaleExample> createState() => _ScaleExampleState();
}

class _ScaleExampleState extends State<ScaleExample> {
  double _scale = 1;
  double _rotation = 0;
  Offset _offset = Offset.zero;

  double _startScale = 1;
  double _startRotation = 0;

  Offset _startOffset = Offset.zero;
  Offset _startFocalPoint = Offset.zero;

  int _pointerCount = 0;

  void _reset() {
    setState(() {
      _scale = 1;
      _rotation = 0;
      _offset = Offset.zero;
      _pointerCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scale / Pinch / Rotation',
        ),
        actions: [
          IconButton(
            onPressed: _reset,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            color: Colors.grey.shade100,
            child: Text(
              'scale = ${_scale.toStringAsFixed(2)}   '
                  'rotation = ${_rotation.toStringAsFixed(2)}\n'
                  'pointerCount = $_pointerCount',
              textAlign: TextAlign.center,
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),

              child: GestureDetector(
                behavior: HitTestBehavior.opaque,

                onScaleStart: (details) {
                  _startScale = _scale;
                  _startRotation = _rotation;

                  _startOffset = _offset;
                  _startFocalPoint =
                      details.localFocalPoint;

                  setState(() {
                    _pointerCount =
                        details.pointerCount;
                  });
                },

                onScaleUpdate: (details) {
                  setState(() {
                    _scale =
                        (_startScale * details.scale)
                            .clamp(
                          0.5,
                          4.0,
                        );

                    _rotation =
                        _startRotation +
                            details.rotation;

                    _offset =
                        _startOffset +
                            (
                                details.localFocalPoint -
                                    _startFocalPoint
                            );

                    _pointerCount =
                        details.pointerCount;
                  });
                },

                onScaleEnd: (details) {
                  setState(() {
                    _pointerCount = 0;
                  });
                },

                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    border: Border.all(
                      color: Colors.green,
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
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Center(
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..translate(
                              _offset.dx,
                              _offset.dy,
                            )
                            ..rotateZ(
                              _rotation,
                            )
                            ..scale(
                              _scale,
                            ),
                          child: Container(
                            width: 220,
                            height: 220,
                            decoration: BoxDecoration(
                              color: Colors.green.shade200,
                              borderRadius:
                              BorderRadius.circular(24),
                              border: Border.all(
                                color: Colors.green,
                                width: 2,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: const Column(
                              mainAxisSize:
                              MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.image,
                                  size: 80,
                                  color: Colors.green,
                                ),
                                SizedBox(height: 12),
                                Text(
                                  '한 손가락: 이동\n'
                                      '두 손가락: 확대/축소/회전',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}