library notification_view;

import 'dart:async';

import 'package:clone_facebook_ui/tiny_base/gesture_detector_state.dart';
import 'package:flutter/material.dart';
import 'package:clone_facebook_ui/tiny_base/base_state.dart';

part 'notification_widgets.dart';

class NotificationView extends StatefulWidget {
  final ScrollController scrollController;

  NotificationView(Key key, this.scrollController) : super(key: key);

  @override
  _NotificationViewState createState() => _NotificationViewState(scrollController);
}

class _NotificationViewState extends GestureDetectorState<NotificationView> with NotificationViewUIContract {
  _NotificationViewState(ScrollController mainScrollController) : super(mainScrollController);

  @override
  Widget buildChild(BuildContext context) {
    return _build(this);
  }

  @override
  void initState() {
    super.initState();
    onInitState();
  }

  @override
  ScrollController get _childScrollController => childScrollController;

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }
}
