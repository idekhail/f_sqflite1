import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../database_helper.dart';
import '../user.dart';
import '../update_user_screen.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User List"),
      ),
      body: FutureBuilder<List<User>>(
          future: DatabaseHelper.instance.getAllStudents(),
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot){

            if( !snapshot.hasData){
              return const Center(child: CircularProgressIndicator());
            }else {

              if( snapshot.data!.isEmpty){
                return const Center(child: Text('No Records Found'));

              }else{

                List<User> users = snapshot.data!;

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index){

                        User s = users[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.amber[200],
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                      color: Colors.red[100],
                                      borderRadius: BorderRadius.circular(16.0)
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(s.id.toString()),
                                      Text(s.name),
                                      Text(s.age),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16.0,),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.green[100],
                                    borderRadius: BorderRadius.circular(16.0)
                                ),
                                child: Column(
                                  children: [
                                    IconButton(onPressed: () async{
                                      String result =  await Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                        return UpdateUserScreen(user: s);
                                      }));

                                      if( result == 'done'){
                                        setState((){});
                                      }

                                    }, icon: const Icon(Icons.edit)),
                                    IconButton(onPressed: (){

                                      showDialog(
                                          barrierDismissible: false,
                                          context: context, builder: (context){
                                        return AlertDialog(
                                          title: const Text('Confirmation!!!'),
                                          content: const Text('Are you sure to delete?'),
                                          actions: [
                                            TextButton(onPressed: (){
                                              Navigator.of(context).pop();
                                            }, child: const Text('No')),
                                            TextButton(onPressed: () async{
                                              Navigator.of(context).pop();

                                              // delete student

                                              int result = await DatabaseHelper.instance.deleteStudent(s.id!);

                                              if( result > 0 ){
                                                Fluttertoast.showToast(msg: 'RECORD DELETED');
                                                setState((){});
                                                // build function will be called
                                              }

                                            }, child: const Text('Yes')),

                                          ],
                                        );
                                      });

                                    }, icon: const Icon(Icons.delete)),

                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                );
              }

            }

          }),
    );
  }
}