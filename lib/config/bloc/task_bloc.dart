import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:seektest/domain/models/task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../infraestructure/driven_adapter/database/db_helper.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState(taskModel: [])) {
    on<ShowDataEvent>(showData);
    on<AddDataEvent>(addTask);
    on<UpdateDataEvent>(updateTask);
    on<DeleteDataEvent>(deleteTask);
  }

   Future<String> getValueFilter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value= "";
    try{
      value =  await prefs.getString('filter');
      if(value == null || value == "")
        value = "pending";

    }catch(e){
      print(e);
    }
   return value!;
  }

  Future showData(ShowDataEvent event, Emitter<TaskState> emit) async {
    String value  = await getValueFilter();
    final dataList = await DBHelper.selectAll(value);

    final list = dataList
        .map((item) => Task(
              id: item['id'],
              title: item['title'],
              desc: item['description'],
              state: item['state'],
            ))
        .toList();

    emit(state.copyWith(taskModel: list));
  }


  Future<void> addTask(AddDataEvent event, Emitter<TaskState> emit) async {
    Uuid uuid = const Uuid();
    final list = Task(
      id: uuid.v1(),
      title: event.title,
      desc: event.desc,
      state: event.state,
    );

    DBHelper.insert(DBHelper.todoTable, {
      'id': list.id,
      'title': list.title,
      'description': list.desc,
      'state': list.state,
    });

    final newTodos = [...state.taskModel, list];
    emit(state.copyWith(taskModel: newTodos));
  }

  Future<void> deleteTask(
      DeleteDataEvent event, Emitter<TaskState> emit) async {
    final deleteObject =
        state.taskModel.where((Task todo) => todo.id != event.id).toList();
    await DBHelper.deleteById(DBHelper.todoTable, 'id', event.id);
    emit(state.copyWith(taskModel: deleteObject));
  }

  Future<void> updateTask(
      UpdateDataEvent event, Emitter<TaskState> emit) async {
    final list = state.taskModel.map((Task todoModel) {
      if (todoModel.id == event.taskList.id) {
        DBHelper.update(DBHelper.todoTable, 'title', event.taskList.title,
            event.taskList.id);
        DBHelper.update(DBHelper.todoTable, 'description', event.taskList.desc,
            event.taskList.id);
        DBHelper.update(DBHelper.todoTable, 'state', event.taskList.state, event.taskList.id);
        return Task(
          id: event.taskList.id,
          title: event.taskList.title,
          desc: event.taskList.desc,
          state: event.taskList.state,
        );
      }
      return todoModel;
    }).toList();
    emit(state.copyWith(taskModel: list));
  }
}
