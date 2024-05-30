import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seektest/config/routes/app_routes.dart';

import '../../../config/bloc/task_bloc.dart';
import '../../../domain/models/task.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({
    Key? key,
    required this.id,
    required this.title,
    required this.desc,
    required this.state,
  }) : super(key: key);
  final String id;
  final String title;
  final String desc;
  final String state;

  @override
  State<EditTaskScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTaskScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    titleController.text = widget.title;
    descriptionController.text = widget.desc;
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
        onPressed: (){
        Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
        },
        ),
        title: Text("Edit Task Screen", style: TextStyle(color: Colors.white),),
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
              final todoList = Task(
                            id: widget.id,
                            title: titleController.text,
                            desc: descriptionController.text,
                            state: widget.state == "done" ? "Done":"Pending",
                          );
                          context.read<TaskBloc>().add(UpdateDataEvent(todoList));

              Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);

              }
              },
              child: const Text('Edit Task', style: TextStyle(color: Colors.white, fontSize: 20),),
              ),
            ],
          ),
          )
    ));
  }
}
