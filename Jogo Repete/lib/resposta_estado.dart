import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RespostaEstado extends StatefulWidget {
  const RespostaEstado({Key? key}) : super(key: key);

  @override
  _RespostaEstadoState createState() => _RespostaEstadoState();
}

class _RespostaEstadoState extends State<RespostaEstado> {
  late Future<String> _textoFuturo;
  String value = "";
  int soma = 0;
  @override
  void initState() {
    super.initState();
    _textoFuturo = buscaTexto();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FutureBuilder<String>(
          future: _textoFuturo,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Houve um erro: ${snapshot.error}');
            } else {
              value = snapshot.data!;
              return Text(
                snapshot.data ?? '',
                style: TextStyle(fontSize: 48),
              );
            }
          },
        ),
        FutureBuilder<String>(
          future: _textoFuturo,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Houve um erro: ${snapshot.error}');
            } else {
              if (value == '2' || value == '4' || value == '6') {
                soma += int.parse(value);

                if (soma > 10) {
                  soma = 0;
                  return Text("Você perdeu!");
                } else if (soma == 10) {
                  soma = 0;
                  return Text("Você ganhou!");
                }

                return Text(soma.toString());
              } else if (value == '5') {
                return Text(soma.toString());
              } else if (value == '3' || value == '1') {
                return Text(soma.toString());
              }

              return Text("");
            }
          },
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _textoFuturo = buscaTexto();
            });
          },
          child: const Text('Novo!'),
        ),
      ],
    );
  }

  Text ProcessaSoma(int soma) {
    if (soma > 10) {
      soma = 0;
      return Text("Você perdeu!");
    } else if (soma == 10) {
      soma = 0;
      return Text("Você ganhou!");
    }

    return Text(soma.toString());
  }

  Future<String> buscaTexto() async {
    // URL de exemplo fornecida
    var url = Uri.parse(
        'https://472f3a4e-79fd-46a7-837e-6b3e9405af4e-00-2q2j49gpl5ud4.picard.replit.dev/');

    try {
      var resposta = await http.get(url);

      if (resposta.statusCode == 200) {
        var respostaJSON = jsonDecode(resposta.body);
        print(resposta.body);
        return respostaJSON['dado'];
      } else {
        print('Falha com estado: ${resposta.statusCode}.');
        return 'Erro na requisição';
      }
    } catch (e) {
      print('Erro na requisição: $e');
      return 'Erro na requisição';
    }
  }
}
