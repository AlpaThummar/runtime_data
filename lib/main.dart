import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:runtime_data/view.dart';

Future<void> main() async {
  print("Hello");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

  );
  runApp(MaterialApp(home: runtime_databased(),));
}
class runtime_databased extends StatefulWidget {
  String ?id;
  Map ?m;
  runtime_databased([this.id,this.m]);

  //const runtime_databased({Key? key}) : super(key: key);


  @override
  State<runtime_databased> createState() => _runtime_databasedState();
}

class _runtime_databasedState extends State<runtime_databased> {
  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  TextEditingController t3=TextEditingController();
  TextEditingController t4=TextEditingController();
  TextEditingController t5=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.id!=null)
      {
        t1.text=widget.m!['name'];
        t2.text=widget.m!['contact'];
        t3.text=widget.m!['sub1'];
        t4.text=widget.m!['sub2'];
        t5.text=widget.m!['sub3'];
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Demo"),),
      body: ListView(children: [
        TextField(controller: t1,decoration: InputDecoration(hintText: "Enter Name"),),
        TextField(controller: t2,decoration: InputDecoration(hintText: "Enter contatc"),),
        TextField(controller: t3,decoration: InputDecoration(hintText: "Enter sub1"),),
        TextField(controller: t4,decoration: InputDecoration(hintText: "Enter sub2"),),
        TextField(controller: t5,decoration: InputDecoration(hintText: "Enter sub3"),),
        ElevatedButton(onPressed: () async {
          if(widget.id!=null){

            DatabaseReference ref = FirebaseDatabase.instance.ref("stdent").child(widget.id!).push();
            ref.update({
              "name": "${t1.text}",
              "contact": "${t2.text}",
              "mark": {
                "sub1": "${t3.text}",
                "sub2": "${t4.text}",
                "sub3": "${t5.text}",
              }

            });

          }else{

            DatabaseReference ref = FirebaseDatabase.instance.ref("stdent").push();

            await ref.set({
              "name": "${t1.text}",
              "contact": "${t2.text}",
              "mark": {
                "sub1": "${t3.text}",
                "sub2": "${t4.text}",
                "sub3": "${t5.text}",
              }
            });

          }


        }, child: Text("Add Details")),
        ElevatedButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return View();
          },));

        }, child: Text("View")),

      ]),
    );
  }
}
