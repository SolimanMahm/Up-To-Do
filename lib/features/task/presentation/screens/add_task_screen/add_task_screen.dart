import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/core/utils/app_strings.dart';
import 'package:to_do_app/core/widgets/custom_button.dart';
import 'package:to_do_app/features/task/presentation/cubit/task_cubit.dart';
import 'package:to_do_app/features/task/presentation/cubit/task_state.dart';

import '../../../../../core/commons/commons.dart';
import '../../components/add_task_components.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          AppStrings.addTask,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BlocConsumer<TaskCubit, TaskState>(
            listener: (context, state) => (state is InsertTaskSuccessState)
                ? {
                    showToast(
                      message: 'Added Successfully',
                      state: ToastStates.success,
                    ),
                    Navigator.pop(context)
                  }
                : null,
            builder: (context, state) => Form(
              key: BlocProvider.of<TaskCubit>(context).formKey,
              child: Column(
                children: [
                  SizedBox(height: 48.h),
                  // Title
                  AddTaskComponent(
                    controller:
                        BlocProvider.of<TaskCubit>(context).titleController,
                    title: AppStrings.title,
                    hint: AppStrings.titleHint,
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return AppStrings.titleErrorMsg;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24.h),
                  // Note
                  AddTaskComponent(
                    controller:
                        BlocProvider.of<TaskCubit>(context).noteController,
                    title: AppStrings.note,
                    hint: AppStrings.noteHint,
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return AppStrings.noteErrorMsg;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24.h),
                  // Date
                  AddTaskComponent(
                    readOnly: true,
                    title: AppStrings.date,
                    hint: DateFormat.yMd().format(
                        BlocProvider.of<TaskCubit>(context).cuurentDate),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        BlocProvider.of<TaskCubit>(context).getDate(context);
                      },
                      icon: Icon(
                        Icons.calendar_month_outlined,
                        color: AppColors.text,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  // Time
                  Row(
                    children: [
                      // Start
                      AddTaskComponent(
                        width: 150,
                        readOnly: true,
                        title: AppStrings.startTime,
                        hint: BlocProvider.of<TaskCubit>(context).StartTime,
                        suffixIcon: IconButton(
                          onPressed: () async {
                            BlocProvider.of<TaskCubit>(context)
                                .getStartTime(context);
                          },
                          icon: Icon(
                            Icons.timer_outlined,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                      SizedBox(width: 27.w),
                      // End
                      AddTaskComponent(
                        width: 150,
                        readOnly: true,
                        title: AppStrings.endTime,
                        hint: BlocProvider.of<TaskCubit>(context).endTime,
                        suffixIcon: IconButton(
                          onPressed: () async {
                            BlocProvider.of<TaskCubit>(context)
                                .getEndTime(context);
                          },
                          icon: Icon(
                            Icons.timer_outlined,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  // Color
                  SizedBox(
                    height: 68.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.color,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        SizedBox(height: 8.h),
                        Expanded(
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: BlocProvider.of<TaskCubit>(context)
                                .color
                                .length,
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 20.w),
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                BlocProvider.of<TaskCubit>(context)
                                    .getColor(index);
                              },
                              child: CircleAvatar(
                                backgroundColor:
                                    BlocProvider.of<TaskCubit>(context)
                                        .color[index],
                                child: (BlocProvider.of<TaskCubit>(context)
                                            .currentIndex ==
                                        index)
                                    ? Icon(
                                        Icons.check,
                                        color: AppColors.text,
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // Button
                  SizedBox(height: 92.h),
                  (state is InsertTaskLoadingState)
                      ? CircularProgressIndicator()
                      : SizedBox(
                          height: 48.h,
                          width: double.infinity.w,
                          child: CustomButton(
                            text: AppStrings.createTask,
                            onPressed: () {
                              if (BlocProvider.of<TaskCubit>(context)
                                  .formKey
                                  .currentState!
                                  .validate()) {
                                BlocProvider.of<TaskCubit>(context)
                                    .insertTask();
                              }
                            },
                            redius: 4,
                            color: AppColors.rectangleButton,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
