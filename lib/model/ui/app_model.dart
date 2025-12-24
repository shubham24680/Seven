import 'package:seven/app/app.dart';

class AppModel {
  final String? id;
  final String? type;
  final String? variant;
  final String? url;
  final double? height;
  final double? width;
  final AppModel? widget;
  final List<AppModel>? widgets;
  final AppStyle? style;
  final AppNavigation? navigation;

  AppModel(
      {this.id,
      this.type,
      this.variant,
      this.url,
      this.height,
      this.width,
      this.widget,
      this.widgets,
      this.style,
      this.navigation});

  factory AppModel.fromJson(Map<String, dynamic> json) => AppModel(
      id: json["id"],
      type: json["type"],
      variant: json["variant"],
      url: json["url"],
      height: json["height"]?.toDouble(),
      width: json["width"]?.toDouble(),
      widget: json['widget'] != null ? AppModel.fromJson(json['widget']) : null,
      widgets:
          (json['widgets'] as List?)?.map((w) => AppModel.fromJson(w)).toList(),
      style: json['style'] != null ? AppStyle.fromJson(json['style']) : null,
      navigation: json['navigation'] != null
          ? AppNavigation.fromJson(json['navigation'])
          : null);

  AppModel copyWith({
    String? id,
    String? type,
    String? variant,
    String? url,
    double? height,
    double? width,
    AppModel? widget,
    List<AppModel>? widgets,
    AppStyle? style,
    AppNavigation? navigation,
  }) =>
      AppModel(
          id: id ?? this.id,
          type: type ?? this.type,
          variant: variant ?? this.variant,
          url: url ?? this.url,
          height: height ?? this.height,
          width: width ?? this.width,
          widget: widget ?? this.widget,
          widgets: widgets ?? this.widgets,
          style: style ?? this.style,
          navigation: navigation ?? this.navigation);

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "variant": variant,
        "url": url,
        "height": height,
        "width": width,
        "widget": widget?.toJson(),
        "widgets": widgets?.map((w) => w.toJson()).toList(),
        "style": style?.toJson(),
        "navigation": navigation?.toJson()
      };
}

class AppNavigation {
  final String? action;
  final String? screen;

  AppNavigation({this.action, this.screen});

  factory AppNavigation.fromJson(Map<String, dynamic> json) => AppNavigation(
        action: json["action"],
        screen: json["screen"],
      );

  Map<String, dynamic> toJson() => {
        "action": action,
        "screen": screen,
      };
}

class AppStyle {
  final double? blur;
  final String? backgroundColor;
  final String? foregroundColor;
  final String? shape;

  AppStyle({this.blur, this.backgroundColor, this.foregroundColor, this.shape});

  factory AppStyle.fromJson(Map<String, dynamic> json) => AppStyle(
      blur: json["blur"]?.toDouble(),
      backgroundColor: json["background_color"],
      foregroundColor: json["foreground_color"],
      shape: json["shape"]);

  Map<String, dynamic> toJson() => {
        "blur": blur,
        "background_color": backgroundColor,
        "foreground_color": foregroundColor,
        "shape": shape
      };
}
