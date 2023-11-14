import 'package:calc_imc_sqlite/pages/lista.dart';
import 'package:calc_imc_sqlite/repository/imc_repository.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  IMCRepository imcRepository = IMCRepository();
  var pesoController = TextEditingController(text: "");
  var alturaController = TextEditingController(text: "");
  String massa = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: const Text(
          "Calculadora IMC",
        )),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: ListView(children: [
            Column(children: [
              Container(
                  padding: const EdgeInsets.only(bottom: 70),
                  child: const Text("Calcule seu índice de massa corporal ")),
              Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(bottom: 8),
                        child: const Text("Peso"),
                      ),
                      TextField(controller: pesoController),
                    ],
                  )),
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        alignment: Alignment.center,
                        child: const Text("Altura"),
                      ),
                      TextField(controller: alturaController),
                    ],
                  ))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                height: 50,
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () async {
                    await imcRepository.salvar(
                        double.parse(pesoController.text),
                        double.parse(alturaController.text));
                    massa = await imcRepository.obterUltimoDado();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Sua massa corporal é $massa'),
                    ));

                    Navigator.push(
                        context, MaterialPageRoute(builder: ((_) => Lista())));
                  },
                  child: const Text(
                    "Calcular",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ]),
          ]),
        ),
      ),
    );
  }
}
