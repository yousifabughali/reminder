import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reminder_second_project/model/list_model.dart';
import 'package:reminder_second_project/providers/db_list_provider.dart';
import 'package:reminder_second_project/views/widgets/color_new_list.dart';

class AddNewList extends StatefulWidget {
  AddNewList({
    Key? key,
  }) : super(key: key);

  @override
  State<AddNewList> createState() => _AddNewListState();
}

class _AddNewListState extends State<AddNewList> {
  Color _color = Colors.blue;
  late TextEditingController _titleTextEditing;


  @override
  void initState() {
    super.initState();
    _titleTextEditing = TextEditingController();
  }

  @override
  void dispose() {
    _titleTextEditing.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                const Text(
                  'New List',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    performSave();
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: 170.h,
              decoration: BoxDecoration(
                color: Colors.blue.shade300,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          color: _color,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(
                          Icons.list,
                          size: 40,
                        ),
                      ),
                    ),
                     SizedBox(
                      height: 20.h,
                    ),
                    TextField(
                      textAlign: TextAlign.center,
                      controller: _titleTextEditing,
                      style: TextStyle(color: Colors.blue),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blue.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: 'List Name'.tr(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 70.h,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ColorPicker(
                        color: Colors.red, function: changeTheColorOfTheList),
                    ColorPicker(
                        color: Colors.orange,
                        function: changeTheColorOfTheList),
                    ColorPicker(
                        color: Colors.yellow,
                        function: changeTheColorOfTheList),
                    ColorPicker(
                        color: Colors.green, function: changeTheColorOfTheList),
                    ColorPicker(
                        color: Colors.blue, function: changeTheColorOfTheList),
                    ColorPicker(
                        color: Colors.purple,
                        function: changeTheColorOfTheList),
                    ColorPicker(
                        color: Colors.lime, function: changeTheColorOfTheList),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> performSave() async {
    if (CheckData()) {
      await save();
    }
  }

  bool CheckData() {
    if (_titleTextEditing.text.isNotEmpty) {
      return true;
    }
    showSnackBar(message: 'Enter required data', error: true);
    return false;
  }

  ListModel get list {
    ListModel newList = ListModel();
    newList.title = _titleTextEditing.text;
    newList.list_color = _color;
    return newList;
  }

  Future<void> save() async {
    bool created = await Provider.of<ListProvider>(context, listen: false)
        .create(list: list);
    if (created) {
      clear();
      Navigator.pop(context);
    }
    String message = created ? 'Created Successfully' : 'Created failed';
    showSnackBar(message: message, error: !created);
  }

  void showSnackBar({required String message, bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: error ? Colors.red : Colors.green,
    ));
  }

  void clear() {
    _titleTextEditing.text = '';
  }

  changeTheColorOfTheList(Color color) {
    setState(() {
      _color = color;
    });
  }
}
