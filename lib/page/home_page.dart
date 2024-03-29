import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lista_tarefas/widget/change_theme_button.dart';
import 'package:lista_tarefas/page/controllers/controllers.dart';
import 'components/create_item_tile.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key, required this.title});

  final String title;

  final getController = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shadowColor: Theme.of(context).iconTheme.color,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).appBarTheme.titleTextStyle?.color,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 4,
        actions: const [
          ChangeThemeButtonWidget(),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: FloatingActionButton(
          foregroundColor: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).iconTheme.color,
          child: const Icon(Icons.add_outlined),
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
                      controller: controllerTarefa,
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          getController.salvarTarefa();
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color?>(
                                Theme.of(context).iconTheme.color)),
                        child: Text(
                          "Salvar",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color?>(
                                Theme.of(context).iconTheme.color)),
                        child: Text(
                          "Cancelar",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  );
                });
          }),
      body: Column(
        children: <Widget>[
          GetBuilder<Controller>(
            builder: (controller) {
              return Expanded(
                  child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  color: Colors.purple.withAlpha(100),
                ),
                itemCount: controller.listaTarefas.length,
                itemBuilder: criarItemLista,
              ));
            },
          )
        ],
      ),
    );
  }
}

TextEditingController controllerTarefa = TextEditingController();
