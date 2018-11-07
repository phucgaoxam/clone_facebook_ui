part of base;

class SizeUtil {
  static const double _ZERO = 0.0;

  static const double _NORMAL_WIDTH = 1000.0;

  static List<double> _widthList = List(1000);
  static List<double> _heightList = List(1000);

  SizeUtil._internal();

  static final SizeUtil _singleton = new SizeUtil._internal();

  static SizeUtil get instance => _singleton;

  double _smallerWidth = _ZERO;
  double _biggerWidth = _ZERO;

  void init(double width, double height) {
    if (_smallerWidth != _ZERO || _biggerWidth != _ZERO) return;
    if (width < height) {
      _smallerWidth = width;
      _biggerWidth = height;
    } else {
      _smallerWidth = height;
      _biggerWidth = width;
    }
  }

  double getSize(int percent, {bool basedOnSmaller: true}) {
    assert(percent >= 1 && percent <= 1000);
    if (basedOnSmaller) return _getSizeBasedOnSmallerWidth(percent);
    return _getSizeBasedOnBiggerWidth(percent);
  }

  double _getSizeBasedOnSmallerWidth(int percent) {
    double width = _widthList[percent - 1];
    if (width == null || width == 0.0) {
      _widthList[percent - 1] = (percent * _smallerWidth) / _NORMAL_WIDTH;
      width = _widthList[percent - 1];
    }
    return width;
  }

  double _getSizeBasedOnBiggerWidth(int percent) {
    double height = _heightList[percent - 1];
    if (height == null || height == 0.0) {
      _heightList[percent - 1] = (percent * _biggerWidth) / _NORMAL_WIDTH;
      height = _heightList[percent - 1];
    }
    return height;
  }
}
