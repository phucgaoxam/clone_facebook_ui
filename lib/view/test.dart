import 'package:clone_facebook_ui/tiny_base/base_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TestView extends StatefulWidget {
  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends BaseState<TestView> {
  ScrollController _listController = ScrollController();
  ScrollController _mainController = ScrollController();
  GlobalKey<_AppBarAnimationState> key = GlobalKey();
  Drag _listDrag;
  ScrollHoldController _listHold;
  Drag _mainDrag;
  ScrollHoldController _mainHold;
  Map<Type, GestureRecognizerFactory> gestures = <Type, GestureRecognizerFactory>{};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) {});
  }

  @override
  Widget build(BuildContext context) {
    try {
      gestures[VerticalDragGestureRecognizer] = GestureRecognizerFactoryWithHandlers<VerticalDragGestureRecognizer>(
        () => VerticalDragGestureRecognizer(debugOwner: this),
        (VerticalDragGestureRecognizer instance) {
          instance.onDown = onVerticalDragDown;
          instance
            ..onStart = onVerticalDragStart
            ..onUpdate = onVerticalDragUpdate
            ..onEnd = onVerticalDragEnd
            ..onCancel = onVerticalDragCancel;
        },
      );
    } catch (ex) {}
    return Scaffold(
      body: RawGestureDetector(
        gestures: gestures,
        child: Container(
          height: MediaQuery.of(context).size.height + 200.0,
          child: CustomScrollView(
            physics: NeverScrollableScrollPhysics(),
            controller: _mainController,
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  height: 200.0,
                  width: double.infinity,
                  color: Colors.blue,
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _listController,
                    shrinkWrap: true,
                    itemCount: 100,
                    itemBuilder: (context, index) => ListTile(
                          title: Text('$index'),
                        ),
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
    _listHold = _listController.position.hold(disposeHold);
    _mainHold = _mainController.position.hold(disposeMainHold);
  }

  void disposeHold() {
    _listHold = null;
  }

  void disposeMainHold() {
    _mainHold = null;
  }

  void disposeDrag() {
    _listDrag = null;
  }

  void disposeMainDrag() {
    _mainDrag = null;
  }

  void onVerticalDragStart(DragStartDetails details) {
    _listDrag = _listController.position.drag(details, disposeDrag);
    _mainDrag = _mainController.position.drag(details, disposeMainDrag);
  }

  void onVerticalDragEnd(DragEndDetails details) {
    _listDrag.end(details);
    _mainDrag.end(details);
    //  key.currentState.onEnd();
  }

  void onVerticalDragUpdate(DragUpdateDetails details) {
    if (details.delta.dy < 0) {
      print('main: ${_mainController.position}');
      if (_listController.position.extentBefore <= 0.0 && _mainController.position.pixels < 200.0) {
        // key.currentState.scale(details);
        _mainDrag.update(details);
      } else {
        _listDrag.update(details);
      }
    } else {
      //  key.currentState.scale(details);
      _mainDrag.update(details);
      _listDrag.update(details);
    }
  }

  void onVerticalDragCancel() {
    print('drag cancel');
    _listHold?.cancel();
    _listDrag?.cancel();
    _mainHold?.cancel();
    _mainDrag?.cancel();
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
  Animation<Offset> panelAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _controller.value = 1.0;
  }

  @override
  Widget build(BuildContext context) {
    if (panelAnimation == null) {
      panelAnimation = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(0.0, -200.0)).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.linear,
        ),
      );
    }
    //height 200.0
    return SlideTransition(
      position: panelAnimation,
      child: widget.container,
    );
  }

  void scale(DragUpdateDetails details) {
    print('delta: ${details.primaryDelta}');
    // if (details.delta.dy > 0) {
    _controller.value += details.primaryDelta / 200.0 ?? details.primaryDelta;
    //  } else {
    //     _controller.value += details.primaryDelta / 200.0 ?? details.primaryDelta;
    //   }
    setState(() {});
    print('value: ${_controller.value}');
  }

  void onEnd() {
    _controller.value = 1.0;
    setState(() {});
  }
}
