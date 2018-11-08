library menu_view;

import 'package:clone_facebook_ui/tiny_base/base_state.dart';
import 'package:clone_facebook_ui/tiny_base/gesture_detector_state.dart';
import 'package:flutter/material.dart';

part 'menu_widgets.dart';

class MenuView extends StatefulWidget {
  final ScrollController scrollController;

  MenuView(Key key, this.scrollController) : super(key: key);

  @override
  _MenuViewState createState() => _MenuViewState(scrollController);
}

class _MenuViewState extends GestureDetectorState<MenuView> with MenuViewUIContract {
  _MenuViewState(ScrollController mainScrollController) : super(mainScrollController);

  @override
  ScrollController get _childScrollController => childScrollController;

  @override
  Widget buildChild(BuildContext context) {
    return _build(this);
  }
}
