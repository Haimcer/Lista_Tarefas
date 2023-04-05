import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lista_tarefas/page/controllers/controllers.dart';

Widget criarItemLista(context, index) {
  //final item = _listaTarefas[index]['titulo'] ?? 0;
  return GetBuilder<Controller>(builder: (getController) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        getController.ultimoTarefaRemovido = getController.listaTarefas[index];
        getController.listaTarefas.removeAt(index);
        getController.salvarArquivo();

        final snackBar = SnackBar(
          duration: const Duration(seconds: 5),
          content: const Text("Tarefa removida"),
          action: SnackBarAction(
              label: 'Desfazer',
              onPressed: () {
                getController.listaTarefas
                    .insert(index, getController.ultimoTarefaRemovido);
                getController.salvarArquivo();
              }),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      background: Container(
        color: Colors.red,
        padding: const EdgeInsets.all(16),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const <Widget>[
              Icon(
                Icons.delete,
                color: Colors.white,
              )
            ]),
      ),
      child: CheckboxListTile(
        side: const BorderSide(color: Colors.purple),
        activeColor: Theme.of(context).iconTheme.color,
        title: Text(
          getController.listaTarefas[index]['titulo'] ?? 0,
          style: TextStyle(
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        value: getController.listaTarefas[index]['realizada'],
        onChanged: (valorAlterado) {
          getController.listaTarefas[index]['realizada'] = valorAlterado;

          getController.salvarArquivo();
        },
      ),
    );
  });
}
