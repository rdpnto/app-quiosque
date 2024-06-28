import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/core/app_state.dart';
import 'package:mobile/domain/model/resource.dart';
import 'package:provider/provider.dart';

class DomainPage extends StatelessWidget {
  void showEntityDialog(BuildContext context, {Resource? resource}) {
    final nameController = TextEditingController(text: resource?.name);
    final descriptionController = TextEditingController(text: resource?.description);
    final isEmployeeController = TextEditingController(text: resource?.isEmployee.toString());
    final salaryController = TextEditingController(text: resource?.salary?.toStringAsFixed(2));

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(resource == null ? 'Adicionar Entidade' : 'Editar'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Descrição'),
              ),
              SwitchListTile(
                title: const Text('Funcionário'),
                value: isEmployeeController.text == 'true',
                onChanged: (bool value) {
                  isEmployeeController.text = value.toString();
                },
              ),
              TextField(
                controller: salaryController,
                decoration: InputDecoration(labelText: 'Salário', ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isEmpty) return;

                var appState = Provider.of<AppState>(context, listen: false);

                await appState.insertResource(
                  nameController.text,
                  descriptionController.text,
                  isEmployeeController.text == 'true',
                  double.tryParse(salaryController.text) ?? 0
                );

                await appState.getResources();

                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              child: Text(resource == null ? 'Adicionar' : 'Atualizar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    var resources = appState.resources;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Entidades'),
        backgroundColor: Color.fromARGB(255, 174, 196, 164),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async => await appState.getResources()
          )
        ]
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: resources.length,
                itemBuilder: (context, index) {
                  final entity = resources[index];
                  return ListTile(
                    title: Text(entity.name),
                    subtitle: Text(entity.description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => showEntityDialog(context, resource: entity),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            await appState.deleteResource(entity.name);
                            await appState.getResources();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () => showEntityDialog(context),
              child: Text('Adicionar Entidade'),
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Configuração de Domínio'),
  //       actions: []
  //     ),
  //     body: DomainPage(),
  //   );
  // }
}
