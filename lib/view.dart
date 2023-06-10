import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:runtime_data/main.dart';

class View extends StatefulWidget {
  const View({Key? key}) : super(key: key);

  @override
  State<View> createState() => _ViewState();
}

class _ViewState extends State<View> {
  List key = [];
  List values = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('stdent');
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      Map m = data as Map;
      print(m);
      key = m.keys.toList();
      values = m.values.toList();
      print(values);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: ListView.builder(
        itemCount: values.length,
        itemBuilder: (context, index) {
          return ListTile(trailing: Wrap(children: [
            IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return runtime_databased(key[index],values[index]);
              },));

            }, icon: Icon(Icons.edit)),
            IconButton(onPressed: () {
              DatabaseReference ref = FirebaseDatabase.instance.ref("stdent").child(key[index]);
              ref.remove();
              setState(() {});
            }, icon: Icon(Icons.delete)),
          ]),
            title: Text("${values[index]['name']}|${values[index]['contact']}"),
            subtitle: Text("${values[index]['mark']['sub1']}|${values[index]['mark']['sub2']}|${values[index]['mark']['sub3']}"),
          );
        },
      ),
    );
  }
}
