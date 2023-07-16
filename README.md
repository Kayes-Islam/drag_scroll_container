## Features

A flutter container widget that scrolls during drag and drop operatin. If you are creating your own drag-drop container, this could be useful.

## Demo

![](drag_scroll_container_demo.gif|width=100px)


## Usage

Supply the ScrollController and a child. Ie n the example below we are passing in the same ScrollController used by the ListView:
```
DragScrollContainer(
  scrollController: scrollController1,
  child: ListView.builder(
    controller: scrollController1,
    itemCount: 100,
    itemBuilder:(context, index) => Center(child: DraggableBlock(index: index)),
  ),
)
```

## More info
launch.json as been configured to run the ./example/lib/main.dart.
