library feed_view;

import 'package:clone_facebook_ui/tiny_base/base_state.dart';
import 'package:clone_facebook_ui/tiny_base/gesture_detector_state.dart';
import 'package:clone_facebook_ui/view/create_post/create_post_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'feed_widgets.dart';

class FeedView extends StatefulWidget {
  final ScrollController scrollController;

  FeedView(Key key, this.scrollController) : super(key: key);

  @override
  FeedViewState createState() => FeedViewState(scrollController);
}

class FeedViewState extends GestureDetectorState<FeedView> with FeedViewUIContract {
  FeedViewState(ScrollController mainScrollController) : super(mainScrollController);

  @override
  BuildContext get _context => context;

  @override
  ScrollController get _childScrollController => childScrollController;

  @override
  Widget buildChild(BuildContext context) {
    return _build(this);
  }

  @override
  void onPostStatus() {
    Navigator.of(context).push(CupertinoPageRoute(builder: (context) => CreatePostView()));
  }
}
