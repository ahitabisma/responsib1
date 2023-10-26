// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:responsi1b/bloc/assignment_bloc.dart';
import 'package:responsi1b/model/assignment.dart';
import 'package:responsi1b/ui/assignment_detail.dart';
import 'package:responsi1b/ui/assignment_form.dart';

class AssignmentPage extends StatefulWidget {
  const AssignmentPage({Key? key}) : super(key: key);

  @override
  _AssignmentPageState createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignment'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0),
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AssignmentForm()));
              },
            ),
          )
        ],
      ),
      body: FutureBuilder<List>(
        future: AssignmentBloc.getAssignment(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListAssignment(
                  list: snapshot.data,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ListAssignment extends StatelessWidget {
  final List? list;

  const ListAssignment({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list!.length,
      itemBuilder: (context, i) {
        return ItemAssignment(
          assignment: list![i],
        );
      },
    );
  }
}

class ItemAssignment extends StatelessWidget {
  final Assignment assignment;

  const ItemAssignment({Key? key, required this.assignment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AssignmentDetail(
                  assignment: assignment,
                  ),
            ),
          );
        },
        child: Card(
          child: ListTile(
            title: Text(assignment.title!),
            subtitle: Text(assignment.description!),
          ),
        ));
  }
}
