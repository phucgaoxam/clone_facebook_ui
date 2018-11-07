part of base;

abstract class NavigableState<T extends StatefulWidget> extends BaseState<T>
    with AutomaticKeepAliveClientMixin<T> {
  List<CanPopState> canPopStateList = [];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _initRootWidgetPage(context);
  }

  Widget buildBody(BuildContext context);

  AppBar buildAppBar(BuildContext context) => null;

  Key pageStorageKey() => null;

  void registerCanPopState(CanPopState canPopState) {
    canPopStateList.add(canPopState);
  }

  void unRegisterCanPopState(CanPopState canPopState) {
    canPopStateList.remove(canPopState);
  }

  void pop() {
    if (shouldPop() && Navigator.canPop(context)) Navigator.pop(context);
  }

  bool shouldPop() {
    for (var canPopSate in canPopStateList) {
      if (canPopSate.canPop()) {
        return false;
      }
    }
    return true;
  }

  Widget _initRootWidgetPage(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context),
        key: pageStorageKey(),
        body: Navigator(
          onGenerateRoute: (routeSettings) {
            return _initRootPage(routeSettings);
          },
        ),
      ),
      onWillPop: _onBackPressed,
    );
  }

  Future<bool> _onBackPressed() async {
    return shouldPop();
  }

  PageRouteBuilder _initRootPage(RouteSettings routeSettings) {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
        return buildBody(context);
      },
      transitionDuration: defaultDuration,
      transitionsBuilder: defaultRootPageTransition(animatedVertically()),
    );
  }
}

abstract class CanPopState<T extends StatefulWidget> extends BaseState<T> {
  NavigableState _ancestorNavigationState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _ancestorNavigationState =
          context.ancestorStateOfType(const TypeMatcher<NavigableState>());
      _ancestorNavigationState?.registerCanPopState(this);
    });
  }

  @override
  void dispose() {
    _ancestorNavigationState?.unRegisterCanPopState(this);
    super.dispose();
  }

  bool canPop() {
    return Navigator.canPop(context) && Navigator.pop(context);
  }
}