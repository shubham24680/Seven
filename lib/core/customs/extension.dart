import 'package:seven/core/core.dart';

extension PaddingExtension on Widget {
  Widget paddingFromLTRB(
          {double left = 0,
          double top = 0,
          double right = 0,
          double bottom = 0}) =>
      Padding(
        padding: EdgeInsets.fromLTRB(left, top, right, bottom),
        child: this,
      );

  Widget paddingAll(double value) =>
      paddingFromLTRB(left: value, top: value, right: value, bottom: value);

  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) =>
      paddingFromLTRB(
          left: horizontal, right: horizontal, top: vertical, bottom: vertical);

  Widget padding(
      {double? all,
      double? horizontal,
      double? vertical,
      double? left,
      double? top,
      double? right,
      double? bottom}) {
    final leftPadding = all ?? horizontal ?? left ?? 0;
    final rightPadding = all ?? horizontal ?? right ?? 0;
    final topPadding = all ?? vertical ?? top ?? 0;
    final bottomPadding = all ?? vertical ?? bottom ?? 0;

    return Padding(
      padding: EdgeInsets.fromLTRB(
          leftPadding, topPadding, rightPadding, bottomPadding),
      child: this,
    );
  }
}

extension ClickExtension on Widget {
  Widget _gestureDetector({void Function()? onTap}) => GestureDetector(
        onTap: onTap ?? () {},
        child: this,
      );

  Widget onTap({void Function()? event}) => _gestureDetector(onTap: event);
}
