library group_view;

import 'dart:async';

import 'package:clone_facebook_ui/tiny_base/base_state.dart';
import 'package:clone_facebook_ui/tiny_base/gesture_detector_state.dart';
import 'package:flutter/material.dart';

part 'group_widgets.dart';

class GroupView extends StatefulWidget {
  final ScrollController scrollController;

  GroupView(Key key, this.scrollController) : super(key: key);

  @override
  _GroupViewState createState() => _GroupViewState(scrollController);
}

class _GroupViewState extends GestureDetectorState<GroupView> with GroupViewUIContract {
  _GroupViewState(ScrollController mainScrollController) : super(mainScrollController);

  @override
  void initState() {
    super.initState();
    onInitState();
  }

  @override
  ScrollController get _childScrollController => childScrollController;

  @override
  void onCreateGroup() {
    // TODO: implement onCreateGroup
  }

  @override
  void onEditGroup() {
    // TODO: implement onEditGroup
  }

  @override
  void onSeeAll() {
    // TODO: implement onSeeAll
  }

  @override
  void onSeeMore() {
    _yourGroups
      ..add(_yourGroups.length)
      ..add(_yourGroups.length)
      ..add(_yourGroups.length)
      ..add(_yourGroups.length)
      ..add(_yourGroups.length)
      ..add(_yourGroups.length)
      ..add(_yourGroups.length);

    _seeMoreStreamController.sink.add(false);
    _yourGroupsStreamController.sink.add(_yourGroups);
  }

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget buildChild(BuildContext context) {
    return _build(this);
  }
}
