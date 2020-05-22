import 'package:mobx/mobx.dart';

part 'item_model.g.dart';

class ItemModel extends _ItemModelBase with _$ItemModel{
  ItemModel({
    String title,
    bool check,

  }) : super (
    title: title,
    check: check
  );
  factory ItemModel.fromJson(Map<dynamic, dynamic> json) => ItemModel(
    title: json['title'], 
    check: json['check']);

  Map<String, dynamic> toJson() => {
    'title': title,
    'check': check 
  };
}

abstract class _ItemModelBase with Store {
  _ItemModelBase({this.check = false, this.title});

  @observable
  String title;
  @action
  setTitle(String value) => title = value;

  @observable
  bool check;
  @action
  setCheck(bool value) => check = value;
  
  
}