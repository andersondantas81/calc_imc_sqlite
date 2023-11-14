import 'package:calc_imc_sqlite/model/imcModel.dart';
import 'package:calc_imc_sqlite/repository/imc_repository.dart';
import 'package:flutter/material.dart';

class Lista extends StatefulWidget {
  const Lista({super.key});

  @override
  State<Lista> createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  IMCRepository imcRepository = IMCRepository();
  var imcs = const <IMCModel>[];

  @override
  void initState() {
    super.initState();
    obterIMC();
  }

  void obterIMC() async {
    imcs = await imcRepository.obterDados();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Listagens das últimas consultas"),
          ),
          body: ListView.separated(
            itemCount: imcs.length,
            padding: const EdgeInsets.all(16),
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  leading: Text(imcs[index].altura.toString()),
                  subtitle: Text(imcs[index].peso.toString()),
                  title: Text(imcs[index].classificacao),
                  trailing: IconButton(
                      onPressed: () async {
                        await imcRepository.remover(imcs[index].id);
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: ((_) => Lista())));
                      },
                      icon: const Icon(Icons.delete)));
            },
          )),
    );
  }
}
