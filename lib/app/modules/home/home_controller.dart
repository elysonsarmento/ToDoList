import 'package:mobx/mobx.dart';
import '../../models/item_model.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  @observable
  List<ItemModel> listItems = [
    ItemModel(title: 'item 1', check: true),
    ItemModel(title: 'item 2', check: false),
    ItemModel(title: 'item 3', check: false),
  ].asObservable();

  @computed
  int get totalChecked => listItems.where((element) => element.check).length;

  @action
  addItem(ItemModel model) {
    listItems.add(model);
  }

  @action
  removeItem(ItemModel model) {
    listItems.removeWhere((element) => element.title == model.title);
  }
}
