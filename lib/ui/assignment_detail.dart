import 'package:flutter/material.dart';
import 'package:responsi1b/bloc/assignment_bloc.dart';
import 'package:responsi1b/model/assignment.dart';
import 'package:responsi1b/ui/assignment_form.dart';
import 'package:responsi1b/ui/assignment_page.dart';
import 'package:responsi1b/widget/warning_dialog.dart';

// ignore: must_be_immutable
class AssignmentDetail extends StatefulWidget {
  Assignment? assignment;

  AssignmentDetail({Key? key, this.assignment}) : super(key: key);

  @override
  _AssignmentDetailState createState() => _AssignmentDetailState();
}

class _AssignmentDetailState extends State<AssignmentDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Assignment'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Title : ${widget.assignment!.title}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Description : ${widget.assignment!.description}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Deadline : ${widget.assignment!.deadline}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AssignmentForm(
                  assignment: widget.assignment!,
                ),
              ),
            );
          },
        ),
        OutlinedButton(
          child: const Text("Delete"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            AssignmentBloc.deleteAssignment(id: widget.assignment!.id)
                .then((value) {
              if (value) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AssignmentPage(),
                ));
              } else {
                showDialog(
                  context: context,
                  builder: (context) => const WarningDialog(
                    description: "Data gagal dihapus",
                  ),
                );
              }
            }).catchError((error) {});
          },
        ),
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
