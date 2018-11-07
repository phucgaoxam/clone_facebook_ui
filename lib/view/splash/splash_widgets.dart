part of splash_view;

mixin SplashViewUIContract {
  AnimationController _loadingController;
  StreamController<bool> _loadingStreamController = StreamController.broadcast();

  void onDispose() {
    _loadingStreamController.close();
  }
}

SafeArea _build(SplashViewUIContract uiContract) {
  return SafeArea(
    child: Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          SizeUtil.instance.init(constraints.maxWidth, constraints.maxHeight);
          return _buildBody(uiContract, context, constraints);
        },
      ),
    ),
  );
}

Widget _buildBody(SplashViewUIContract uiContract, BuildContext context, BoxConstraints constraints) {
  return Container(
    width: double.infinity,
    color: AppColors.primaryColor,
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildLogo(),
        StreamBuilder(
          stream: uiContract._loadingStreamController.stream,
          initialData: false,
          builder: (context, asyncSnapshot) {
            if (!asyncSnapshot.data) return Container();
            return _buildTransitionAnimation(uiContract);
          },
        ),
      ],
    ),
  );
}

Widget _buildLogo() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: SizeUtil.instance.getSize(10, basedOnSmaller: false)),
    height: SizeUtil.instance.getSize(200),
    width: SizeUtil.instance.getSize(200),
    child: SvgPicture.asset('images/fb_logo.svg'),
  );
}

Widget _buildTransitionAnimation(SplashViewUIContract uiContract) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: SizeUtil.instance.getSize(10, basedOnSmaller: false)),
    child: AnimatedBuilder(
      animation: uiContract._loadingController,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeUtil.instance.getSize(10)),
                  child: Container(
                    height: SizeUtil.instance.getSize(30),
                    width: SizeUtil.instance.getSize(30),
                    decoration: BoxDecoration(
                        color: getColor(index, uiContract._loadingController.value), shape: BoxShape.circle),
                  ),
                ),
          ),
        );
      },
    ),
  );
}

Color getColor(int index, double value) {
  if (value >= index && value < index + 1) {
    return Colors.white;
  } else
    return Colors.white30;
}
