part of feed_view;

mixin FeedViewUIContract {
  BuildContext _context;

  ScrollController _childScrollController;
}

Widget _build(FeedViewUIContract ui) {
  return SafeArea(
    child: LayoutBuilder(
      builder: (context, constraint) {
        return Container(
          height: constraint.maxHeight,
          child: CustomScrollView(
            controller: ui._childScrollController,
            physics: NeverScrollableScrollPhysics(),
            slivers: <Widget>[
              _buildStatus(),
              SliverToBoxAdapter(
                child: ListView.builder(
                  controller: ScrollController(),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 20,
                  itemBuilder: (context, index) => ListTile(
                        title: NoScaleText('$index'),
                      ),
                ),
              )
            ],
          ),
        );
      },
    ),
  );
}

Widget _buildStatus() {
  return SliverToBoxAdapter(
    child: Container(
      height: SizeUtil.instance.getSize(100, basedOnSmaller: false),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: SizeUtil.instance.getSize(24), right: SizeUtil.instance.getSize(4)),
                  child: CircleAvatar(),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: SizeUtil.instance.getSize(24), right: SizeUtil.instance.getSize(30)),
                    alignment: Alignment.center,
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: SizeUtil.instance.getSize(18, basedOnSmaller: false),
                            horizontal: SizeUtil.instance.getSize(40)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(80.0), gapPadding: 0.0),
                        hintText: 'What\'s on your mind?',
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: SizeUtil.instance.getSize(30)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.photo,
                        color: Colors.black,
                      ),
                      Text('Photo')
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.black12,
            height: SizeUtil.instance.getSize(20, basedOnSmaller: false),
          )
        ],
      ),
    ),
  );
}
