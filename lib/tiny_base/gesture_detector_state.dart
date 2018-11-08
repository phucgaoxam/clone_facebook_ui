import 'package:clone_facebook_ui/tiny_base/base_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

abstract class GestureDetectorState<T extends StatefulWidget> extends BaseState<T> with AutomaticKeepAliveClientMixin {
  final ScrollController _mainScrollController;

  GestureDetectorState(this._mainScrollController);

  @override
  bool get wantKeepAlive => true;

  //Controller of child scrollview
  ScrollController _childScrollController = ScrollController();

  Drag _childDrag;

  ScrollHoldController _childHold;

  Drag _mainDrag;

  ScrollHoldController _mainHold;

  Map<Type, GestureRecognizerFactory> _gestures = <Type, GestureRecognizerFactory>{};

  ScrollController get mainScrollController => mainScrollController;

  Widget buildChild(BuildContext context);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (duration) {
        _gestures[VerticalDragGestureRecognizer] = GestureRecognizerFactoryWithHandlers<VerticalDragGestureRecognizer>(
          () => VerticalDragGestureRecognizer(debugOwner: this),
          (VerticalDragGestureRecognizer instance) {
            instance
              ..onStart = onVerticalDragStart
              ..onDown = onVerticalDragDown
              ..onUpdate = onVerticalDragUpdate
              ..onEnd = onVerticalDragEnd
              ..onCancel = onVerticalDragCancel;
          },
        );
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RawGestureDetector(
      gestures: _gestures,
      child: buildChild(context),
    );
  }

  ScrollPhysics get defaultScrollPhysics => NeverScrollableScrollPhysics();

  ScrollController get childScrollController => _childScrollController;

  void onVerticalDragDown(DragDownDetails details) {
    _mainHold = _mainScrollController.position.hold(disposeMainHold);
    _childHold = _childScrollController.position.hold(disposeChildHold);
  }

  void disposeMainHold() {
    _mainHold = null;
  }

  void disposeMainDrag() {
    _mainDrag = null;
  }

  void disposeChildHold() {
    _childHold = null;
  }

  void disposeChildDrag() {
    _childDrag = null;
  }

  void onVerticalDragStart(DragStartDetails details) {
    _mainDrag = _mainScrollController.position.drag(details, disposeMainDrag);
    _childDrag = _childScrollController.position.drag(details, disposeChildDrag);
  }

  void onVerticalDragEnd(DragEndDetails details) {
    _mainDrag.end(details);
    _childDrag.end(details);
  }

  void onVerticalDragUpdate(DragUpdateDetails details) {
    if (details.delta.dy < 0) {
      if (_mainScrollController.position.pixels < _mainScrollController.position.maxScrollExtent) {
        _mainDrag.update(details);
      } else {
        _childDrag.update(details);
      }
    } else {
      _mainDrag.update(details);
      _childDrag.update(details);
    }
  }

  void onVerticalDragCancel() {
    _childDrag?.cancel();
    _childHold?.cancel();
    _mainHold?.cancel();
    _mainDrag?.cancel();
  }
}
