import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:seektest/domain/models/task.dart';
import 'package:seektest/presentation/pages/add_task/add_task.dart';
import 'package:seektest/presentation/pages/edit_task/edit_task.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/bloc/task_bloc.dart';
import '../../../config/routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{
  late final controller = SlidableController(this);

  @override
  void initState() {
   // context.read<TaskBloc>().add(ShowDataEvent());

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskBloc>().add(ShowDataEvent());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {

    super.dispose();
  }

  valueFilter(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try{
      prefs.setString('filter', value);
    }catch(e){
      print(e);
    }
    if (mounted)
    context.read<TaskBloc>().add(ShowDataEvent());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: Icon(Icons.menu),
        title: Text('Task List', style: TextStyle(color: Colors.white),),
        actions: [
          OutlinedButton(
            child: Text("Done", style: TextStyle(fontSize: 20)),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: BorderSide(
                color: Colors.white,
              ),
            ),
            onPressed: () async {
               await valueFilter("done");

            },
          ),
          OutlinedButton(
            child: Text("Pending", style: TextStyle(fontSize: 20),),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: BorderSide(
                color: Colors.white,
              ),
            ),
            onPressed: () async {
                await valueFilter("pending");

            },
          ),

        ],
        backgroundColor: Colors.blue.shade900,
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("New Task", style: TextStyle(color: Colors.white, fontSize: 20),),
        icon: const Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.add);

        },
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        // bloc:,

        builder: (context, state) {
          return ListView.builder(
            itemCount: state.taskModel.length,
            itemBuilder: (context, index) {
              final helper = state.taskModel[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Slidable(
                  key: const ValueKey(0),
                      endActionPane:  ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            final todoList = Task(
                              id: helper.id,
                              title: helper.title,
                              desc: helper.desc,
                              state: helper.state == "done" ? "pending":"done",
                            );
                            context.read<TaskBloc>().add(UpdateDataEvent(todoList));
                            context.read<TaskBloc>().add(ShowDataEvent());

                            setState(() {

                            });
                          },
                          backgroundColor: helper.state == "done" ? Colors.deepOrangeAccent : Color(0xFF7BC043),
                          foregroundColor: Colors.white,
                          icon: helper.state == "done" ? Icons.circle_outlined :Icons.task_alt,

                        ),

                      SlidableAction(
                        onPressed: (context) {
                        Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) => EditTaskScreen(
                                                  id: helper.id,
                                                  title: helper.title,
                                                  desc: helper.desc,
                                                  state: helper.state,
                                                ),
                                              ));
                      },
                      backgroundColor:  Colors.blue,
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      ),

                        SlidableAction(
                          onPressed: (context) {
                            context.read<TaskBloc>().add(DeleteDataEvent(id: helper.id));
                          },
                          backgroundColor: Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                        ),
                      ],
                      ),

                      // The child of the Slidable is what the user sees when the
                      // component is not dragged.
                      child:  ListTile(
                      title: Text(helper.title, style: TextStyle(color: Colors.black, fontSize: 20)),
                      subtitle: Text(helper.desc, style: TextStyle(color: Colors.black, fontSize: 20)),
                      leading: Chip(
                        padding: EdgeInsets.all(0),
                        backgroundColor: helper.state == "done" ?Colors.green: Colors.deepOrangeAccent,
                        label: helper.state == "done" ?
                        Text("DONE"
                            , style: TextStyle(color: Colors.white, fontSize: 20)):
                        Text("PENDING"
                            , style: TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                        trailing: Icon(Icons.keyboard_double_arrow_left_outlined),
                      ),

                      ),
                      Divider(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
