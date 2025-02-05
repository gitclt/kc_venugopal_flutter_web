import 'package:flutter/material.dart';

class MenuEntity {
  String? menu;
  int? id;
  IconData? icon;
  String? svgIcon;
  Function? onClick;
  List<MenuEntity>? items;

  MenuEntity({
    this.menu,
    this.id,
    this.items,
    this.icon,
    this.onClick,
    this.svgIcon,
  });
}
