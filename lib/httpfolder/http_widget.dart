import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cocktails_jdgr/httpfolder/user_response.dart';

class HttpWidget extends StatelessWidget {
  const HttpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exemple HTTP'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            //_peticioHttp();
            //_peticioHttpJsonDecode();
            _peticioHttpMapejada();
          },
          child: const Text('Fes petició HTTP'),
        ),
      ),
    );
  }
}

_peticioHttp() {
  // Podrem veure el valor també, fent el Debug
  final url = Uri.https('reqres.in', 'api/users', {'page': '2'});
  http.get(url).then((value) => print(value.body));
}

_peticioHttpJsonDecode() {
  // Podrem veure el valor també, fent el Debug
  // Error en declarar la Uri!!! (No donava error,
  // per que l'API te un unknown per defecte)
  //final url = Uri.https('reqres.in', 'api/users?page=2');
  // Declaració correcte
  final url = Uri.https('reqres.in', 'api/users', {'page': '2'});
  http.get(url).then((res) {
    final body = jsonDecode(res.body);
    print(body);
    print('Page: ${body['page']}');
    print('Objecte en 3er lloc: ${body['data'][2]}');
    print('ID objecte en tercer lloc: ${body['data'][2]['id']}');
  });
}

_peticioHttpMapejada() async {
  final url = Uri.https('reqres.in', 'api/users', {'page': '2'});
  final response = await http.get(url);

  final userResponse = UsersResponse.fromJson(response.body);
  print('Page: ${userResponse.page}');
  print('Objecte en 3er lloc: ${userResponse.users[2]}');
  print('ID objecte en tercer lloc: ${userResponse.users[2].id}');
}
