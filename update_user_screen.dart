import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../database_helper.dart';

import '../user.dart';

class UpdateUserScreen extends StatefulWidget {
  final User user;
  const UpdateUserScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<UpdateUserScreen> createState() => _UpdateUsertScreenState();
}

class _UpdateUsertScreenState extends State<UpdateUserScreen> {

  var formKey = GlobalKey<FormState>();
  late String name, age;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update User'),
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

                  initialValue: widget.user.name,
                  decoration: InputDecoration(
                      hintText: 'Name',
                      labelText: 'Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      )
                  ),
                  validator: ( String? text){
                    if( text == null || text.isEmpty){
                      return 'Please provide name';
                    }

                    name = text;
                    return null;
                  },
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  initialValue: widget.user.age,
                  decoration: InputDecoration(
                      hintText: 'Age',
                      labelText: 'Age',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      )
                  ),
                  validator: ( String? text){
                    if( text == null || text.isEmpty){
                      return 'Please provide Age';
                    }

                    age = text;
                    return null;
                  },
                ),
                const SizedBox(height: 15,),
                ElevatedButton(onPressed: () async{
                  if( formKey.currentState!.validate()){
                    // update record in DB Table

                    User s = User(
                      id: widget.user.id,
                      name: name,
                      age: age,
                    );

                    int result = await DatabaseHelper.instance.updateStudent(s);

                    if( result > 0 ){
                      Fluttertoast.showToast(msg: "Record Update", backgroundColor: Colors.green);
                      Navigator.pop(context, 'done');

                    }else{
                      Fluttertoast.showToast(msg: "Updating Failed", backgroundColor: Colors.red);

                    }
                  }

                }, child: const Text('Update')),


              ],
            ),
          ),
        ),
      ),
    );
  }
}