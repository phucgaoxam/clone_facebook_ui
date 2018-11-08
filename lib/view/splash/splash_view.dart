library splash_view;

import 'dart:async';

import 'package:clone_facebook_ui/resources/app_colors.dart';
import 'package:clone_facebook_ui/tiny_base/base_state.dart';
import 'package:clone_facebook_ui/view/main/main_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

part 'splash_widgets.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends BaseState<SplashView> with SplashViewUIContract, SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _loadingController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1400), lowerBound: 0.0, upperBound: 3.0);
    WidgetsBinding.instance.addPostFrameCallback((duration) async {
      await Future.delayed(Duration(milliseconds: 1200), () {
        _loadingController.repeat();
        _loadingStreamController.sink.add(true);
      });

      Future.delayed(Duration(milliseconds: 400), () {
        _onNavigateToMainScreen();
      });
    });
  }

  void _onNavigateToMainScreen() {
    Navigator.of(context).push(CupertinoPageRoute(builder: (context) => MainView()));
  }

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _build(this);
  }
}
