import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../../models/item_model.dart';
import '../../shared/repositories/localStorage/locale_storage_interface.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  ItemModel item;
  final ILocaleStorage _storage = Modular.get();

  _HomeControllerBase() {
    init();
  }

  @observable
  ObservableList<ItemModel> listItems = ObservableList<ItemModel>();

  init() async {
    var listLocal = await _storage.get();
    if (listLocal == null) {
      listItems = <ItemModel>[].asObservable();
    } else {
      listItems.addAll(listLocal);
    }
  }

  @action
  void save(ItemModel item) {
    item.setCheck(false);
    listItems.add(item);
    _storage.put('list', item);
  }

  @action
  void remove(int index) {
    listItems.removeAt(index);
    _storage.put('list', listItems[index]);
  }
}
