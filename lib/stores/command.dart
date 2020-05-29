//import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Command {
  run(cmd) async {
    var client = http.Client();
    try {
      await client
          .post('http://192.168.1.106:9988', body: {'cmd': cmd});
    } finally {
      client.close();
    }
  }
}


