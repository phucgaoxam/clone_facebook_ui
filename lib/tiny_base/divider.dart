part of base;

class HorizontalDivider extends StatelessWidget {
  final Color color;

  HorizontalDivider({this.color});

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 0.5,
      width: double.infinity,
      color: color ?? Theme.of(context).dividerColor,
    );
  }
}