part of menu_view;

abstract class MenuViewUIContract {
  ScrollController _childScrollController;
}

Widget _build(MenuViewUIContract ui) {
  return SafeArea(
    child: LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeUtil.instance.getSize(30)),
          child: CustomScrollView(
            physics: NeverScrollableScrollPhysics(),
            controller: ui._childScrollController,
            slivers: <Widget>[
              _buildAvatarLayout(ui),
              SliverToBoxAdapter(
                child: HorizontalDivider(),
              ),
              _buildListSettings(ui),
            ],
          ),
        );
      },
    ),
  );
}

Widget _buildAvatarLayout(MenuViewUIContract ui) {
  return SliverToBoxAdapter(
    child: Container(
      height: SizeUtil.instance.getSize(150, basedOnSmaller: false),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            maxRadius: SizeUtil.instance.getSize(50, basedOnSmaller: false),
            backgroundColor: Colors.blue,
          ),
          Padding(
            padding: EdgeInsets.only(left: SizeUtil.instance.getSize(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                NoScaleText(
                  'Chau Minh Phuc',
                  style: TextStyle(
                      fontWeight: FontWeight.w500, fontSize: SizeUtil.instance.getSize(26, basedOnSmaller: false)),
                ),
                NoScaleText('View your profile'),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget _buildListSettings(MenuViewUIContract ui) {
  return SliverList(
    delegate: SliverChildBuilderDelegate(
      (context, index) {
        return ListTile(
          title: Text('$index'),
        );
      },
      childCount: 30,
    ),
  );
}
