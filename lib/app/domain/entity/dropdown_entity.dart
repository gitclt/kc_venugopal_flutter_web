class DropDownModel {
  String? name;
  String? id;
  String? type;

  DropDownModel({this.name, this.id, this.type});

  @override
  String toString() {
    return name.toString();
  }
}
