// ignore_for_file: deprecated_member_use

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realtimetutorial/screens/view_data.dart';

class UpdateScreen extends StatefulWidget {
  final String value;
  // ignore: use_key_in_widget_constructors
  const UpdateScreen({required this.value});

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  // ignore: prefer_final_fields
  TextEditingController _textController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final _ref = FirebaseDatabase.instance.ref().child("Tasks");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _textController,
                    decoration:
                        const InputDecoration(hintText: "Enter Updated value"),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Enter Updated Value";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (!_formkey.currentState!.validate()) {
                        return;
                      }
                      _formkey.currentState!.save();
                      String _text = _textController.text;
                      _ref.child(widget.value).set(_text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ViewData()));
                    },
                    child: const Text("Update"),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
