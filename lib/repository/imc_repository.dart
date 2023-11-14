import 'package:calc_imc_sqlite/model/imcModel.dart';
import 'package:calc_imc_sqlite/repository/database.dart';
import 'package:calc_imc_sqlite/util/imc_classificacao.dart';

class IMCRepository {
  Classificacao classificar = Classificacao();
  String classificacao = "";

  Future<String> obterUltimoDado() async {
    var db = await DataBase().obterDataBase();
    var result = await db.rawQuery(
        "SELECT id, peso, altura, classificacao FROM imc ORDER BY ID DESC LIMIT 1");

    return result[0]["classificacao"].toString();
  }

  Future<List<IMCModel>> obterDados() async {
    List<IMCModel> imc = [];
    var db = await DataBase().obterDataBase();
    var result =
        await db.rawQuery("SELECT id, peso, altura, classificacao FROM imc");

    for (var element in result) {
      imc.add(IMCModel(
          int.parse(element["id"].toString()),
          double.parse(element["peso"].toString()),
          double.parse(element["altura"].toString()),
          element["classificacao"].toString()));
    }
    return imc;
  }

  Future<void> salvar(double peso, double altura) async {
    classificacao = classificar.classificar(peso, altura);

    var db = await DataBase().obterDataBase();
    var result = await db.rawInsert(
        "INSERT INTO imc (peso, altura, classificacao) VALUES(?, ?, ?)",
        [peso, altura, classificacao]);
  }

  /*
  Future<void> atualizar(double peso, double altura) async {
    classificacao = classificar.classificar(peso, altura);
    
    var db = await DataBase().obterDataBase();
    var result = await db.rawUpdate(
        "UPDATE imc set peso = ?, altura = ? classificacao = ? WHERE id = ?",
        [peso, altura, classificacao, id]);
  } */

  Future<void> remover(int id) async {
    var db = await DataBase().obterDataBase();
    var result = await db.rawDelete("DELETE FROM imc WHERE id = ?", [id]);
  }
}
