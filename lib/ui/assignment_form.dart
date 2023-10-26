// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:responsi1b/bloc/assignment_bloc.dart';
import 'package:responsi1b/model/assignment.dart';
import 'package:responsi1b/ui/assignment_page.dart';
import 'package:responsi1b/widget/warning_dialog.dart';

class AssignmentForm extends StatefulWidget {
  Assignment? assignment;

  AssignmentForm({Key? key, this.assignment}) : super(key: key);

  @override
  _AssignmentFormState createState() => _AssignmentFormState();
}

class _AssignmentFormState extends State<AssignmentForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "New Assignment";
  String tombolSubmit = "Create";

  final _titleTextboxController = TextEditingController();
  final _descriptionTextboxController = TextEditingController();
  final _deadlineTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.assignment != null) {
      setState(() {
        judul = "Edit Assignment";
        tombolSubmit = "Edit";
        _titleTextboxController.text = widget.assignment!.title!;
        _descriptionTextboxController.text = widget.assignment!.description!;
        _deadlineTextboxController.text = widget.assignment!.deadline!;
      });
    } else {
      judul = "Create Assignment";
      tombolSubmit = "Create";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _titleTextField(),
                _descriptionTextField(),
                _deadlineTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Title"),
      keyboardType: TextInputType.text,
      controller: _titleTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Title harus diisi";
        }
        return null;
      },
    );
  }

  Widget _descriptionTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Description"),
      keyboardType: TextInputType.text,
      controller: _descriptionTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Description harus diisi";
        }
        return null;
      },
    );
  }

  Widget _deadlineTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Deadline"),
      keyboardType: TextInputType.text,
      controller: _deadlineTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Deadline harus diisi";
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return OutlinedButton(
      child: Text(tombolSubmit),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            if (widget.assignment != null) {
              ubah();
            } else {
              simpan();
            }
          }
        }
      },
    );
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Assignment createAssignment = Assignment(id: null);
    createAssignment.title = _titleTextboxController.text;
    createAssignment.description = _descriptionTextboxController.text;
    createAssignment.deadline = _deadlineTextboxController.text;
    AssignmentBloc.addAssignment(assignment: createAssignment).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const AssignmentPage()));
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Simpan gagal, silahkan coba lagi",
        ),
      );
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Assignment updateAssignment = Assignment(id: null);
    updateAssignment.id = widget.assignment!.id;
    updateAssignment.title = _titleTextboxController.text;
    updateAssignment.description = _descriptionTextboxController.text;
    updateAssignment.deadline = _deadlineTextboxController.text;
    AssignmentBloc.updateAssignment(assignment: updateAssignment).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const AssignmentPage()));
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Permintaan ubah data gagal, silahkan coba lagi",
        ),
      );
    });
    setState(() {
      _isLoading = false;
    });
  }
}
