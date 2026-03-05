import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<Response> fetchReviews() async {
  var url = Uri.parse('http://127.0.0.1:8000/get-reviews');
  return http.get(url);
}
