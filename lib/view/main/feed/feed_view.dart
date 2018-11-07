library feed_view;

import 'package:clone_facebook_ui/tiny_base/base_state.dart';
import 'package:clone_facebook_ui/view/main/main_view.dart';
import 'package:flutter/material.dart';

part 'feed_widgets.dart';

class FeedView extends StatefulWidget {
  FeedView(Key key) : super(key: key);

  @override
  FeedViewState createState() => FeedViewState();
}

class FeedViewState extends BaseState<FeedView> with FeedViewUIContract, AutomaticKeepAliveClientMixin {
  @override
  BuildContext get _context => context;

  @override
  ScrollController get _scrollController => getAncestorState<MainViewState>().scrollController;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _build(this);
  }

  @override
  bool get wantKeepAlive => true;
}
