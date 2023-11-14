// ignore_for_file: file_names, unnecessary_getters_setters
class IMCModel {
  int _id = 0;
  double _peso = 0;

  double _altura = 0;

  String _classificacao = "";

  IMCModel(this._id, this._peso, this._altura, this._classificacao);

  int get id => _id;
  double get peso => _peso;
  double get altura => _altura;
  String get classificacao => _classificacao;

  set id(int id) {
    _id - id;
  }

  set peso(double peso) {
    _peso = peso;
  }

  set altura(double altura) {
    _altura = altura;
  }

  set classificacao(String classificacao) {
    _classificacao = classificacao;
  }
}

//executa o comando: flutter pub run build_runner build