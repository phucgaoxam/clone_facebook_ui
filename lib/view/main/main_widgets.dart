part of main_view;

abstract class MainViewUIContract {
  ScrollController mainScrollController = ScrollController();
  ScrollController childScrollController = ScrollController();
  PageController _tabController;
  BuildContext _context;

  Drag _tabDrag;
  ScrollHoldController _tabHold;

  int _currentPage = 0;

  Map<Type, GestureRecognizerFactory> gestures = <Type, GestureRecognizerFactory>{};

  void onPageChanged(int page);
}

final tabBarHeight = SizeUtil.instance.getSize(80, basedOnSmaller: false);

final searchBoxPadding = SizeUtil.instance.getSize(30);

Widget _build(MainViewUIContract uiContract) {
  return SafeArea(
    child: Scaffold(
      body: LayoutBuilder(
        builder: (context, constraint) {
          return Container(
            height: constraint.maxHeight,
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (notification) {
                notification.disallowGlow();
              },
              child: CustomScrollView(
                physics: NeverScrollableScrollPhysics(),
                controller: uiContract.mainScrollController,
                slivers: <Widget>[
                  SliverToBoxAdapter(child: _buildSearchBox(uiContract)),
                  SliverToBoxAdapter(child: _buildTabBar(uiContract)),
                  SliverToBoxAdapter(child: HorizontalDivider()),
                  SliverToBoxAdapter(child: _buildTabBody(uiContract, constraint)),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}

Widget _buildTabBar(MainViewUIContract uiContract) {
  return Container(
    height: tabBarHeight,
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _generateTabBar(uiContract),
    ),
  );
}

Widget _buildTabBody(MainViewUIContract uiContract, BoxConstraints constraint) {
  return Container(
    height: constraint.maxHeight - tabBarHeight,
    child: PageView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return _generateTabBody(uiContract)[index];
      },
      onPageChanged: (page) {
        uiContract.onPageChanged(page);
      },
      physics: NeverScrollableScrollPhysics(),
      controller: uiContract._tabController,
    ),
  );
}

List<Widget> _generateTabBody(MainViewUIContract ui) {
  final List<Widget> tabBodies = [];

  PageStorageKey<String> s1 = PageStorageKey('tab 1');
  PageStorageKey<String> s2 = PageStorageKey('tab 2');
  PageStorageKey<String> s3 = PageStorageKey('tab 3');
  PageStorageKey<String> s4 = PageStorageKey('tab 4');
  PageStorageKey<String> s5 = PageStorageKey('tab 5');
  PageStorageKey<String> s6 = PageStorageKey('tab 6');

  tabBodies
    ..add(FeedView(s1, ui.mainScrollController))
    ..add(GroupView(s2, ui.mainScrollController))
    ..add(FriendView(s3, ui.mainScrollController))
    ..add(ClipView(s4, ui.mainScrollController))
    ..add(NotificationView(s5, ui.mainScrollController))
    ..add(MenuView(s6, ui.mainScrollController));

  return tabBodies;
}

List<Widget> _generateTabBar(MainViewUIContract uiContract) {
  final List<Widget> tabs = [];

  tabs
    ..add(_buildTabIcon(uiContract, Icons.rss_feed, 0))
    ..add(_buildTabIcon(uiContract, Icons.cloud, 1))
    ..add(_buildTabIcon(uiContract, Icons.people, 2))
    ..add(_buildTabIcon(uiContract, Icons.live_tv, 3))
    ..add(_buildTabIcon(uiContract, Icons.notifications, 4))
    ..add(_buildTabIcon(uiContract, Icons.menu, 5));

  return tabs;
}

Widget _buildTabIcon(MainViewUIContract uiContract, IconData iconData, int index) {
  return Expanded(
    child: Container(
      height: double.infinity,
      child: InkWell(
        onTap: () =>
            uiContract._tabController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeIn),
        child: Icon(
          iconData,
          color: Colors.black,
          size: SizeUtil.instance.getSize(80),
        ),
      ),
    ),
  );
}

Widget _buildSearchBox(MainViewUIContract uiContract) {
  return Container(
    height: tabBarHeight,
    color: AppColors.primaryColor,
    alignment: Alignment.center,
    child: Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: searchBoxPadding),
          child: Icon(
            Icons.photo_camera,
            color: Colors.white,
          ),
        ),
        Expanded(
          child: Theme(
            data: ThemeData(hintColor: Colors.white),
            child: Container(
              alignment: Alignment.centerLeft,
              child: TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: searchBoxPadding),
          child: Icon(
            Icons.message,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}
