import 'package:flutter/material.dart';

class CombinedGestureExample extends StatefulWidget {
  const CombinedGestureExample({super.key});

  @override
  State<CombinedGestureExample> createState() =>
      _CombinedGestureExampleState();
}

class _CombinedGestureExampleState
    extends State<CombinedGestureExample> {
  bool _selected = false;
  bool _liked = false;

  Offset _offset = Offset.zero;

  double _scale = 1;
  double _rotation = 0;

  Offset _startOffset = Offset.zero;
  Offset _startFocalPoint = Offset.zero;

  double _startScale = 1;
  double _startRotation = 0;

  String _message =
      'GestureDetector 영역에서 제스처를 실행하세요';

  void _reset() {
    setState(() {
      _selected = false;
      _liked = false;

      _offset = Offset.zero;

      _scale = 1;
      _rotation = 0;

      _message = '초기화되었습니다.';
    });
  }

  void _showMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('수정'),
                onTap: () {
                  Navigator.pop(context);

                  setState(() {
                    _message = '수정 선택';
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('공유'),
                onTap: () {
                  Navigator.pop(context);

                  setState(() {
                    _message = '공유 선택';
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('삭제'),
                onTap: () {
                  Navigator.pop(context);

                  setState(() {
                    _message = '삭제 선택';
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gesture 종합 예제'),
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
              _message,
              textAlign: TextAlign.center,
            ),
          ),

          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Tap: 선택\n'
                  'Double Tap: 좋아요\n'
                  'Long Press: 메뉴\n'
                  '한 손가락: 이동\n'
                  '두 손가락: 확대 / 축소 / 회전',
              textAlign: TextAlign.center,
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),

              child: GestureDetector(
                behavior: HitTestBehavior.opaque,

                onTap: () {
                  setState(() {
                    _selected = !_selected;

                    _message = _selected
                        ? 'Tap → 선택'
                        : 'Tap → 선택 해제';
                  });
                },

                onDoubleTap: () {
                  setState(() {
                    _liked = !_liked;

                    _message = _liked
                        ? 'Double Tap → 좋아요'
                        : 'Double Tap → 좋아요 취소';
                  });
                },

                onLongPress: () {
                  setState(() {
                    _message =
                    'Long Press → 메뉴 표시';
                  });

                  _showMenu();
                },

                onScaleStart: (details) {
                  _startScale = _scale;
                  _startRotation = _rotation;

                  _startOffset = _offset;

                  _startFocalPoint =
                      details.localFocalPoint;
                },

                onScaleUpdate: (details) {
                  setState(() {
                    final focalPointDelta =
                        details.localFocalPoint -
                            _startFocalPoint;

                    _offset =
                        _startOffset +
                            focalPointDelta;

                    if (details.pointerCount >= 2) {
                      _scale =
                          (
                              _startScale *
                                  details.scale
                          ).clamp(
                            0.5,
                            4.0,
                          );

                      _rotation =
                          _startRotation +
                              details.rotation;

                      _message =
                      'Multi-touch\n'
                          'scale = '
                          '${_scale.toStringAsFixed(2)}\n'
                          'rotation = '
                          '${_rotation.toStringAsFixed(2)}';
                    } else {
                      _message =
                      '한 손가락 Drag\n'
                          'offset = $_offset';
                    }
                  });
                },

                onScaleEnd: (details) {
                  debugPrint(
                    'velocity = '
                        '${details.velocity.pixelsPerSecond}',
                  );
                },

                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade50,
                    border: Border.all(
                      color: Colors.indigo,
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
                          'GestureDetector 전체 영역',
                          style: TextStyle(
                            color: Colors.indigo,
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

                          child: AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 180,
                            ),
                            width: 250,
                            height: 280,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius:
                              BorderRadius.circular(24),

                              border: Border.all(
                                color: _selected
                                    ? Colors.blue
                                    : Colors.blueGrey,
                                width: _selected ? 5 : 2,
                              ),

                              boxShadow: _selected
                                  ? const [
                                BoxShadow(
                                  blurRadius: 12,
                                  color: Colors.black26,
                                ),
                              ]
                                  : null,
                            ),

                            child: Stack(
                              children: [
                                const Center(
                                  child: Column(
                                    mainAxisSize:
                                    MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.landscape,
                                        size: 90,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        'Gesture Image',
                                        style: TextStyle(
                                          fontSize: 21,
                                          fontWeight:
                                          FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                if (_liked)
                                  const Positioned(
                                    top: 18,
                                    right: 18,
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 42,
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}