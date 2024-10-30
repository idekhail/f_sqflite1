import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../database_helper.dart';
import '../user.dart';
import '../user_list_screen.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  var formKey = GlobalKey<FormState>();

  late String name, age;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Name',
                      labelText: 'Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  validator: (String? text) {
                    if (text == null || text.isEmpty) {
                      return 'Please provide name';
                    }

                    name = text;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Age',
                      labelText: 'Age',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  validator: (String? text) {
                    if (text == null || text.isEmpty) {
                      return 'Please provide age';
                    }

                    age = text;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        // save record in DB Table
                        // create a student object
                        User s = User(
                          name: name,
                          age: age,
                        );

                        int result = await DatabaseHelper.instance.insertStudent(s);

                        if( result > 0 ){
                          Fluttertoast.showToast(msg: "Record Saved", backgroundColor: Colors.green);
                        }else{
                          Fluttertoast.showToast(msg: "Record Failed", backgroundColor: Colors.red);

                        }
                      }
                    },
                    child: const Text('Save')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return const UsersListScreen();
                      }));
                    },
                    child: const Text('View All')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}