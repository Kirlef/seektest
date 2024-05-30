import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/bloc/task_bloc.dart';
import '../../../config/routes/app_routes.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTaskScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
          onPressed: (){
            Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
          },
        ),
        title: Text("Add Task Screen", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue.shade900,
      ),

      body: Center(
        child: Form(
    key: formKey,
         child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                decoration:
                     InputDecoration(
                        filled: true,
                        labelText: 'Task',
                      border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(),
              ),
                    ),
                controller: titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Task can be empty';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                decoration:InputDecoration(
                  filled: true,
                  labelText: 'Details',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(),
                  ),
                ),
                controller: descriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Details can be empty';
                  }
                  return null;
                },
              ),
            ),

            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                context.read<TaskBloc>().add(
                      AddDataEvent(
                        title: titleController.text,
                        desc: descriptionController.text,
                        state: "pending",
                      ),
                    );
                Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);

              }
              },
              child: const Text('Create Task', style: TextStyle(color: Colors.white, fontSize: 20),),
            ),
          ],
        ),
        )
      ),
    );
  }
}
