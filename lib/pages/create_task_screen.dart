import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/provider/create_provider.dart';

import '../models/task_model.dart';

class CreateScreen extends StatefulWidget {
  Task? task;

  CreateScreen({this.task, Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  String name = '', description = '', startTime = '', endTime = '';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _desController = TextEditingController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _nameController.text = widget.task?.name ?? '';
      _desController.text = widget.task?.description ?? '';
      _startController.text = widget.task?.startTime ?? '';
      _endController.text = widget.task?.endTime ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CreateProvider>(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text(widget.task == null ? 'Create task' : 'Update task'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Form(
          key: formKey,
          child: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8).copyWith(left: 20, right: 20),
                child: TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(color: Colors.white, fontSize: 30),
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: "Name",
                    fillColor: Colors.white,
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      letterSpacing: 3,
                    ),
                  ),
                  validator: (val) => val!.isEmpty ? 'Enter First name' : null,
                  onSaved: (val) => name = val!,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8).copyWith(left: 20, right: 20),
                child: TextFormField(
                  controller: _desController,
                  style: const TextStyle(color: Colors.white, fontSize: 30),
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: "description",
                    fillColor: Colors.white,
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      letterSpacing: 3,
                    ),
                  ),
                  validator: (val) =>
                      val!.isEmpty ? 'Enter First description' : null,
                  onSaved: (val) => description = val!,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8).copyWith(left: 20, right: 20),
                child: TextFormField(
                  controller: _startController,
                  style: const TextStyle(color: Colors.white, fontSize: 30),
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: "Start time",
                    fillColor: Colors.white,
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      letterSpacing: 3,
                    ),
                  ),
                  validator: (val) =>
                      val!.isEmpty ? 'Enter First start time' : null,
                  onSaved: (val) => startTime = val!,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8).copyWith(left: 20, right: 20),
                child: TextFormField(
                  controller: _endController,
                  style: const TextStyle(color: Colors.white, fontSize: 30),
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: "End time",
                    fillColor: Colors.white,
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      letterSpacing: 3,
                    ),
                  ),
                  validator: (val) =>
                      val!.isEmpty ? 'Enter First end time' : null,
                  onSaved: (val) => endTime = val!,
                ),
              ),
            ],
          ))),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            widget.task == null
                ? provider.insertTask(createTask())
                : provider.updateTask(upDateTask());
            ScaffoldMessenger.of(context).showSnackBar(
                showSnackBar(widget.task == null ? 'saved' : 'updated'));
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(showSnackBar('space free'));
          }
        },
        child: Icon(widget.task == null ? Icons.add : Icons.update, size: 40),
      ),
    );
  }

  Task createTask() {
    Task task = Task(
      description: description,
      endTime: endTime,
      startTime: startTime,
      name: name,
    );
    return task;
  }

  Task upDateTask() {
    Task task = Task.withId(
      id: widget.task?.id,
      description: description,
      endTime: endTime,
      startTime: startTime,
      name: name,
    );
    return task;
  }

  showSnackBar(String text) {
    return SnackBar(content: Text(text));
  }

  Widget taskName({
    required String title,
    required TextEditingController controller,
  }) {
    return Container(
      padding: const EdgeInsets.all(8).copyWith(left: 20, right: 20),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white, fontSize: 30),
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          labelText: title,
          fillColor: Colors.green,
          labelStyle: const TextStyle(
            color: Colors.green,
            fontSize: 14,
            letterSpacing: 3,
          ),
        ),
      ),
    );
  }
}
