import 'dart:async';

import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import '../../../models/item_model.dart';

import 'locale_storage_interface.dart';

class LocalStorageHive implements ILocaleStorage{

  final Completer<Box> _instance = Completer<Box>();

  _init()async{
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    var box = Hive.openBox('db1');
    _instance.complete(box);
  }

  LocalStorageHive(){
    _init();
  }

  @override
  Future delete(String key) async {
    var box = await _instance.future;
    box.delete(key);
  }

  @override
  Future<ObservableList<ItemModel>> get(String key) async{
        var box = await _instance.future;
  return box.values.map((e) => ItemModel.fromJson(e)).toList();
    }
  
    @override
    Future put(String key, ItemModel value) async{
      var box = await _instance.future;
      box.put(key, value.toJson());

  }
  
}