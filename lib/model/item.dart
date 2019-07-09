import 'dart:convert';

class Product {
  final List<Success> success;
  Product({this.success});

  factory Product.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['success'] as List;
    
    print(list.runtimeType);
    List<Success> successList = list.map((i) => Success.fromJson(i)).toList();

    return Product(
      success: successList,
    );
  }
}

class Success {
  int reqId;
  int reqStatus;
  String project;
  String document;
  String desc;

  String originName;
  String originAddress;
  String destinationName;
  String destinationAddress;
  String created;

  Success(
      {this.reqId,
      this.reqStatus,
      this.project,
      this.document,
      this.desc,
      this.originName,
      this.originAddress,
      this.destinationName,
      this.destinationAddress});

  factory Success.fromJson(Map<String, dynamic> parsedJson) {
    return Success(
      reqId: parsedJson['req_id'],
      reqStatus: parsedJson['req_status'],
      project: parsedJson['project'],
      document: parsedJson['document'],
      desc: parsedJson['desc'],


      originName: parsedJson['origin_name'],
      originAddress: parsedJson['origin_address'],
      destinationName: parsedJson['destination_name'],
      destinationAddress: parsedJson['destination_address'],
    );
  }
}