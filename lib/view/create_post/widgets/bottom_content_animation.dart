part of create_post_view;

class BackdropContentAnimation extends StatefulWidget {
  final BackdropContent backdropContent;
  final InputContent inputContent;
  final ScrollController backDropScrollController;

  BackdropContentAnimation(
      {@required this.backdropContent, @required this.inputContent, this.backDropScrollController});

  @override
  _BackdropContentAnimationState createState() => _BackdropContentAnimationState();
}

class _BackdropContentAnimationState extends State<BackdropContentAnimation> with SingleTickerProviderStateMixin {
  Drag _drag;
  ScrollHoldController _hold;

  Animation<RelativeRect> panelAnimation;
  AnimationController _controller;

  Map<Type, GestureRecognizerFactory> _gestures = <Type, GestureRecognizerFactory>{};

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));

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
    if (panelAnimation == null) {
      panelAnimation = RelativeRectTween(
        begin: RelativeRect.fromLTRB(0.0, SizeUtil.instance.getBigger(), 0.0, 0.0),
        end: RelativeRect.fromLTRB(0.0, SizeUtil.instance.getSize(300, basedOnSmaller: false), 0.0, 0.0),
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    }
    return _buildStack();
  }

  Widget _buildStack() {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: closeBackdrop,
            child: widget.inputContent,
          ),
          RawGestureDetector(gestures: _gestures, child: widget.backdropContent),
        ],
      ),
    );
  }

  void closeBackdrop() {
    _controller.animateTo(0.0);
  }

  void onVerticalDragDown(DragDownDetails details) {
    _hold = widget.backDropScrollController.position.hold(onDisposeHold);
  }

  void onVerticalDragStart(DragStartDetails details) {
    _drag = widget.backDropScrollController.position.drag(details, onDisposeDrag);
  }

  void onVerticalDragUpdate(DragUpdateDetails details) {
    _drag.update(details);
  }

  void onVerticalDragEnd(DragEndDetails details) {
    _drag.end(details);
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
