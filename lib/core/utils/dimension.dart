import 'dart:developer' as developer;
import 'dart:math';
import 'package:seven/app/app.dart';

enum ScaleType { WIDTH, HEIGHT, MIN, MAX, AVG }
enum DeviceSize {
  SMALL(550, 1.0),
  MEDIUM(1100, 0.5),
  LARGE(6000, 0.3);

  final double minWidth, reductionPercentage;
  const DeviceSize(this.minWidth, this.reductionPercentage);
}

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
  late ScaleType _scaleType;

  static void init(BuildContext context, designSize, ScaleType scaleType) {
    _instance ??= DimensionUtil._();
    _instance!._designSize = designSize;
    _instance!._mediaQueryData = MediaQuery.of(context);
    _instance!._scaleType = scaleType;
  }

  double get statusBarHeight => _mediaQueryData.padding.top;
  double get bottomBarHeight => _mediaQueryData.padding.bottom;
  Orientation get orientation => _mediaQueryData.orientation;
  bool get isLandscape => orientation == Orientation.landscape;
  bool get isPortrait => orientation == Orientation.portrait;

  Size get designSize => _designSize;
  double get deviceWidth => _mediaQueryData.size.width;
  double get deviceHeight => _mediaQueryData.size.height;
  DeviceSize get deviceSize => DeviceSize.values.firstWhere((device) => device.minWidth > deviceWidth);

  double get scaleWidth => (deviceSize.reductionPercentage * deviceWidth) / _designSize.width;
  double get scaleHeight => deviceHeight / _designSize.height;
  double get scaleMin => min(scaleWidth, scaleHeight);
  double get scaleMax => max(scaleWidth, scaleHeight);
  double get scaleAvg => (scaleWidth + scaleHeight) * 0.5;
  double get scale => switch (_scaleType) {
        ScaleType.WIDTH => scaleWidth,
        ScaleType.HEIGHT => scaleHeight,
        ScaleType.MIN => scaleMin,
        ScaleType.MAX => scaleMax,
        ScaleType.AVG => scaleAvg,
      };

  double setWidth(num width) => width * scaleWidth;
  double setHeight(num height) => height * scaleHeight;
  double setRadius(num radius) => radius * scale;
  double setSp(num fontSize) => fontSize * scale;
}

class DimensionUtilInit extends StatelessWidget {
  const DimensionUtilInit(
      {super.key,
      required this.child,
      this.designSize = DimensionUtil._defaultSize,
      this.scaleType = ScaleType.MIN});

  final Size designSize;
  final ScaleType scaleType;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        DimensionUtil.init(context, designSize, scaleType);

        Future.microtask(() {
          developer.log("deviceWidth - ${DimensionUtil().deviceWidth}\n"
              "deviceHeight - ${DimensionUtil().deviceHeight}\n"
              "deviceSize - ${DimensionUtil().deviceSize}\n"
              "scaleWidth - ${DimensionUtil().scaleWidth}\n"
              "scaleHeight - ${DimensionUtil().scaleHeight}\n"
              "scaleMin - ${DimensionUtil().scaleMin}\n"
              "isLandscape - ${DimensionUtil().isLandscape}\n");
        });

        return child;
      },
    );
  }
}
