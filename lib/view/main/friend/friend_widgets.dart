part of friend_view;

class FriendViewUIContract {
  ScrollController _childScrollController;

  List<int> _friendRequests = [];

  StreamController<List<int>> _friendRequestsStreamController = StreamController.broadcast();

  void onInitState() {
    for (int i = 0; i < 50; i++) {
      _friendRequests.add(i);
    }
  }

  void onDispose() {
    _friendRequestsStreamController.close();
  }
}

final leftPadding = SizeUtil.instance.getSize(30);

Widget _build(FriendViewUIContract ui) {
  return SafeArea(
    child: LayoutBuilder(
      builder: (context, constraint) {
        return CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          controller: ui._childScrollController,
          slivers: <Widget>[
            _buildFriendRequestTitle(),
            _buildFriendRequestList(ui),
          ],
        );
      },
    ),
  );
}

Widget _buildFriendRequestTitle() {
  return SliverToBoxAdapter(
    child: Container(
      padding: EdgeInsets.only(left: leftPadding, top: SizeUtil.instance.getSize(10, basedOnSmaller: false)),
      child: Row(
        children: <Widget>[
          NoScaleText('Friend requests'),
          Container(
            margin: EdgeInsets.only(left: SizeUtil.instance.getSize(10)),
            width: SizeUtil.instance.getSize(80),
            height: SizeUtil.instance.getSize(80),
            alignment: Alignment.center,
            child: NoScaleText(
              '30',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildFriendRequestList(FriendViewUIContract ui) {
  return SliverToBoxAdapter(
    child: StreamBuilder<List<int>>(
      stream: ui._friendRequestsStreamController.stream,
      initialData: ui._friendRequests,
      builder: (context, asyncSnapshot) {
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: asyncSnapshot.data.length,
          itemBuilder: (context, index) {
            return _buildFriendRequestItem(index);
          },
        );
      },
    ),
  );
}

Widget _buildFriendRequestItem(int index) {
  return ListTile(
    title: Text('$index'),
  );
}
