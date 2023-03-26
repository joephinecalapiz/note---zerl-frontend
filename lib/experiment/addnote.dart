import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_diaryapp/models/user.dart';
import 'package:frontend_diaryapp/utility/rounded_button.dart';
import 'package:http/http.dart' as http;

import '../services/global.dart';
class AddData extends StatefulWidget {
  const AddData({ Key? key }) : super(key: key);

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  var formKey = GlobalKey<FormState>();


  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  Future addData()async{
    String token = await getToken();
    var body = {
      'first_name': titleController.text,
      'last_name' : contentController.text
    };
    var headers = {
      "Content-Type" : "application/json",
      'Authorization':'Bearer $token'
    };
    final uri = Uri.parse(postEmployeeURL);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: headers
    );
    print(token);
    print(response.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,

          child: ListView(
            padding: const EdgeInsets.all(20),

            children: [

            TextFormField(
              controller: titleController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: 'Title',
                labelText: 'what to do',),
              validator: (value) {
                return (value == '') ? 'Required title' : null;
              },
            ),
            TextFormField(
              controller: contentController,
              decoration: const InputDecoration(
                hintText: 'input what you need',
                labelText: 'content',),
              keyboardType: TextInputType.text,
              minLines: 29,
              maxLines: 50,
              validator: (value) {
                return (value == '') ? 'Required content' : null;
              },
            ),
            // TextField(
            //   controller: lNameController,
            // ),
            const SizedBox(height: 20),

              // RoundedButton(
              //   buttonText: 'SUBMIT',
              //   onButtonPressed: () => addData(),
              // ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                side: const BorderSide(width: 5)
              ),
              onPressed: addData,
              child: const Text('SUBMIT'))
          ],
        )),
    );
  }
}