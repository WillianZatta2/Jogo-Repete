import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Resposta extends StatelessWidget {
  const Resposta({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var texto = geraSaida();
    return Column(
      children: [
        texto,
        ElevatedButton(
          onPressed: () {
            // tentar gerar novo texto

            texto = geraSaida();
          },
          child: const Text('novo!'),
        ),
      ],
    );
  }

  FutureBuilder<String> geraSaida() {
    return FutureBuilder(
        future: buscaTexto(),
        builder: (context, registro) {
          if (registro.hasData) {
            return Text(
              registro.data!,
              style: const TextStyle(
                fontSize: 48,
              ),
            );
          } else if (registro.hasError) {
            return const Text('Houve um erro');
          }
          return const CircularProgressIndicator();
        });
  }

  Future<String> buscaTexto() async {
    // receber da Internet
    // https://89251fa1-c1cc-432f-a9c6-f40c20048c08-00-fbjdp3ey1vbj.spock.replit.dev/
    var url = Uri.https(
        'https://472f3a4e-79fd-46a7-837e-6b3e9405af4e-00-2q2j49gpl5ud4.picard.replit.dev');

    var resposta = await http.get(url);

    if (resposta.statusCode == 200) {
      var respostaJSON = jsonDecode(resposta.body);
      print(resposta.body);
      // Gerar agora:
      return respostaJSON['dado'];
    } else {
      print('Falha com estado: ${resposta.statusCode}.');
      return 'erro';
    }
  }
}
