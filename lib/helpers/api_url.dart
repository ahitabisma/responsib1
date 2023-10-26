// ignore_for_file: prefer_interpolation_to_compose_strings

class ApiUrl {
  static const String baseUrl = "https://responsi1b.dalhaqq.xyz/api";

  static const String listAssignment = '$baseUrl/assignments';
  static const String createAssignment = '$baseUrl/assignments';

  static String updateAssignment(int id) {
    return '$baseUrl/assignments/$id/update';
  }

  static String showAssignment(int id) {
    return '$baseUrl/assignments/$id';
  }

  static String deleteAssignment(int id) {
    return '$baseUrl/assignments/$id/delete';
  }
}
