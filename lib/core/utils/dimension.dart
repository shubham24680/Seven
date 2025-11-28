import 'dart:math';
import 'package:seven/app/app.dart';

extension Dimensions on num {
  double get w => DimensionUtil().setWidth(this);
  double get h => DimensionUtil().setHeight(this);
  double get sw => DimensionUtil().deviceWidth * this;
  double get sh => DimensionUtil().deviceHeight * this;
  double get sp => DimensionUtil().setSp(this);
  double get r => DimensionUtil().setRadius(this);
}

class DimensionUtil {
  DimensionUtil._();
  static DimensionUtil? _instance;
  factory DimensionUtil() => _instance ??= DimensionUtil._();
  static const _defaultSize = Size(360.0, 800.0);

  late Size _designSize;
  late MediaQueryData _mediaQueryData;
  late bool _isFoldable;

  static void init(BuildContext context, {Size designSize = _defaultSize}) {
    _instance ??= DimensionUtil._();
    _instance!._designSize = designSize;
    _instance!._mediaQueryData = MediaQuery.of(context);
    _instance!._detectFoldable();
  }

  void _detectFoldable() {
    _isFoldable = false;

    final aspectRatio = deviceWidth / deviceHeight;
    if ((isPortrait && aspectRatio > 0.55) || (isLandscape && aspectRatio < 2.0)) {
      _isFoldable = true;
    }

  }

  double get statusBarHeight => _mediaQueryData.padding.top;
  double get bottomBarHeight => _mediaQueryData.padding.bottom;
  Orientation get orientation => _mediaQueryData.orientation;
  bool get isLandscape => orientation == Orientation.landscape;
  bool get isPortrait => orientation == Orientation.portrait;
  bool get isFoldable => _isFoldable;

  Size get designSize => _designSize;
  double get deviceWidth => _mediaQueryData.size.width;
  double get deviceHeight => _mediaQueryData.size.height;
  // double get pixelRatio => _mediaQueryData.devicePixelRatio;

  double get scaleWidth => ((isFoldable ? 0.5 : 1) * (isLandscape ? deviceHeight : deviceWidth)) / _designSize.width;
  double get scaleHeight => (isLandscape ? deviceWidth : deviceHeight) / _designSize.height;
  double get scaleMin => min(scaleWidth, scaleHeight);
  // double get scaleMax => max(scaleWidth, scaleHeight);
  // double get scaleAvg => (scaleWidth + scaleHeight) * 0.5;

  double setWidth(num width) => width * scaleWidth;
  double setHeight(num height) => height * scaleHeight;
  double setRadius(num radius) => radius * scaleMin;
  double setSp(num fontSize) => fontSize * scaleMin;
}

class DimensionUtilInit extends StatelessWidget {
  const DimensionUtilInit(
      {super.key,
      required this.child,
      this.designSize = DimensionUtil._defaultSize});

  final Size designSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        DimensionUtil.init(context, designSize: designSize);
        return child;
      },
    );
  }
}
