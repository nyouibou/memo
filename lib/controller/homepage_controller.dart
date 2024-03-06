import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:note_app/utils/color_constants/color_constants.dart';

class Homepagecontroller {
  static TextEditingController titlecontroller = TextEditingController();
  static TextEditingController descontroller = TextEditingController();

  static TextEditingController datecontroller = TextEditingController();
  static Color selectcolor = Colors.white;
  static List colorslist = [
    Colorconstants.containerone,
    Colorconstants.containertwo,
    Colorconstants.containerthree,
    Colorconstants.containerfour
  ];
  // List noteslist = [];
  List noteskeys = [];
  var mybox = Hive.box('notebox');

  // function to add
  void addData() {
    mybox.add({
      "title": titlecontroller.text,
      "des": descontroller.text,
      "date": datecontroller.text,
      "color": selectcolor
    });
    noteskeys = mybox.keys.toList();
  }

  // functn to edit
  void editData(int index) {
    mybox.put(noteskeys, {
      "title": titlecontroller.text,
      "des": descontroller.text,
      "date": datecontroller.text,
      "color": selectcolor
    });
  }

  // functn to delete

  void deleteData(var key) {
    mybox.delete(key);
    noteskeys = mybox.keys.toList();
  }

  // fnctn to clear
  static void clearData() {
    titlecontroller.clear();
    descontroller.clear();
    datecontroller.clear();
  }

  // on selectioncolor
  void onColorselction(newcolor) {
    selectcolor = newcolor;
  }

  init() {
    noteskeys = mybox.keys.toList();
  }
}
