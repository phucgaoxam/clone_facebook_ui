library clip_view;

import 'package:clone_facebook_ui/tiny_base/base_state.dart';
import 'package:clone_facebook_ui/tiny_base/gesture_detector_state.dart';
import 'package:clone_facebook_ui/view/main/main_view.dart';
import 'package:flutter/material.dart';
import 'dart:async';

part 'clip_widgets.dart';

class ClipView extends StatefulWidget {
  final ScrollController scrollController;
  ClipView(Key key, this.scrollController) : super(key: key);
  @override
  _ClipViewState createState() => _ClipViewState(scrollController);
}

class _ClipViewState extends GestureDetectorState<ClipView> with ClipViewUIContract {
  _ClipViewState(ScrollController mainScrollController) : super(mainScrollController);


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
  void onSeeAll() {
    // TODO: implement onSeeAll
  }

  @override
  Widget buildChild(BuildContext context) {
    return _build(this);
  }
}
