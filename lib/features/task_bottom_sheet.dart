import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_c10_sun_4pm/core/config/constants.dart';
import 'package:todo_app_c10_sun_4pm/core/network_layer/firebase_utils.dart';
import 'package:todo_app_c10_sun_4pm/core/services/snack_bar_service.dart';
import 'package:todo_app_c10_sun_4pm/core/utils/extract_date_time.dart';
import 'package:todo_app_c10_sun_4pm/core/widgets/custom_text_field.dart';
import 'package:todo_app_c10_sun_4pm/features/settings_provider.dart';
import 'package:todo_app_c10_sun_4pm/main.dart';
import 'package:todo_app_c10_sun_4pm/models/task_model.dart';

class TaskBottomSheet extends StatefulWidget {
  const TaskBottomSheet({super.key});

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SettingsProvider>(context);
    return Container(
      width: Constants.mediaQuery.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 25,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Add a new task",
              textAlign: TextAlign.center,
              style: Constants.theme.textTheme.titleLarge
                  ?.copyWith(color: vm.isDark() ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 25),
            CustomTextField(
              controller: titleController,
              hint: "enter task title",
              hintColor: Colors.grey.shade600,
              onValidate: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "you must enter task title";
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: descriptionController,
              hint: "enter task description",
              hintColor: Colors.grey.shade600,
              maxLines: 3,
              maxLength: 150,
              onValidate: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "you must enter task description";
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            Text(
              "Select Time",
              style: Constants.theme.textTheme.bodyMedium
                  ?.copyWith(color: vm.isDark() ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: () {
                vm.selectDateTime(context);
              },
              child: Text(
                DateFormat.yMMMMd().format(extractDateTime(vm.selectedDate)),
                textAlign: TextAlign.center,
                style: Constants.theme.textTheme.bodyMedium?.copyWith(
                    color: vm.isDark() ? Colors.white : Colors.grey.shade600,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Constants.theme.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  )),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  var taskModel = TaskModel(
                    title: titleController.text,
                    description: descriptionController.text,
                    isDone: false,
                    dateTime: extractDateTime(vm.selectedDate),
                  );
                  EasyLoading.show();
                  FirebaseUtils().addNewTask(taskModel).then((value) {
                    EasyLoading.dismiss();
                    SnackBarService.showSuccessMessage(
                        "Task successfully created");
                    navigatorKey.currentState!.pop();
                    vm.selectedDate = DateTime.now();
                  });
                }
              },
              child: Text(
                "Add Task",
                style: Constants.theme.textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
