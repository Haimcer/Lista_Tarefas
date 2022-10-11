import 'package:flutter/material.dart';
import 'package:lista_tarefas/widget/change_theme_button.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:lista_tarefas/provider/theme_provider.dart';

class homePage extends StatefulWidget {
  const homePage({super.key, required this.title});

  final String title;

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  TextEditingController _controllerCampo = TextEditingController();

  List _listaTarefas = ['Ir ao mercado', 'Estudar'];

  Future<File?> _getFile() async {
    final diretorio = await getApplicationDocumentsDirectory();
    var arquivo = File('${diretorio.path}/dados.json');
  }

  _salvarArquivo() async {
    var arquivo = await _getFile();

    Map<String, dynamic> tarefa = Map();
    tarefa["titulo"] = "Ir ao mercado";
    tarefa["realizada"] = false;
    _listaTarefas.add(tarefa);

    String dados = json.encode(_listaTarefas);
    arquivo?.writeAsString(dados);
  }

  _lerArquivo() async {
    try {
      final arquivo = await _getFile();
      arquivo?.readAsString();
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _lerArquivo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.transparent,
        title: Text('Lista de tarefas'),
        elevation: 0,
        actions: [
          ChangeThemeButtonWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).iconTheme.color,
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Adiconar Tarefa'),
                    content: TextField(
                      decoration: InputDecoration(
                        labelText: 'Digite sua tarefa',
                      ),
                      onChanged: (text) {},
                      controller: _controllerCampo,
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Salvar",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color?>(
                                Theme.of(context).iconTheme.color)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancelar",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color?>(
                                Theme.of(context).iconTheme.color)),
                      ),
                    ],
                  );
                });
          }),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
                  itemCount: _listaTarefas.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_listaTarefas[index]),
                    );
                  }))
        ],
      ),
    );
  }
}
