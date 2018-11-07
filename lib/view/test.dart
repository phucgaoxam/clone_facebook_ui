import 'package:clone_facebook_ui/tiny_base/base_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TestView extends StatefulWidget {
  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends BaseState<TestView> {
  ScrollController controller = ScrollController();
  GlobalKey<_AppBarAnimationState> key = GlobalKey();
  Drag _drag;
  ScrollHoldController _hold;
  Map<Type, GestureRecognizerFactory> gestures = <Type, GestureRecognizerFactory>{};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) {});
  }

  @override
  Widget build(BuildContext context) {
    gestures[VerticalDragGestureRecognizer] = GestureRecognizerFactoryWithHandlers<VerticalDragGestureRecognizer>(
      () => VerticalDragGestureRecognizer(debugOwner: this),
      (VerticalDragGestureRecognizer instance) {
        instance
          ..onDown = onVerticalDragDown
          ..onStart = onVerticalDragStart
          ..onUpdate = onVerticalDragUpdate
          ..onEnd = onVerticalDragEnd
          ..onCancel = onVerticalDragCancel
          ..minFlingDistance = controller.position.physics?.minFlingDistance
          ..minFlingVelocity = controller.position.physics?.minFlingVelocity
          ..maxFlingVelocity = controller.position.physics?.maxFlingVelocity;
      },
    );
    return Scaffold(
      body: RawGestureDetector(
        gestures: gestures,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              AppBarAnimation(
                key,
                container: Container(
                  height: 200.0,
                  width: double.infinity,
                  color: Colors.blue,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 200.0,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: controller,
                  shrinkWrap: true,
                  itemCount: 100,
                  itemBuilder: (context, index) => ListTile(
                        title: Text('$index'),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onVerticalDragDown(DragDownDetails details) {
    print('asdasd $details');
    _hold = controller.position.hold(disposeHold);
  }

  void disposeHold() {
    _hold = null;
  }

  void disposeDrag() {
    _drag = null;
  }

  void onVerticalDragStart(DragStartDetails details) {
    _drag = controller.position.drag(details, disposeDrag);
  }

  void onVerticalDragEnd(DragEndDetails details) {
    _drag.end(details);
  }

  void onVerticalDragUpdate(DragUpdateDetails details) {
    _drag.update(details);
  }

  void onVerticalDragCancel() {
    _hold?.cancel();
    _drag?.cancel();
  }
}

class AppBarAnimation extends StatefulWidget {
  final Widget container;

  AppBarAnimation(Key key, {this.container}) : super(key: key);

  @override
  _AppBarAnimationState createState() => _AppBarAnimationState();
}

class _AppBarAnimationState extends State<AppBarAnimation> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: _controller.value,
      child: widget.container,
    );
  }

  void scale(DragUpdateDetails details) {}
}
