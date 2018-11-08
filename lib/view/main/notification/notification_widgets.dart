part of notification_view;

mixin NotificationViewUIContract {
  List<int> _newNotificationList = [];

  StreamController<List<int>> _newNotificationStreamController = StreamController.broadcast();

  List<int> _oldNotificationList = [];

  StreamController<List<int>> _oldNotificationStreamController = StreamController.broadcast();

  ScrollController _childScrollController;

  onInitState() {
    for (int i = 0; i < 10; i++) {
      _newNotificationList.add(i);
    }

    for (int i = 0; i < 50; i++) {
      _oldNotificationList.add(i);
    }
  }

  void onDispose() {
    _newNotificationStreamController.close();
    _oldNotificationStreamController.close();
  }
}

Widget _build(NotificationViewUIContract ui) {
  return SafeArea(
    child: LayoutBuilder(
      builder: (context, constraint) {
        return CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          controller: ui._childScrollController,
          slivers: <Widget>[
            _buildTitle('New'),
            _buildList(ui._newNotificationStreamController, ui._newNotificationList),
            _buildDivider(),
            _buildTitle('Earlier'),
            _buildList(ui._oldNotificationStreamController, ui._oldNotificationList),
          ],
        );
      },
    ),
  );
}

Widget _buildTitle(String text) {
  return SliverToBoxAdapter(
    child: NoScaleText(
      text,
      style: TextStyle(
        fontSize: SizeUtil.instance.getSize(40),
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _buildDivider() {
  return SliverToBoxAdapter(
    child: Container(
      height: SizeUtil.instance.getSize(10, basedOnSmaller: false),
      color: Colors.black12,
    ),
  );
}

Widget _buildList(StreamController streamController, List<int> list) {
  return SliverToBoxAdapter(
    child: StreamBuilder<List<int>>(
      initialData: list,
      stream: streamController.stream,
      builder: (context, asyncSnapshot) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: asyncSnapshot.data.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('$index'),
            );
          },
        );
      },
    ),
  );
}
