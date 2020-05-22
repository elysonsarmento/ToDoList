import '../../../models/item_model.dart';

abstract class ILocaleStorage{

  Future<List<ItemModel>> get(String key);
  Future put(String key, ItemModel value);
  Future delete(String key);

}