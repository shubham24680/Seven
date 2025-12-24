class MainModel {
  final String? id;
  final String? type;
  final bool? showSelectedLabels;
  final bool? showUnselectedLabels;
  final Style? style;
  final List<Model>? widgets;

  MainModel(
      {this.id,
      this.type,
      this.showSelectedLabels,
      this.showUnselectedLabels,
      this.style,
      this.widgets});

  factory MainModel.fromJson(Map<String, dynamic> json) => MainModel(
      id: json["id"],
      type: json["type"],
      showSelectedLabels: json["show_selected_labels"],
      showUnselectedLabels: json["show_unselected_labels"],
      widgets: (json["widgets"] as List<dynamic>?)
          ?.map((w) => Model.fromJson(w))
          .toList(),
      style: json["style"] != null ? Style.fromJson(json["style"]) : null);

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "show_selected_labels": showSelectedLabels,
        "show_unselected_labels": showUnselectedLabels,
        "widgets": widgets?.map((w) => w.toJson()).toList(),
        "style": style?.toJson()
      };
}

class Style {
  final String? selectedColor;
  final String? unselectedColor;
  final String? backgroundColor;

  Style({this.selectedColor, this.unselectedColor, this.backgroundColor});

  factory Style.fromJson(Map<String, dynamic> json) => Style(
      selectedColor: json["selected_color"],
      unselectedColor: json["unselected_color"],
      backgroundColor: json["background_color"]);

  Map<String, dynamic> toJson() => {
        "selected_color": selectedColor,
        "unselected_color": unselectedColor,
        "background_color": backgroundColor
      };
}

class Model {
  final String? id;
  final String? type;
  final String? iconUrl;

  Model({this.id, this.type, this.iconUrl});

  factory Model.fromJson(Map<String, dynamic> json) =>
      Model(id: json["id"], type: json["type"], iconUrl: json["url"]);

  Map<String, dynamic> toJson() => {"id": id, "type": type, "url": iconUrl};
}
