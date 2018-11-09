part of create_post_view;

class BackdropContent extends StatefulWidget {
  final ScrollController scrollController;

  BackdropContent({this.scrollController});

  @override
  _BackdropContentState createState() => _BackdropContentState();
}

class _BackdropContentState extends BaseState<BackdropContent> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        controller: widget.scrollController,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            title: NoScaleText('$index'),
          );
        },
        separatorBuilder: (context, index) {
          return HorizontalDivider();
        },
        itemCount: 20,
      ),
    );
  }
}
