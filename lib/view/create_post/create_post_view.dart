library create_post_view;

import 'dart:async';

import 'package:clone_facebook_ui/tiny_base/base_state.dart';
import 'package:flutter/material.dart';
import 'package:clone_facebook_ui/resources/app_colors.dart';
import 'package:flutter/gestures.dart';

part 'create_post_widget.dart';

part 'widgets/bottom_content_animation.dart';

part 'widgets/bottom_content_widgets.dart';

part 'widgets/input_content_widgets.dart';

class CreatePostView extends StatefulWidget {
  @override
  _CreatePostViewState createState() => _CreatePostViewState();
}

class _CreatePostViewState extends BaseState<CreatePostView> with CreatePostViewUIContract {
  @override
  Widget build(BuildContext context) {
    return CreatePostViewBuilder(this).build();
  }

  @override
  void onShareStatus() {
    // TODO: implement onShareStatus
  }
}
