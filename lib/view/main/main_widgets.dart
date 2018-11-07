part of main_view;

mixin MainViewUIContract {
  ScrollController scrollController = ScrollController();
  TabController _tabController;
  BuildContext _context;
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
              child:
                  /*NestedScrollView(
                controller: uiContract.scrollController,
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      backgroundColor: AppColors.primaryColor,
                      forceElevated: innerBoxIsScrolled,
                      automaticallyImplyLeading: false,
                      bottom: _buildSearchBox(uiContract),
                      snap: true,
                      floating: true,
                    ),
                  ];
                },
                body:*/
                  Container(
                height: constraint.maxHeight - tabBarHeight,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _buildTabBar(uiContract),
                    _buildTabBody(uiContract, constraint),
                  ],
                ),
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
    color: Colors.white,
    height: SizeUtil.instance.getSize(80, basedOnSmaller: false),
    child: Column(
      children: <Widget>[
        Expanded(
          child: TabBar(
            indicatorColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.label,
            controller: uiContract._tabController,
            tabs: _generateTabBar(),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: SizeUtil.instance.getSize(8, basedOnSmaller: false)),
          child: HorizontalDivider(),
        ),
      ],
    ),
  );
}

Widget _buildTabBody(MainViewUIContract uiContract, BoxConstraints constraint) {
  return Container(
    color: Colors.white,
    height: constraint.maxHeight - tabBarHeight,
    child: TabBarView(
      controller: uiContract._tabController,
      children: _generateTabBody(),
    ),
  );
}

List<Widget> _generateTabBody() {
  final List<Widget> tabBodies = [];

  PageStorageKey<String> s1 = PageStorageKey('tab 1');
  PageStorageKey<String> s2 = PageStorageKey('tab 2');
  PageStorageKey<String> s3 = PageStorageKey('tab 3');
  PageStorageKey<String> s4 = PageStorageKey('tab 4');
  PageStorageKey<String> s5 = PageStorageKey('tab 5');
  PageStorageKey<String> s6 = PageStorageKey('tab 6');

  tabBodies
    ..add(FeedView(s1))
    ..add(GroupView(s2))
    ..add(FriendView(s3))
    ..add(ClipView(s4))
    ..add(NotificationView(s5))
    ..add(MenuView(s6));

  return tabBodies;
}

List<Widget> _generateTabBar() {
  final List<Widget> tabs = [];

  tabs
    ..add(_buildTabIcon(Icons.rss_feed))
    ..add(_buildTabIcon(Icons.cloud))
    ..add(_buildTabIcon(Icons.people))
    ..add(_buildTabIcon(Icons.live_tv))
    ..add(_buildTabIcon(Icons.notifications))
    ..add(_buildTabIcon(Icons.menu));

  return tabs;
}

Widget _buildTabIcon(IconData iconData) {
  return Icon(
    iconData,
    color: Colors.black,
    size: SizeUtil.instance.getSize(80),
  );
}

PreferredSize _buildSearchBox(MainViewUIContract uiContract) {
  return PreferredSize(
    preferredSize: Size(double.infinity, 0.0),
    child: Container(
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
    ),
  );
}
