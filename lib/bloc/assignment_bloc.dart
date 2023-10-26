import 'dart:convert';

import 'package:responsi1b/helpers/api.dart';
import 'package:responsi1b/helpers/api_url.dart';
import 'package:responsi1b/model/assignment.dart';

class AssignmentBloc {
  static Future<List<Assignment>> getAssignment() async {
    String apiUrl = ApiUrl.listAssignment;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<Assignment> assignment = [];
    if (jsonObj['result'] != null) {
      List<dynamic> listAssignment = jsonObj['result'];
      for (int i = 0; i < listAssignment.length; i++) {
        assignment.add(Assignment.fromJson(listAssignment[i]));
      }
    } else {
      print("Data not found in the API response.");
    }

    return assignment;
  }

  static Future addAssignment({Assignment? assignment}) async {
    String apiUrl = ApiUrl.createAssignment;

    var body = {
      "title": assignment!.title,
      "description": assignment.description,
      "deadline": assignment.deadline,
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['message'];
  }

  static Future<bool> updateAssignment({required Assignment assignment}) async {
    try {
      String apiUrl = ApiUrl.updateAssignment(assignment.id!);

      var body = {
        "title": assignment.title,
        "description": assignment.description,
        "deadline": assignment.deadline,
      };

      var response = await Api().post(apiUrl, body);
      var jsonObj = json.decode(response.body);

      if (jsonObj.containsKey('status') && jsonObj['status'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print("Error in updateAssignment: $error");
      return false;
    }
  }

  static Future<bool> deleteAssignment({int? id}) async {
    String apiUrl = ApiUrl.deleteAssignment(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['result'];
  }
}
