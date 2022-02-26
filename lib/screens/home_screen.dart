import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realtimetutorial/screens/view_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formkey = GlobalKey<FormState>();
  late DatabaseReference _ref;
  // ignore: prefer_final_fields
  TextEditingController _taskController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _taskController = TextEditingController();
    _ref = FirebaseDatabase.instance.ref().child("Tasks");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Store Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _taskController,
                    decoration: const InputDecoration(hintText: "Enter task"),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Enter Task";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    onPressed: () {
                      if (!_formkey.currentState!.validate()) {
                        return;
                      }
                      _formkey.currentState!.save();
                      _ref.push().set(_taskController.text).then((value) =>
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ViewData())));
                    },
                    child: const Text("Submit"),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
