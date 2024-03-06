import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/controller/homepage_controller.dart';
import 'package:note_app/utils/color_constants/color_constants.dart';
import 'package:note_app/view/home_page/widgets/customnote.dart';
import 'package:note_app/view/home_page/widgets/notelistpage.dart';
// import 'package:note_app/view/note_listpage/note_listpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Homepagecontroller saveobj = Homepagecontroller();
  var mybox = Hive.box('notebox');
  @override
  void initState() {
    saveobj.init();
    setState(() {});
    super.initState();
  }

  // Homepagecontroller deleteobj = Homepagecontroller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorconstants.mainblack,
      appBar: AppBar(
        title: Text(
          "MeMo",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colorconstants.mainblack,
      ),
      body: saveobj.noteskeys.isEmpty
          ? Center(
              child: Text(
                "no data found",
                style: TextStyle(color: Colorconstants.mainwhite),
              ),
            )
          : ListView.separated(
              // to reverse the ading
              shrinkWrap: true,
              reverse: true,
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(10),
                    child: custonotewidget(
                      title: mybox.get(saveobj.noteskeys[index])["title"],
                      des: mybox.get(saveobj.noteskeys[index])["des"],
                      date: mybox.get(saveobj.noteskeys[index])["date"],
                      color: mybox.get(saveobj.noteskeys[index])["color"],
                      // delete
                      ondeletepressed: () {
                        saveobj.deleteData(index);
                        setState(() {});
                      },

                      // edit
                      oneditpressed: () {
                        Homepagecontroller.titlecontroller.text =
                            mybox.get(saveobj.noteskeys[index])["title"];
                        Homepagecontroller.descontroller.text =
                            mybox.get(saveobj.noteskeys[index])["des"];
                        Homepagecontroller.datecontroller.text =
                            mybox.get(saveobj.noteskeys[index])["date"];

                        // to show bottom sheet
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return NoteListpage(
                              isedit: true,

                              onSavepressed: () {
                                saveobj.editData(index);

                                setState(() {});
                                Homepagecontroller.clearData();
                                //
                                Navigator.pop(context);
                              },
                              // end of bottom sheet
                            );
                          },
                        );

                        setState(() {});
                      },
                    ),
                  ),
              separatorBuilder: (context, index) => SizedBox(
                    height: 7,
                  ),
              itemCount: saveobj.noteskeys.length),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return NoteListpage(
                onSavepressed: () {
                  saveobj.addData();

                  setState(() {});
                  Homepagecontroller.clearData();
                  //
                  Navigator.pop(context);
                },
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          color: Colorconstants.mainblack,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        mini: true,
      ),
    );
  }
}
