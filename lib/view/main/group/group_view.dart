library group_view;

import 'dart:async';

import 'package:clone_facebook_ui/tiny_base/base_state.dart';
import 'package:clone_facebook_ui/view/main/main_view.dart';
import 'package:flutter/material.dart';

part 'group_widgets.dart';

class GroupView extends StatefulWidget {
  GroupView(Key key) : super(key: key);

  @override
  _GroupViewState createState() => _GroupViewState();
}

class _GroupViewState extends BaseState<GroupView> with GroupViewUIContract, AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    onInitState();
  }

  @override
  ScrollController get _mainScrollController => getAncestorState<MainViewState>().scrollController;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _build(this);
  }

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
}
