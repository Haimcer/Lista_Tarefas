import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:lista_tarefas/page/home_page.dart';
import 'package:path_provider/path_provider.dart';

class Controller extends GetxController {
  List listaTarefas = [].obs;
  Map<String, dynamic> ultimoTarefaRemovido = {};

  @override
  void onInit() {
    super.onInit();
    lerArquivo().then((dados) {
      listaTarefas = json.decode(dados);
      update();
    });
  }

  Future<File> getFile() async {
    final diretorio = await getApplicationDocumentsDirectory();

    return File('${diretorio.path}/dados.json');
  }

  salvarTarefa() {
    String textoDigitado = controllerTarefa.text;

    Map<String, dynamic> tarefa = {};
    tarefa["titulo"] = textoDigitado;
    tarefa["realizada"] = false;

    listaTarefas.add(tarefa);
    update();

    salvarArquivo();

    controllerTarefa.text = "";
  }

  salvarArquivo() async {
    var arquivo = await getFile();

    String dados = json.encode(listaTarefas);
    arquivo.writeAsString(dados);
    update();
  }

  lerArquivo() async {
    try {
      final arquivo = await getFile();
      return arquivo.readAsString();
    } catch (e) {
      return null;
    }
  }
}
