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
  Map<String, dynamic> _ultimoTarefaRemovido = Map();
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

  Widget criarItemLista(context, index) {
    //final item = _listaTarefas[index]['titulo'] ?? 0;
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        _ultimoTarefaRemovido = _listaTarefas[index];
        _listaTarefas.removeAt(index);
        _salvarArquivo();

        final snackBar = SnackBar(
          duration: Duration(seconds: 5),
          content: Text("Tarefa removida"),
          action: SnackBarAction(
              label: 'Desfazer',
              onPressed: () {
                setState(() {
                  _listaTarefas.insert(index, _ultimoTarefaRemovido);
                });
                _salvarArquivo();
              }),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.all(16),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Icon(
            Icons.delete,
            color: Colors.white,
          )
        ]),
      ),
      child: CheckboxListTile(
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
      ),
    );
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
            itemBuilder: criarItemLista,
          ))
        ],
      ),
    );
  }
}
