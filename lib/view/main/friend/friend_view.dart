library friend_view;

import 'dart:async';

import 'package:clone_facebook_ui/tiny_base/base_state.dart';
import 'package:clone_facebook_ui/view/main/main_view.dart';
import 'package:flutter/material.dart';

part 'friend_widgets.dart';

class FriendView extends StatefulWidget {
  FriendView(Key key) : super(key: key);
  @override
  _FriendViewState createState() => _FriendViewState();
}

class _FriendViewState extends BaseState<FriendView> with FriendViewUIContract, AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    onInitState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _build(this);
  }

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }

  @override
  ScrollController get _mainScrollController => getAncestorState<MainViewState>().scrollController;

  @override
  bool get wantKeepAlive => true;
}
