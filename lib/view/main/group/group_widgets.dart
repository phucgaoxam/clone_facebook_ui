part of group_view;

abstract class GroupViewUIContract {
  StreamController<bool> _seeMoreStreamController = StreamController.broadcast();

  StreamController<List<int>> _yourGroupsStreamController = StreamController.broadcast();

  StreamController<List<int>> _yourLatestUpdatesStreamController = StreamController.broadcast();

  List<int> _yourGroups = [];

  List<int> _latestUpdates = [];

  ScrollController _mainScrollController;

  void onEditGroup();

  void onCreateGroup();

  void onSeeMore();

  void onSeeAll();

  void onInitState() {
    _yourGroups..add(0)..add(1)..add(2);
    for (int i = 0; i < 50; i++) {
      _latestUpdates.add(i);
    }
  }

  void onDispose() {
    _seeMoreStreamController.close();
    _yourLatestUpdatesStreamController.close();
    _yourGroupsStreamController.close();
  }
}

final leftPadding = SizeUtil.instance.getSize(30);

double availableHeight;

Widget _build(GroupViewUIContract ui) {
  return SafeArea(
    child: LayoutBuilder(
      builder: (context, constraint) {
        if (availableHeight == null) {
          availableHeight = constraint.maxHeight;
        }
        return Container(
          padding: EdgeInsets.only(top: SizeUtil.instance.getSize(8, basedOnSmaller: false)),
          child: CustomScrollView(
            slivers: <Widget>[
              _buildTitle(ui),
              _buildGroups(ui),
              _buildSeeMore(ui),
              //_buildYourGroupsContent(ui),
              _buildSizedBox(ui),
              _buildLatestUpdateContent(ui),
            ],
          ),
        );
      },
    ),
  );
}

Widget _buildSeeMore(GroupViewUIContract ui) {
  return SliverToBoxAdapter(
    child: StreamBuilder<bool>(
      stream: ui._seeMoreStreamController.stream,
      initialData: true,
      builder: (context, asyncSnapshot) {
        return InkWell(
          onTap: asyncSnapshot.data ? ui.onSeeMore : ui.onSeeAll,
          child: Center(
            child: asyncSnapshot.data
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      NoScaleText('See more'),
                      Icon(Icons.keyboard_arrow_down),
                    ],
                  )
                : NoScaleText('See all'),
          ),
        );
      },
    ),
  );
}

Widget _buildTitle(GroupViewUIContract ui) {
  return SliverToBoxAdapter(
    child: Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: leftPadding),
            child: NoScaleText(
              'Your groups',
              style: TextStyle(
                color: Colors.black,
                fontSize: SizeUtil.instance.getSize(50),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        _buildActionText('Edit', ui.onEditGroup),
        _buildActionText('Create', ui.onCreateGroup),
      ],
    ),
  );
}

Widget _buildActionText(String text, VoidCallback action) {
  return InkWell(
    onTap: action,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeUtil.instance.getSize(20)),
      child: NoScaleText(
        text,
        style: TextStyle(color: Colors.blue),
      ),
    ),
  );
}

Widget _buildGroups(GroupViewUIContract ui) {
  return SliverToBoxAdapter(
    child: StreamBuilder<List<int>>(
      initialData: ui._yourGroups,
      stream: ui._yourGroupsStreamController.stream,
      builder: (context, asyncSnapshot) {
        return ListView.builder(
          shrinkWrap: true,
          controller: ScrollController(),
          itemCount: ui._yourGroups.length,
          itemBuilder: (context, index) => _buildGroupItem(index),
        );
      },
    ),
  );
}

Widget _buildGroupItem(int index) {
  return ListTile(
    title: NoScaleText('$index'),
  );
}

Widget _buildLatestUpdateContent(GroupViewUIContract ui) {
  return SliverToBoxAdapter(
    child: StreamBuilder<List<int>>(
      stream: ui._yourLatestUpdatesStreamController.stream,
      initialData: ui._latestUpdates,
      builder: (context, asyncSnapshot) {
        return ListView.builder(
          controller:ScrollController(),
          shrinkWrap: true,
          itemCount: asyncSnapshot.data.length,
          itemBuilder: (context, index) {
            return _buildPostItem(index);
          },
        );
      },
    ),
  );
}

Widget _buildPostItem(int index) {
  return ListTile(
    title: NoScaleText('Post at index $index'),
  );
}

Widget _buildSizedBox(GroupViewUIContract ui) {
  return SliverToBoxAdapter(
    child: Container(
      width: double.infinity,
      color: Colors.black12,
      alignment: Alignment.centerLeft,
      height: SizeUtil.instance.getSize(60, basedOnSmaller: false),
      child: Padding(
        padding: EdgeInsets.only(left: leftPadding),
        child: NoScaleText(
          'Lastest Update',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
        ),
      ),
    ),
  );
}
