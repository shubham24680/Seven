import 'dart:developer';
import '../../../app/app.dart';

typedef HomeWidgetBuilder = Widget Function(AppModel item);

enum HomeWidgetType {
  LAYOUT("layout", buildLayout),
  SPACER("spacer", buildSpacer),
  BUTTON("button", buildButton),
  IMAGE("image", buildImage),
  CAROUSEL("image", buildCarousel),
  FALLBACK("", buildFallback),
  WIDGET1("widget_1", buildWidget1),
  WIDGET2("widget_2", buildWidget2);

  final String type;
  final HomeWidgetBuilder builder;
  const HomeWidgetType(this.type, this.builder);
}

extension HomeType on String? {
  HomeWidgetType getHomeWidgetType() => HomeWidgetType.values.firstWhere(
      (widget) => widget.type == this?.trim().toLowerCase(),
      orElse: () => HomeWidgetType.FALLBACK);
}

Widget generateWidgets(AppModel item, {bool fillWidth = false}) {
  log("Widget Type: ${item.type}");
  final type = item.type?.getHomeWidgetType() ?? HomeWidgetType.FALLBACK;
  return type.builder(item);
}

enum LayoutType { ROW, COLUMN, STACK }
Widget buildLayout(AppModel item, {bool fillWidth = false}) {
  final variant = LayoutType.values.byName(item.variant?.toUpperCase() ?? "ROW");
  final children = item.widgets
      ?.map((w) => generateWidgets(w, fillWidth: true)).toList()
      ?? [];

  Widget child;
  switch (variant) {
    case LayoutType.STACK:
      child = Stack(children: children);
    case LayoutType.COLUMN:
      child = Column(crossAxisAlignment: CrossAxisAlignment.start, children: children);
    default:
      child = Row(crossAxisAlignment: CrossAxisAlignment.start, children: children);
  }

  final height = item.height;
  return blurEffect(item.style?.blur ?? 0.0, Container(
      height: (height != null) ? height.w : null,
      width: fillWidth ? double.infinity : null,
      color: parseColor(item.style?.backgroundColor, defaultColor: AppColors.transparent),
      child: child));
}

Widget buildFallback(AppModel item) => const SizedBox.shrink();

Widget buildSpacer(AppModel item) {
  final height = item.height;
  final width = item.width;
  if (height != null) return SizedBox(height: height.w);
  if (width != null) return SizedBox(width: width.w);
  return const Spacer();
}

Widget buildButton(AppModel item) => CustomButton(
    buttonType: ButtonType.ICON,
    icon: AppSvgs.SEARCH_OUTLINED,
    onPressed: () {});

Widget buildImage(AppModel item) => CustomImage(
    imageType: ImageType.LOCAL,
    imageUrl: AppImages.AVATARS[0],
    // height: 36.w,
    // width: 36.w,
    borderRadius: BorderRadius.circular(1.sw),
    onClick: () {});

Widget buildCarousel(AppModel item) => const SizedBox.shrink();

Widget buildWidget1(AppModel item) => const SizedBox.shrink();

Widget buildWidget2(AppModel item) => const SizedBox.shrink();