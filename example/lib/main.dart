import 'package:drag_scroll_container/drag_scroll_container.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drag Scroll Container Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final ScrollController scrollController1 = ScrollController();
  final ScrollController scrollController2 = ScrollController();

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drag Scroll Container Demo'),
      ),
      body: Column(
        children: [
          const Text("Group 1"),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: DragScrollContainer(
                scrollController: scrollController1,
                child: ListView.builder(
                  controller: scrollController1,
                  itemCount: 100,
                  itemBuilder:(context, index) => Center(child: DraggableBlock(index: index)),
                ),
              ),
            ),
          ),
          const Text("Group 2"),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: DragScrollContainer(
                scrollController: scrollController2,
                child: ListView.builder(
                  controller: scrollController2,
                  itemCount: 100,
                  itemBuilder:(context, index) => Center(child: DraggableBlock(index: index)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DraggableBlock extends StatelessWidget {
  final int index;

  const DraggableBlock({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      feedback: buildWidget(true),
      child: buildWidget(false),
    );
  }

  Widget buildWidget(bool isFeedback) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        height: 100,
        width: 100,
        color: isFeedback ? Colors.lightBlueAccent : Colors.grey,
        child: Center(
          child: Text(
            'Block $index',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
