import 'package:flutter/material.dart';
import 'dart:async';

class NavigationHelper {
  Future<T> push<T>(BuildContext context, Widget widget,
                    {bool vertical: true,
                      bool shouldAnimated: true,
                      Duration duration: defaultDuration}) {
    return Navigator.push(
      context,
      getPageRouteBuilder(widget, vertical, shouldAnimated, duration),
    );
  }

  Future<T> pushReplacement<T>(BuildContext context, Widget widget,
                               {bool vertical: true,
                                 bool shouldAnimated: true,
                                 Duration duration: defaultDuration}) {
    return Navigator.pushReplacement(
      context,
      getPageRouteBuilder(widget, vertical, shouldAnimated, duration),
    );
  }

  Future<T> pushAndRemoveUntil<T>(
      BuildContext context, Widget widget, RoutePredicate predicate,
      {bool vertical: true,
        bool shouldAnimated: true,
        Duration duration: defaultDuration}) {
    return Navigator.pushAndRemoveUntil(
        context,
        getPageRouteBuilder(widget, vertical, shouldAnimated, duration),
        predicate);
  }

  PageRouteBuilder<T> getPageRouteBuilder<T>(
      Widget widget, bool vertical, bool shouldAnimated, Duration duration) {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation animation,
                    Animation secondaryAnimation) {
        return widget;
      },
      transitionDuration: duration,
      transitionsBuilder: shouldAnimated
          ? _defaultTransitionsBuilder(vertical: vertical)
          : _noneTransitionsBuilder(),
    );
  }

  RouteTransitionsBuilder _defaultTransitionsBuilder(
      {bool vertical: true}) {
    return (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
      Tween<Offset> tweenIn =
      vertical ? _slideBottomToTopInTween : _slideRightToLeftInTween;

      Animation<Offset> slideInAnimation = tweenIn.animate(CurvedAnimation(
        parent: animation,
        curve: Curves.fastOutSlowIn,
      ));

      Tween<Offset> tweenOut =
      vertical ? _slideBottomToTopOutTween : _slideRightToLeftOutTween;

      Animation<Offset> slideOutAnimation = tweenOut.animate(CurvedAnimation(
        parent: secondaryAnimation,
        curve: Curves.fastOutSlowIn,
      ));

      final TextDirection textDirection = Directionality.of(context);
      return SlideTransition(
        position: slideOutAnimation,
        textDirection: textDirection,
        child: SlideTransition(
          position: slideInAnimation,
          textDirection: textDirection,
          child: child,
        ),
      );
    };
  }

  RouteTransitionsBuilder _noneTransitionsBuilder() {
    return (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
      Animation<double> slideInAnimation = _noneTween.animate(CurvedAnimation(
        parent: animation,
        curve: Curves.fastOutSlowIn,
      ));

      Animation<double> slideOutAnimation = _noneTween.animate(CurvedAnimation(
        parent: secondaryAnimation,
        curve: Curves.fastOutSlowIn,
      ));

      return FadeTransition(
        opacity: slideOutAnimation,
        child: FadeTransition(
          opacity: slideInAnimation,
          child: child,
        ),
      );
    };
  }

  RouteTransitionsBuilder defaultRootPageTransition(bool animatedVertically) {
    return (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
      Tween<Offset> tweenOut = animatedVertically
          ? _slideBottomToTopOutTween
          : _slideRightToLeftOutTween;

      Animation<Offset> slideOutAnimation = tweenOut.animate(CurvedAnimation(
        parent: secondaryAnimation,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      ));

      final TextDirection textDirection = Directionality.of(context);
      return new SlideTransition(
        position: slideOutAnimation,
        textDirection: textDirection,
        child: child,
      );
    };
  }
}

const Duration defaultDuration = const Duration(milliseconds: 300);

final Tween<Offset> _slideBottomToTopInTween = new Tween<Offset>(
  begin: const Offset(0.0, 1.0),
  end: Offset.zero,
);

final Tween<Offset> _slideBottomToTopOutTween = new Tween<Offset>(
  begin: Offset.zero,
  end: const Offset(0.0, -1.0 / 6.0),
);

final Tween<Offset> _slideRightToLeftInTween = new Tween<Offset>(
  begin: const Offset(1.0, 0.0),
  end: Offset.zero,
);

final Tween<Offset> _slideRightToLeftOutTween = new Tween<Offset>(
  begin: Offset.zero,
  end: const Offset(-1.0 / 6.0, 0.0),
);

final Tween<double> _noneTween = new Tween<double>(
  begin: 1.0,
  end: 1.0,
);
