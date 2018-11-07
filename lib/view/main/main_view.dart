library main_view;

import 'package:clone_facebook_ui/tiny_base/base_state.dart';
import 'package:flutter/material.dart';
import 'package:clone_facebook_ui/resources/app_colors.dart';
import 'notification/notification_view.dart';
import 'package:clone_facebook_ui/view/main/feed/feed_view.dart';
import 'menu/menu_view.dart';
import 'group/group_view.dart';
import 'feed/feed_view.dart';
import 'friend/friend_view.dart';
import 'clip/clip_view.dart';

part 'main_widgets.dart';

class MainView extends StatefulWidget {
  @override
  MainViewState createState() => MainViewState();
}

class MainViewState extends BaseState<MainView> with MainViewUIContract, SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return _build(this);
  }

  @override
  BuildContext get _context => context;
}
