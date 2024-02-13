import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/localization/locales.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:http/http.dart' as http;


class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({super.key, this.todo});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      titleController.text = title;
      descriptionController.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit
            ? LocaleData.update.getString(context)
            : LocaleData.addTask.getString(context)),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.green], // Add your desired colors
          ),
        ),
        child: ListView(padding: EdgeInsets.all(20), children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    // color: Colors.red[500],
                    ),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                    hintText: LocaleData.titleAdd.getString(context)),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    // color: Colors.red[500],
                    ),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                    focusColor: Colors.black,
                    hintText: LocaleData.description.getString(context)),
                minLines: 3,
                maxLines: 5,
                //  keyboardType: TextInputType.multiline,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: isEdit ? updateData : submitData,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 229, 243,
                    255), // Set the button's background color to blue
                foregroundColor: Color.fromARGB(
                    255, 3, 0, 39), // Set the text color to white
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(isEdit
                    ? LocaleData.update.getString(context)
                    : LocaleData.submit.getString(context)),
              ))
        ]),
      ),
    );
  }

  Future<void> updateData() async {
    final todo = widget.todo;
    if (todo == null) {
      print('ieuwfh');
      return;
    }
    final id = todo['_id'];
    final title = titleController.text;
    final description = descriptionController.text;
 final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };

//https://api.nstack.in/v1/todos
      final url = 'https://api.nstack.in/v1/todos/${id}';
    final uri = Uri.parse(url);
    final response = await http.put(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
 if (response.statusCode == 200) {
      titleController.text = '';
     descriptionController.text = '';
      showMessage('Updation Success');
    } else {
      showMessage('Updation Failed${response.statusCode}');
    }
  }

  Future<void> submitData() async {
    final title = titleController.text;
    final description = descriptionController.text;

    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };
    final url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        body: jsonEncode(body), 
        headers: {'Content-Type': 'application/json'});

    // titleController.text = '';
    // descriptionController.text = '';
    if (response.statusCode == 201) {
      titleController.text = '';
     descriptionController.text = '';
      showMessage('Creation Success');
    } else {
      showMessage('Creation Failed,${response.statusCode } ');
    }
  }

  void showMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
