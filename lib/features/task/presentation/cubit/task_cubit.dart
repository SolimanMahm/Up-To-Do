import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/database/sqflite_helper/sqflite_helper.dart';
import 'package:to_do_app/features/task/presentation/cubit/task_state.dart';
import 'package:to_do_app/core/services/service_locator.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/model/task_model.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  DateTime cuurentDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  String StartTime = DateFormat('hh:mm a').format(DateTime.now());
  String endTime =
      DateFormat('hh:mm a').format(DateTime.now().add(Duration(minutes: 45)));
  TextEditingController titleController = TextEditingController();

  TextEditingController noteController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<Color> color = [
    AppColors.red,
    AppColors.green,
    AppColors.blueGrey,
    AppColors.blue,
    AppColors.orange,
    AppColors.purple,
  ];

  List<TaskModel> tasks = [];

  int currentIndex = 0;

  void getDate(context) async {
    emit(GetDateLoadingState());
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2040),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    if (pickedDate != null) {
      cuurentDate = pickedDate;
      emit(GetDateSuccessState());
    }
  }

  void getStartTime(context) async {
    emit(GetStartTimeLoadingState());
    TimeOfDay? pickedStartTime = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(DateTime.now()));
    if (pickedStartTime != null) {
      StartTime = pickedStartTime.format(context);
      emit(GetStartTimeSuccessState());
    }
  }

  void getEndTime(context) async {
    emit(GetEndTimeLoadingState());
    TimeOfDay? pickedEndTime = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(DateTime.now()));
    if (pickedEndTime != null) {
      endTime = pickedEndTime.format(context);
      emit(GetEndTimeSuccessState());
    }
  }

  void getColor(index) {
    currentIndex = index;
    emit(GetColor());
  }

  void insertTask() async {
    emit(InsertTaskLoadingState());
    try {
      await Future.delayed(Duration(seconds: 1));
      sl<SqfliteHelper>().insertToDB(
        TaskModel(
          title: titleController.text,
          note: noteController.text,
          startTime: StartTime,
          endTime: endTime,
          date: DateFormat.yMd().format(cuurentDate),
          isComoleted: 0,
          color: currentIndex,
        ),
      );
      getTasks();
      titleController.clear();
      noteController.clear();
      cuurentDate = DateTime.now();
      StartTime = DateFormat('hh:mm a').format(DateTime.now());
      endTime = DateFormat('hh:mm a')
          .format(DateTime.now().add(Duration(minutes: 45)));
      emit(InsertTaskSuccessState());
    } catch (e) {
      emit(InsertTaskErrorState());
    }
  }

  void getTasks() async {
    emit(GetTaskLoadingState());
    await sl<SqfliteHelper>().getFromDB().then((value) {
      tasks = value
          .map((e) => TaskModel.fromJson(e))
          .toList()
          .where(
            (element) => element.date == DateFormat.yMd().format(selectedDate),
          )
          .toList();
      emit(GetTaskSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(GetTaskErrorState());
    });
  }

  void updateTask(index) async {
    emit(UpdateTaskLoadingState());
    await sl<SqfliteHelper>().updatedDB(tasks[index].id!).then((value) {
      emit(UpdateTaskSuccessState());
      getTasks();
    }).catchError((e) {
      print(e.toString());
      emit(UpdateTaskErrorState());
    });
  }

  void deleteTask(index) async {
    emit(DeleteTaskLoadingState());
    await sl<SqfliteHelper>().deleteFromDB(tasks[index].id!).then((value) {
      emit(DeleteTaskSuccessState());
      getTasks();
    }).catchError((e) {
      print(e.toString());
      emit(DeleteTaskErrorState());
    });
  }

  void getSelectedDate(date) {
    emit(GetSelectedDateLoadingState());
    selectedDate = date;
    emit(GetSelectedDateSuccessState());
    getTasks();
  }
}
