import 'package:flutter/material.dart';

class DragScrollContainer extends StatefulWidget {
  final ScrollController scrollController;
  final double scrollRate;
  final Widget child;


  // Number pixels from the top or bottom edge when scroll starts
  final int edgeScrollPixels;

  const DragScrollContainer({
    Key? key, 
    required this.scrollController,
    required this.child,
    this.scrollRate = 100.0,
    this.edgeScrollPixels = 50
  }) : super(key: key);

  @override
  State<DragScrollContainer> createState() => _DragScrollContainerState();
}

class _DragScrollContainerState extends State<DragScrollContainer> {
  bool isScrollingUp = false;
  bool isScrollingDown = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: handleDragUpdate,
      onPointerUp: handleDragEnd,
      child: widget.child,
    );
  }

  void handleDragUpdate(PointerMoveEvent event) {
    final RenderBox containerBox = context.findRenderObject() as RenderBox;
    final containerPosition = containerBox.localToGlobal(Offset.zero);
    final containerSize = containerBox.size;

    
    if ((event.position.dy - containerPosition.dy) <= widget.edgeScrollPixels && widget.scrollController.position.pixels > 0) {
      startScrollingUp();
    } else if ((containerPosition.dy + containerSize.height - event.position.dy) <= widget.edgeScrollPixels &&
        widget.scrollController.position.pixels < widget.scrollController.position.maxScrollExtent) {
      startScrollingDown();
    } else {
      stopScrolling();
    }
  }

  void handleDragEnd(PointerUpEvent event) {
    stopScrolling();
  }

  void startScrollingUp() {
    if (!isScrollingUp) {
      setState(() {
        isScrollingUp = true;
      });
      scrollUp();
    }
  }

  void startScrollingDown() {
    if (!isScrollingDown) {
      setState(() {
        isScrollingDown = true;
      });
      scrollDown();
    }
  }

  void stopScrolling() {
    if (isScrollingUp || isScrollingDown) {
      setState(() {
        isScrollingUp = false;
        isScrollingDown = false;
      });
    }
  }

  void scrollUp() {
    widget.scrollController.animateTo(
      widget.scrollController.position.pixels - widget.scrollRate,
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
    );

    if (isScrollingUp) {
      Future.delayed(const Duration(milliseconds: 200), scrollUp);
    }
  }

  void scrollDown() {
    widget.scrollController.animateTo(
      widget.scrollController.position.pixels + widget.scrollRate,
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
    );

    if (isScrollingDown) {
      Future.delayed(const Duration(milliseconds: 200), scrollDown);
    }
  }
}
