library clip_view;

import 'package:clone_facebook_ui/tiny_base/base_state.dart';
import 'package:clone_facebook_ui/view/main/main_view.dart';
import 'package:flutter/material.dart';
import 'dart:async';

part 'clip_widgets.dart';

class ClipView extends StatefulWidget {
  ClipView(Key key) : super(key: key);
  @override
  _ClipViewState createState() => _ClipViewState();
}

class _ClipViewState extends BaseState<ClipView> with ClipViewUIContract, AutomaticKeepAliveClientMixin {

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
  ScrollController get _mainScrollController => getAncestorState<MainViewState>().scrollController;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _build(this);
  }

  @override
  void onSeeAll() {
    // TODO: implement onSeeAll
  }

  @override
  bool get wantKeepAlive => true;
}
