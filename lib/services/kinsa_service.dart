import 'package:http/http.dart' as http;
import '../models/kinsa.dart';

Future<http.Response> getLatestDate() async {
  final response = await http.get('https://static.kinsahealth.com/anomaly_map.json');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Kinsa.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to get latest Kinsa data.');
  }
}

Future<http.Response> getIllnessDataByState(String state) async {
  final response = await http.get('https://static.kinsahealth.com/${state}_data.json');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Kinsa.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to get Kinsa state date.');
  }
}