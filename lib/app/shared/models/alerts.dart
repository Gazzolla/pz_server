import 'package:fluent_ui/fluent_ui.dart';
import 'package:project_zomboid_server/app/shared/models/custom_suggestions.dart';

class Alert {
  static showErrorAlert(BuildContext context, String error) => showDialog(
        context: context,
        builder: (_) => ContentDialog(
          title: const Text("Erro Inesperado!"),
          content: Text("$error\nFavor Entrar em contato na página no GitHub"),
          actions: [Button(child: const Text('Ok'), onPressed: () => Navigator.pop(context))],
        ),
        barrierDismissible: true,
      );

  static showServerCreatedAlert(BuildContext context) => showDialog(
        context: context,
        builder: (_) => ContentDialog(
          content: const Text("Servidor Instalado com Sucesso"),
          actions: [Button(child: const Text('Ok'), onPressed: () => Navigator.pop(context))],
        ),
        barrierDismissible: true,
      );

  static showServerStarted(BuildContext context) => showDialog(
        context: context,
        builder: (_) => ContentDialog(
          content: const Text("Servidor Iniciado!"),
          actions: [Button(child: const Text('Ok'), onPressed: () => Navigator.pop(context))],
        ),
        barrierDismissible: true,
      );
  static Future getInputServerConfigs(BuildContext context) {
    Map result = {};
    return showDialog(
      context: context,
      builder: (_) => ContentDialog(
        content: IntrinsicHeight(
          child: Column(
            children: [
              const Text("Configurações Básicas do Servidor"),
              TextBox(
                placeholder: "Nome do Servidor",
                onChanged: (value) => result['serverName'] = value,
              ),
              CustomAutoSuggestBox(
                placeholder: "RAM Dedicada",
                items: [
                  for (var i = 1; i <= 64; i++) i.toString(),
                ],
                onChanged: (value, _) => result['ram'] = int.parse(value),
              )
            ],
          ),
        ),
        actions: [
          Button(
              child: const Text('Ok'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => ContentDialog(
                    title: const Text("Tem Certeza?"),
                    actions: [
                      Button(
                          child: const Text('Sim'),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context, result);
                          }),
                      Button(child: const Text('Não'), onPressed: () => Navigator.pop(context)),
                    ],
                  ),
                  barrierDismissible: true,
                );
              }),
          Button(child: const Text('Cancelar'), onPressed: () => Navigator.pop(context)),
        ],
      ),
      barrierDismissible: true,
    );
  }
}
