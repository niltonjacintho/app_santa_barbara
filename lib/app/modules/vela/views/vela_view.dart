import 'package:app2021/app/controllers/styles_controller.dart';
import 'package:app2021/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:app2021/app/modules/vela/controllers/vela_controller.dart';

class VelaView extends GetView<VelaController> {
  //use 'controller' variable to access controller
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  //final format = DateFormat("dd/MM/yyyy");
  VelaController velaController = Get.put(VelaController());
  StylesController stylesController = Get.put(StylesController());

  @override
  Widget build(BuildContext context) {
    var _selectedIndex = 0;
    velaController.getTiposPedidos();
    velaController.novaVela();
    return Scaffold(
      appBar: AppBar(
        title: Text("Vela Virtual"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            FormBuilder(
              // context,
              key: _fbKey,
              //  readOnly: false,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 15),
                  FormBuilderTextField(
                    style: TextStyle(fontSize: 22),
                    maxLines: 2,
                    name: "nome",
                    keyboardType: TextInputType.multiline,
                    // attribute: "para",
                    decoration: InputDecoration(
                        labelText: "Você esta pedindo para quem?",
                        labelStyle: stylesController.formLabel),
                    onChanged: (value) {
                      velaController.velaAtual.destinatario = value;
                    },
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        context,
                        errorText: 'Por favor, diga-nos para quem é o pedido',
                      ),
                    ]),

                    valueTransformer: (text) {
                      return text == null ? null : num.tryParse(text);
                    },
                  ),
                  FormBuilderTextField(
                    style: TextStyle(fontSize: 22),
                    name: "pedido",
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelText: "Escreva o seu pedido.",
                      labelStyle: stylesController.formLabel,
                    ),
                    onChanged: (value) {
                      velaController.velaAtual.texto = value;
                    },
                    valueTransformer: (text) {
                      return text == null ? null : num.tryParse(text);
                    },
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
            ButtonBar(
              children: <Widget>[
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromWidth(160),
                    primary: Colors.teal,
                    onPrimary: Colors.white,
                    onSurface: Colors.grey,
                  ),
                  label: Text(
                    'Acender',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  icon: Icon(Icons.star),
                  onPressed: () async {
                    if (_fbKey.currentState.saveAndValidate()) {
                      await velaController.gravar();
                      Get.toNamed(Routes.VELAACESA);
                    }
                  },
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromWidth(160),
                    primary: Colors.red,
                    onPrimary: Colors.white,
                    onSurface: Colors.grey,
                  ),
                  label: Text(
                    'Sair',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  icon: Icon(Icons.close),
                  onPressed: () async {
                    Get.toNamed(Routes.HOME);
                  },
                  //),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
