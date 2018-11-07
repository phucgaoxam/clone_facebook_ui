library menu_view;

import 'package:clone_facebook_ui/tiny_base/base_state.dart';
import 'package:flutter/material.dart';

part 'menu_widgets.dart';

class MenuView extends StatefulWidget {
  MenuView(Key key) : super(key: key);
  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends BaseState<MenuView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container();
  }

  @override
  bool get wantKeepAlive => true;
}
