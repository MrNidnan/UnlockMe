import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String?> getAddressFromCoordinates(
    double latitude, double longitude) async {
  final url = Uri.parse(
      'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['display_name'];
  } else {
    throw Exception('Failed to load address');
  }
}
