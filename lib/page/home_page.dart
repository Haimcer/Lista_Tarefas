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
  List _listaTarefas = [];
  TextEditingController _controllerTarefa = TextEditingController();

  Future<File> _getFile() async {
    final diretorio = await getApplicationDocumentsDirectory();

    return File('${diretorio.path}/dados.json');
  }

  _salvarTarefa() {
    String textoDigitado = _controllerTarefa.text;

    Map<String, dynamic> tarefa = Map();
    tarefa["titulo"] = textoDigitado;
    tarefa["realizada"] = false;
    setState(() {
      _listaTarefas.add(tarefa);
    });

    _salvarArquivo();

    _controllerTarefa.text = "";
  }

  _salvarArquivo() async {
    var arquivo = await _getFile();

    String dados = json.encode(_listaTarefas);
    arquivo.writeAsString(dados);
  }

  _lerArquivo() async {
    try {
      final arquivo = await _getFile();
      return arquivo.readAsString();
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _lerArquivo().then((dados) {
      setState(() {
        _listaTarefas = json.decode(dados);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Theme.of(context).iconTheme.color,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          widget.title,
          style: TextStyle(
              color: Theme.of(context).appBarTheme.titleTextStyle?.color),
        ),
        elevation: 4,
        actions: [
          ChangeThemeButtonWidget(),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: FloatingActionButton(
          foregroundColor: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).iconTheme.color,
          child: Icon(Icons.add_outlined),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      'Adiconar Tarefa',
                      style:
                          TextStyle(color: Theme.of(context).iconTheme.color),
                    ),
                    content: TextField(
                      decoration: InputDecoration(
                          labelText: 'Digite sua tarefa',
                          labelStyle: TextStyle(
                              color: Theme.of(context).iconTheme.color)),
                      onChanged: (text) {},
                      controller: _controllerTarefa,
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          _salvarTarefa();
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Salvar",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
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
                            color: Theme.of(context).primaryColor,
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
                    return CheckboxListTile(
                      activeColor: Theme.of(context).iconTheme.color,
                      title: Text(
                        _listaTarefas[index]['titulo'] ?? 0,
                        style: TextStyle(
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                      value: _listaTarefas[index]['realizada'],
                      onChanged: (valorAlterado) {
                        setState(() {
                          _listaTarefas[index]['realizada'] = valorAlterado;
                        });
                        _salvarArquivo();
                      },
                    );
                    /*return ListTile(
                      title: Text(_listaTarefas[index]),
                    );*/
                  }))
        ],
      ),
    );
  }
}
