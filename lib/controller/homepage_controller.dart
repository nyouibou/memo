import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Homepagecontroller {
  static TextEditingController titlecontroller = TextEditingController();
  static TextEditingController descontroller = TextEditingController();

  static TextEditingController datecontroller = TextEditingController();
  static Color selectcolor = Colors.white;
  // List noteslist = [];
  List noteskeys = [];
  var mybox = Hive.box('notebox');

  // function to add
  void addData() {
    mybox.add({
      "title": titlecontroller.text,
      "des": descontroller.text,
      "date": datecontroller.text,
      // "color": selectcolor
    });
    noteskeys = mybox.keys.toList();
  }

  // functn to edit
  // void editData(int index) {
  //   noteslist[index] = {
  //     "title": titlecontroller.text,
  //     "des": descontroller.text,
  //     "date": datecontroller.text,
  //     "color": selectcolor
  //   };
  // }

  // functn to delete

  // void deleteData(int index) {
  //   noteslist.removeAt(index);
  // }

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
