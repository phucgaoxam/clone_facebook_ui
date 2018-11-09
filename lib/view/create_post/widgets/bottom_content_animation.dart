part of create_post_view;

class BackdropContentAnimation extends StatefulWidget {
  final Widget backdropContent;
  final InputContent inputContent;
  final ScrollController backDropScrollController;

  BackdropContentAnimation(Key key,
      {@required this.backdropContent, @required this.inputContent, this.backDropScrollController})
      : super(key: key);

  @override
  _BackdropContentAnimationState createState() => _BackdropContentAnimationState();
}

class _BackdropContentAnimationState extends BaseState<BackdropContentAnimation> with SingleTickerProviderStateMixin {
  Drag _drag;
  ScrollHoldController _hold;

  Animation<RelativeRect> panelAnimation;
  AnimationController _controller;
  double _backdropSize;

  StreamController<double> _opacityStreamController = StreamController.broadcast();

  Map<Type, GestureRecognizerFactory> _gestures = <Type, GestureRecognizerFactory>{};

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _controller.value = 0.5;
    _backdropSize = SizeUtil.instance.getBigger() - 56.0;

    WidgetsBinding.instance.addPostFrameCallback((duration) {
      _gestures[VerticalDragGestureRecognizer] = GestureRecognizerFactoryWithHandlers<VerticalDragGestureRecognizer>(
          () => VerticalDragGestureRecognizer(debugOwner: this), (VerticalDragGestureRecognizer instance) {
        instance
          ..onDown = onVerticalDragDown
          ..onStart = onVerticalDragStart
          ..onUpdate = onVerticalDragUpdate
          ..onEnd = onVerticalDragEnd
          ..onCancel = onVerticalDragCancel;
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    print('${SizeUtil.instance.getBigger()} - ${SizeUtil.instance.getSize(200, basedOnSmaller: false)}');
    panelAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
      end: RelativeRect.fromLTRB(0.0, SizeUtil.instance.getBigger(), 0.0, 0.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    return _buildStack();
  }

  Widget _buildStack() {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: closeBackdrop,
          child: widget.inputContent,
        ),
        PositionedTransition(
          rect: panelAnimation,
          child: RawGestureDetector(
            gestures: _gestures,
            child: Container(
              height: _backdropSize,
              child: Column(
                children: <Widget>[
                  StreamBuilder<double>(
                    builder: (context, asyncSnapshot) {
                      return Opacity(
                        opacity: asyncSnapshot.data,
                        child: Container(
                          height: 20.0,
                          child: Icon(Icons.arrow_drop_down),
                        ),
                      );
                    },
                    stream: _opacityStreamController.stream,
                    initialData: 1.0,
                  ),
                  Container(
                    height: _backdropSize - 20.0,
                    child: widget.backdropContent,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _opacityStreamController.close();
    super.dispose();
  }

  void closeBackdrop() {
    _controller.animateTo(0.0);
  }

  void openBackdrop() {
    if (_controller.value == 0.0)
      animate(0.5);
  }

  void onVerticalDragDown(DragDownDetails details) {
    _hold = widget.backDropScrollController.position.hold(onDisposeHold);
  }

  void onVerticalDragStart(DragStartDetails details) {
    _drag = widget.backDropScrollController.position.drag(details, onDisposeDrag);
  }

  void onVerticalDragUpdate(DragUpdateDetails details) {
    if (details.delta.dy < 0) {
      if (_controller.value <= 0.0) {
        _drag?.update(details);
      } else {
        _controller.value += details.primaryDelta / _backdropSize ?? details.primaryDelta;
        _opacityStreamController.sink.add((1 - _controller.value).abs());
      }
    } else if (details.delta.dy > 0) {
      if (widget.backDropScrollController.position.extentBefore <= 0.0 && panelAnimation.value.top < _backdropSize) {
        _controller.value += details.primaryDelta / _backdropSize ?? details.primaryDelta;
        _opacityStreamController.sink.add((1 - _controller.value).abs());
      } else {
        _drag?.update(details);
      }
    }
  }

  void onVerticalDragEnd(DragEndDetails details) {
    print('velocity: ${details.primaryVelocity}');
    if (details.primaryVelocity < 0.0) {
      if (panelAnimation.value.top <= 0.0) {
        _drag?.end(details);
      } else {
        _autoSlideBackdrop(details);
      }
    } else if (details.primaryVelocity > 0.0) {
      if (widget.backDropScrollController.position.extentBefore <= 0.0 && panelAnimation.value.top < _backdropSize) {
        _autoSlideBackdrop(details);
      } else {
        _drag?.end(details);
      }
    } else {
      _autoSlideBackdrop(details);
    }

    _drag = null;
    _drag.end(details);
  }

  void _autoSlideBackdrop(DragEndDetails details) {
    if (_controller.value >= 0.5) {
      animate(1.0);
    } else if (_controller.value < 0.5) {
      animate(0.0);
    }
  }

  void animate(double value) {
    _controller.animateTo(value);
  }

  void onVerticalDragCancel() {
    _drag.cancel();
    _hold.cancel();
  }

  void onDisposeHold() {
    _hold = null;
  }

  void onDisposeDrag() {
    _drag = null;
  }
}
