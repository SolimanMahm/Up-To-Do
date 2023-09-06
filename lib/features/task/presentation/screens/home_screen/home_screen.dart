import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/commons/commons.dart';
import 'package:to_do_app/core/utils/app_assets.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/core/utils/app_strings.dart';
import 'package:to_do_app/core/widgets/custom_button.dart';
import 'package:to_do_app/features/task/presentation/cubit/task_cubit.dart';
import 'package:to_do_app/features/task/presentation/cubit/task_state.dart';

import '../add_task_screen/add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(24),
          child: FloatingActionButton(
            onPressed: () {
              navigate(context: context, screen: AddTaskScreen());
            },
            child: Icon(Icons.add),
            backgroundColor: AppColors.circuleButton,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(24),
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontSize: 24,
                      ),
                ),
                SizedBox(height: 12),
                Text(
                  AppStrings.today,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontSize: 24,
                      ),
                ),
                SizedBox(height: 6),
                DatePicker(
                  DateTime.now(),
                  height: 110,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: AppColors.selectDay,
                  selectedTextColor: AppColors.text.withOpacity(.87),
                  monthTextStyle: Theme.of(context).textTheme.displayMedium!,
                  dateTextStyle: Theme.of(context).textTheme.displayMedium!,
                  dayTextStyle: Theme.of(context).textTheme.displayMedium!,
                  onDateChange: (date) {
                    BlocProvider.of<TaskCubit>(context).getSelectedDate(date);
                  },
                ),
                (BlocProvider.of<TaskCubit>(context).tasks.isEmpty)
                    ? noTasksWidget(context)
                    : Expanded(
                        child: ListView.builder(
                          itemCount:
                              BlocProvider.of<TaskCubit>(context).tasks.length,
                          itemBuilder: (BuildContext context, int index) =>
                              InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: 240,
                                          color: AppColors.second,
                                          child: Column(
                                            children: [
                                              SizedBox(height: 30),
                                              (BlocProvider.of<TaskCubit>(
                                                              context)
                                                          .tasks[index]
                                                          .isComoleted !=
                                                      1)
                                                  ? CustomButton(
                                                      text: AppStrings
                                                          .taskCompleted,
                                                      onPressed: () {
                                                        BlocProvider.of<
                                                                    TaskCubit>(
                                                                context)
                                                            .updateTask(index);
                                                        Navigator.pop(context);
                                                      },
                                                      size: Size(327, 48),
                                                      redius: 8,
                                                      color: AppColors
                                                          .rectangleButton,
                                                    )
                                                  : Container(),
                                              SizedBox(height: 24),
                                              CustomButton(
                                                text: AppStrings.deleteTask,
                                                onPressed: () {
                                                  BlocProvider.of<TaskCubit>(
                                                          context)
                                                      .deleteTask(index);
                                                  Navigator.pop(context);
                                                },
                                                size: Size(327, 48),
                                                redius: 8,
                                                color: AppColors.deletButton,
                                              ),
                                              SizedBox(height: 24),
                                              CustomButton(
                                                text: AppStrings.cancel,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                size: Size(327, 48),
                                                redius: 8,
                                                color:
                                                    AppColors.rectangleButton,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: TasksWidget(context, index)),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column noTasksWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 11, width: double.infinity),
        Image.asset(AppAssets.noTasks),
        SizedBox(height: 10),
        Text(
          AppStrings.noTaskTitle,
          style:
              Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 20),
        ),
        SizedBox(height: 10),
        Text(
          AppStrings.noTaskSubTitle,
          style:
              Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 16),
        ),
      ],
    );
  }

  Padding TasksWidget(BuildContext context, index) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Container(
        padding: EdgeInsets.all(8),
        height: 128,
        decoration: BoxDecoration(
          color: BlocProvider.of<TaskCubit>(context)
              .color[BlocProvider.of<TaskCubit>(context).tasks[index].color],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    BlocProvider.of<TaskCubit>(context).tasks[index].title,
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(fontSize: 24),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        color: AppColors.text.withOpacity(0.87),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '${BlocProvider.of<TaskCubit>(context).tasks[index].startTime} - ${BlocProvider.of<TaskCubit>(context).tasks[index].endTime}',
                        style: Theme.of(context).textTheme.displayMedium,
                      )
                    ],
                  ),
                  Text(
                    BlocProvider.of<TaskCubit>(context).tasks[index].note,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontSize: 24),
                  ),
                ],
              ),
            ),
            Container(
              height: 75,
              width: 1,
              color: AppColors.divider,
            ),
            SizedBox(width: 8),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                (BlocProvider.of<TaskCubit>(context).tasks[index].isComoleted ==
                        1)
                    ? AppStrings.completed
                    : AppStrings.toDo,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            )
          ],
        ),
      ),
    );
  }
}
