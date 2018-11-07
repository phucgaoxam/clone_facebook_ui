part of clip_view;

abstract class ClipViewUIContract {
  ScrollController _mainScrollController;

  StreamController<List<int>> _channelsStreamController = StreamController.broadcast();

  StreamController<List<int>> _videoStreamController = StreamController.broadcast();

  List<int> _channels = [];

  List<int> _videos = [];

  void onSeeAll();

  void onInitState() {
    for (int i = 0; i < 30; i++) {
      _channels.add(i);
      _videos.add(i);
    }
  }

  void onDispose() {
    _channelsStreamController.close();
    _videoStreamController.close();
  }
}

final leftPadding = SizeUtil.instance.getSize(30);

final topPadding = SizeUtil.instance.getSize(20, basedOnSmaller: false);

final notificationSize = SizeUtil.instance.getSize(200);

final channelItemHeight = SizeUtil.instance.getSize(220, basedOnSmaller: false);

double availableWidth;

Widget _build(ClipViewUIContract ui) {
  return SafeArea(
    child: LayoutBuilder(
      builder: (context, constraint) {
        if (availableWidth == null) availableWidth = constraint.maxWidth;
        return Container(
          padding: EdgeInsets.only(top: topPadding),
          height: constraint.maxHeight,
          width: constraint.maxWidth,
          child: CustomScrollView(
            slivers: <Widget>[
              _buildWatchListTitle(ui),
              _buildChannels(ui),
              _buildDivider(),
              _buildTopVideosTitle(),
              _buildTopVideosList(ui),
            ],
          ),
        );
      },
    ),
  );
}

Widget _buildDivider() {
  return SliverToBoxAdapter(
    child: Padding(
      padding: EdgeInsets.only(left: leftPadding, top: topPadding),
      child: HorizontalDivider(),
    ),
  );
}

Widget _buildTopVideosTitle() {
  return SliverToBoxAdapter(
    child: Padding(
      padding: EdgeInsets.only(left: leftPadding, top: topPadding),
      child: NoScaleText(
        'Top videos for you',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: SizeUtil.instance.getSize(50),
        ),
      ),
    ),
  );
}

Widget _buildWatchListTitle(ClipViewUIContract ui) {
  return SliverToBoxAdapter(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: leftPadding),
      child: Row(
        children: <Widget>[
          Expanded(child: NoScaleText('Watchlist')),
          InkWell(
            onTap: ui.onSeeAll,
            child: NoScaleText(
              'See all',
              style: TextStyle(color: Colors.blue),
            ),
          )
        ],
      ),
    ),
  );
}

Widget _buildChannels(ClipViewUIContract ui) {
  return SliverToBoxAdapter(
    child: Container(
      padding: EdgeInsets.only(top: SizeUtil.instance.getSize(10, basedOnSmaller: false), right: leftPadding),
      width: availableWidth,
      height: SizeUtil.instance.getSize(255, basedOnSmaller: false),
      child: StreamBuilder<List<int>>(
        stream: ui._channelsStreamController.stream,
        initialData: ui._channels,
        builder: (context, asyncSnapshot) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            controller: ui._mainScrollController,
            itemCount: asyncSnapshot.data.length,
            itemBuilder: (context, index) {
              return _buildChannelItem(index);
            },
          );
        },
      ),
    ),
  );
}

Widget _buildChannelItem(int index) {
  return Container(
    alignment: Alignment.bottomCenter,
    padding: EdgeInsets.symmetric(horizontal: SizeUtil.instance.getSize(38)),
    child: Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Container(
          width: SizeUtil.instance.getSize(300),
          height: channelItemHeight,
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(SizeUtil.instance.getSize(30)), color: Colors.red),
        ),
        Positioned(
          right: -SizeUtil.instance.getSize(40),
          top: -SizeUtil.instance.getSize(40),
          child: Container(
            width: SizeUtil.instance.getSize(80),
            height: SizeUtil.instance.getSize(80),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blue,
              border: Border.all(width: SizeUtil.instance.getSize(8), color: Colors.white),
              shape: BoxShape.circle,
            ),
            child: NoScaleText(
              '9+',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildTopVideosList(ClipViewUIContract ui) {
  return SliverToBoxAdapter(
    child: Container(
      child: StreamBuilder<List<int>>(
        initialData: ui._videos,
        stream: ui._videoStreamController.stream,
        builder: (context, asyncSnapshot) {
          return ListView.builder(
            shrinkWrap: true,
            controller: ScrollController(),
            itemCount: asyncSnapshot.data.length,
            itemBuilder: (context, index) {
              return _buildVideoItem(index);
            },
          );
        },
      ),
    ),
  );
}

Widget _buildVideoItem(int index) {
  return ListTile(
    title: NoScaleText('$index'),
  );
}
