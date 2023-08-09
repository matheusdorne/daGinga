import 'package:http/http.dart' as http;

void main() async {
  final client = http.Client();
  final response = await client.get(Uri.parse('https://search.reserve4me.de/api/status/details'));
  print(response.body);
}