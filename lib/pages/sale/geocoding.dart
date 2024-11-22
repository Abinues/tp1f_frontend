import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, double>> getCoordinatesFromAddress(String address) async {
  final String url =
      'https://nominatim.openstreetmap.org/search?q=${Uri.encodeComponent(address)}&format=json&addressdetails=1&limit=1';

  final response =
      await http.get(Uri.parse(url), headers: {"User-Agent": "FlutterApp/1.0"});

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data.isNotEmpty) {
      final location = data[0];
      return {
        'latitude': double.parse(location['lat']),
        'longitude': double.parse(location['lon']),
      };
    } else {
      throw Exception('No se encontraron coordenadas para esta dirección.');
    }
  } else {
    throw Exception('Error al obtener las coordenadas: ${response.body}');
  }
}
