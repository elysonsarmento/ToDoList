import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../../models/item_model.dart';
import '../../shared/repositories/localStorage/locale_storage_interface.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {

  final ILocaleStorage _storage = Modular.get();

  @observable
  ObservableList<ItemModel> listItems = <ItemModel>[]
  .asObservable();

  _HomeControllerBase(){
  init();
  }

  @computed
  int get totalChecked => listItems.where((element) => element.check).length;

  @computed
  ObservableList<ItemModel> get listFiltered{
    if(filter.isEmpty){
      return listItems;
    } else{
      return listItems.where((element) => element.title
      .toLowerCase()
      .contains(filter))
      .toList();
    }

}
  @observable
  String filter = ''; 

  @action
  setFilter(String value) => filter = value;

  @action
  init() async{
    var listLocal = await _storage.get('list');
    if(listLocal == null){
      listItems = <ItemModel>[].asObservable();
    }else {
      listItems = listLocal;
    }

  }

  @action
  addItem(ItemModel model) {
    listItems.add(model);
    _storage.put('list', model);
  }

  @action
  removeItem(ItemModel model) {
    listItems.removeWhere((element) => element.title == model.title);
        _storage.put('list', model);

  }
}
