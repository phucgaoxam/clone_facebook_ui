library main_view;

import 'package:clone_facebook_ui/resources/app_colors.dart';
import 'package:clone_facebook_ui/tiny_base/base_state.dart';
import 'package:clone_facebook_ui/view/main/feed/feed_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'clip/clip_view.dart';
import 'feed/feed_view.dart';
import 'friend/friend_view.dart';
import 'group/group_view.dart';
import 'menu/menu_view.dart';
import 'notification/notification_view.dart';

part 'main_widgets.dart';

class MainView extends StatefulWidget {
  @override
  MainViewState createState() => MainViewState();
}

class MainViewState extends BaseState<MainView> with MainViewUIContract, SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _tabController = PageController(initialPage: 0, keepPage: true);

    WidgetsBinding.instance.addPostFrameCallback((duration) {
      gestures[HorizontalDragGestureRecognizer] = GestureRecognizerFactoryWithHandlers<HorizontalDragGestureRecognizer>(
        () => HorizontalDragGestureRecognizer(debugOwner: this),
        (HorizontalDragGestureRecognizer instance) {
          instance
            ..onDown = onHorizontalDragDown
            ..onStart = onHorizontalDragStart
            ..onUpdate = onHorizontalDragUpdate
            ..onEnd = onHorizontalDragEnd
            ..onCancel = onHorizontalDragCancel;
        },
      );
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(gestures: gestures, child: _build(this));
  }

  @override
  BuildContext get _context => context;

  void onHorizontalDragDown(DragDownDetails details) {
    _tabHold = _tabController.position.hold(disposeTabHold);
  }

  void onHorizontalDragStart(DragStartDetails details) {
    _tabDrag = _tabController.position.drag(details, disposeTabDrag);
  }

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    _tabDrag.update(details);
  }

  void disposeTabHold() {
    _tabHold = null;
  }

  void disposeTabDrag() {
    _tabDrag = null;
  }


  void onHorizontalDragEnd(DragEndDetails details) {
    _tabDrag.end(details);
  }

  void onHorizontalDragCancel() {
    _tabDrag?.cancel();
    _tabHold?.cancel();
  }

  @override
  void onPageChanged(int page) {
    mainScrollController.animateTo(0.0, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }
}
