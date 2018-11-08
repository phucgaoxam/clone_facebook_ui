library friend_view;

import 'dart:async';

import 'package:clone_facebook_ui/tiny_base/base_state.dart';
import 'package:clone_facebook_ui/tiny_base/gesture_detector_state.dart';
import 'package:flutter/material.dart';

part 'friend_widgets.dart';

class FriendView extends StatefulWidget {
  final ScrollController scrollController;

  FriendView(Key key, this.scrollController) : super(key: key);

  @override
  _FriendViewState createState() => _FriendViewState(scrollController);
}

class _FriendViewState extends GestureDetectorState<FriendView> with FriendViewUIContract {
  _FriendViewState(ScrollController mainScrollController) : super(mainScrollController);

  @override
  void initState() {
    super.initState();
    onInitState();
  }

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }

  @override
  ScrollController get _childScrollController => childScrollController;

  @override
  Widget buildChild(BuildContext context) {
    return _build(this);
  }
}
