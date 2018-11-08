part of create_post_view;

abstract class CreatePostViewUIContract {
  StreamController<bool> _shouldAllowShareStreamController = StreamController.broadcast();

  ScrollController _backDropScrollController = ScrollController();

  void onShareStatus();

  void onDispose() {
    _shouldAllowShareStreamController.close();
  }
}

class CreatePostViewBuilder {
  final CreatePostViewUIContract ui;

  CreatePostViewBuilder(this.ui);

  Widget build() {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      iconTheme: IconThemeData(color: Colors.white, size: SizeUtil.instance.getSize(24)),
      title: Text('Create Post'),
      automaticallyImplyLeading: true,
      actions: <Widget>[
        Center(child: _buildShareButton()),
      ],
    );
  }

  Widget _buildShareButton() {
    return StreamBuilder<bool>(
      initialData: false,
      stream: ui._shouldAllowShareStreamController.stream,
      builder: (context, asyncSnapshot) {
        bool condition = asyncSnapshot.data;
        return InkWell(
          onTap: condition ? ui.onShareStatus : null,
          child: NoScaleText(
            'SHARE',
            style: TextStyle(color: condition ? Colors.white : Colors.white24),
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    return BackdropContentAnimation(
      inputContent: InputContent(),
      backdropContent: BackdropContent(scrollController: ui._backDropScrollController),
      backDropScrollController: ui._backDropScrollController,
    );
  }
}
