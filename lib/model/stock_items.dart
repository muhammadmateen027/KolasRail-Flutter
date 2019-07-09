import 'dart:convert';

class Stock {
  final List<Success> success;
  Stock({this.success});

  factory Stock.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['success'] as List;
    
    print(list.runtimeType);
    List<Success> successList = list.map((i) => Success.fromJson(i)).toList();

    return Stock(
      success: successList,
    );
  }
}

class Success {
  int rid;
  int stock_status;
  String comment;
  String qty;
  String app_qty;

  String app_comment;
  String iname;
  String sku;
  String category;
  String created;
  String unit;
  String added;

  Success(
      {this.rid,
      this.stock_status,
      this.comment,
      this.qty,
      this.app_qty,
      this.app_comment,
      this.iname,
      this.sku,
      this.category,
      this.unit,
      this.added});

  factory Success.fromJson(Map<String, dynamic> parsedJson) {
    return Success(
      rid: parsedJson['rid'],
      stock_status: parsedJson['stock_status'],
      comment: parsedJson['comment'],
      qty: parsedJson['qty'],
      app_qty: parsedJson['app_qty'],


      app_comment: parsedJson['app_comment'],
      iname: parsedJson['iname'],
      sku: parsedJson['sku'],
      category: parsedJson['category'],
      unit: parsedJson['unit'],
      added: parsedJson['added'],
    );
  }
}