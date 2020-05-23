import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../models/item_model.dart';
import 'home_controller.dart';
import 'item/item_widget.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add), onPressed: ()  {
            print ('${controller.listItems}');
            return _dialog();}),
        appBar: AppBar(
          title:
              TextField(decoration: InputDecoration(hintText: "Pesquisar...")),
              actions: <Widget>[
                IconButton(icon: Observer(builder: (_) {
                   return Text('${controller.listItems.length}');
                },
                ), onPressed: null)
              ],
        ),
        body: Observer(builder: (_) {
          return ListView.builder(
              itemCount: controller.listItems.length,
              itemBuilder: (_, index) {
                var item = controller.listItems[index];
                return ItemWidget(item: item, removeClicked: (){
                  controller.remove(index);
                },);
              });
        }));
  }

  _dialog() {
    final model = ItemModel();
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Adicionar Item'),
            content: TextField(
              onChanged: model.setTitle,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Novo Item',
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    controller.save(model);
                    return Navigator.pop(context);
                  },
                  child: Text('Salvar')),
              FlatButton(
                  onPressed: () {
                    return Navigator.pop(context);
                  },
                  child: Text('Cancelar')),
            ],
          );
        });
  }
}
