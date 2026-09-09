import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class FlingExample extends StatefulWidget {
  const FlingExample({super.key});

  @override
  State<FlingExample> createState() => _FlingExampleState();
}

class _FlingExampleState extends State<FlingExample>
    with SingleTickerProviderStateMixin {

  final ScrollController _scrollController =
  ScrollController();

  late final AnimationController _animationController;

  double _dragStartOffset = 0;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController.unbounded(
          vsync: this,
        );

    /*
     * AnimationController의 값이 변하면
     * ListView의 Scroll Offset도 변경한다.
     */
    _animationController.addListener(() {
      if (!_scrollController.hasClients) {
        return;
      }

      final position =
          _scrollController.position;

      final offset =
      _animationController.value.clamp(
        position.minScrollExtent,
        position.maxScrollExtent,
      );

      _scrollController.jumpTo(offset);

      /*
       * ListView 끝에 도달하면
       * Fling Animation 정지
       */
      if (_animationController.value <=
          position.minScrollExtent ||
          _animationController.value >=
              position.maxScrollExtent) {

        _animationController.stop();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  void _onVerticalDragStart(
      DragStartDetails details,
      ) {
    /*
     * Fling 중에 다시 손가락을 누르면
     * 기존 관성 이동을 즉시 중단한다.
     */
    _animationController.stop();

    _dragStartOffset =
        _scrollController.offset;
  }

  void _onVerticalDragUpdate(
      DragUpdateDetails details,
      ) {
    /*
     * 손가락 이동 방향과
     * Scroll 방향은 반대다.
     *
     * 손가락 ↑
     * delta.dy < 0
     *
     * ListView는 아래쪽 데이터 방향으로 이동
     * Scroll Offset 증가
     */

    final nextOffset =
        _scrollController.offset -
            details.delta.dy;

    final position =
        _scrollController.position;

    final offset =
    nextOffset.clamp(
      position.minScrollExtent,
      position.maxScrollExtent,
    );

    _scrollController.jumpTo(offset);
  }

  void _onVerticalDragEnd(
      DragEndDetails details,
      ) {
    /*
     * 손가락을 뗀 순간의 속도
     */
    final velocity =
        details.primaryVelocity ?? 0;

    /*
     * Gesture의 velocity 방향과
     * Scroll Offset 방향은 반대
     */
    final scrollVelocity =
    -velocity;

    /*
     * 너무 느리게 움직였다면
     * Fling으로 처리하지 않는다.
     */
    if (scrollVelocity.abs() < 300) {
      return;
    }

    /*
     * 현재 ListView Scroll Offset에서
     * Fling 시작
     */
    _animationController.value =
        _scrollController.offset;

    /*
     * 마찰에 의해 속도가
     * 점점 감소하는 Simulation
     */
    final simulation =
    FrictionSimulation(
      0.135,
      _scrollController.offset,
      scrollVelocity,
    );

    /*
     * Simulation을 이용해서
     * 관성 이동 시작
     */
    _animationController.animateWith(
      simulation,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'GestureDetector Fling',
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),

        /*
         * 이 GestureDetector가
         * ListView의 Drag/Fling Gesture를
         * 직접 처리한다.
         */
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,

          onVerticalDragStart:
          _onVerticalDragStart,

          onVerticalDragUpdate:
          _onVerticalDragUpdate,

          onVerticalDragEnd:
          _onVerticalDragEnd,

          child: Container(
            width: double.infinity,
            height: double.infinity,

            decoration: BoxDecoration(
              color: Colors.orange.shade50,

              border: Border.all(
                color: Colors.orange,
                width: 3,
              ),

              borderRadius:
              BorderRadius.circular(24),
            ),

            child: ClipRRect(
              borderRadius:
              BorderRadius.circular(21),

              /*
               * 중요:
               *
               * ListView 자체 Scroll Gesture를
               * 비활성화한다.
               *
               * 스크롤은 바깥 GestureDetector가
               * 직접 처리한다.
               */
              child: ListView.builder(
                controller:
                _scrollController,

                physics:
                const NeverScrollableScrollPhysics(),

                padding:
                const EdgeInsets.all(12),

                itemCount: 1000,

                itemBuilder:
                    (context, index) {

                  return Container(
                    height: 72,

                    margin:
                    const EdgeInsets.only(
                      bottom: 8,
                    ),

                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 18,
                    ),

                    decoration:
                    BoxDecoration(
                      color: Colors.white,

                      borderRadius:
                      BorderRadius.circular(
                        14,
                      ),

                      border: Border.all(
                        color:
                        Colors.orange.shade200,
                      ),
                    ),

                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor:
                          Colors.orange
                              .shade100,

                          child: Text(
                            '${index + 1}',
                          ),
                        ),

                        const SizedBox(
                          width: 16,
                        ),

                        Text(
                          'List Item '
                              '${index + 1}',

                          style:
                          const TextStyle(
                            fontSize: 17,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}