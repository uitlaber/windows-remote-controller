//import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Command {
  run(ip,cmd) async {
    var client = http.Client();
    try {
      await client
          .post('http://'+ip, body: {'cmd': cmd});
    } finally {
      client.close();
    }
  }
}


