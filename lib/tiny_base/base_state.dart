library base;

import 'package:flutter/material.dart';

import 'navigation_helper.dart';

part 'base_contract.dart';

part 'base_ui_contract.dart';

part 'divider.dart';

part 'navigable_state.dart';

part 'no_scale_text.dart';

part 'package:clone_facebook_ui/utils/size_util.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> with NavigationHelper implements BaseContract {
  T getAncestorState<T>() => context.ancestorStateOfType(TypeMatcher<T>()) as T;

  bool animatedVertically() => true;
}
