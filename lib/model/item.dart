import 'dart:convert';

class Product {
  List<Success> success;

  Product({this.success});

  Product.fromJson(Map<String, dynamic> json) {
    if (json['success'] != null) {
      success = new List<Success>();
      json['success'].forEach((v) {
        success.add(new Success.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.success != null) {
      data['success'] = this.success.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Success {
  int reqId;
  int reqStatus;
  String project;
  String document;
  String desc;
  String createdAt;
  String createBy;
  String originName;
  String originCode;
  String originAddress;
  String originZip;
  String originState;
  String destinationName;
  String destinationCode;
  String destinationAddress;
  String destinationZip;
  String destinationState;

  Success(
      {this.reqId,
      this.reqStatus,
      this.project,
      this.document,
      this.desc,
      this.createdAt,
      this.createBy,
      this.originName,
      this.originCode,
      this.originAddress,
      this.originZip,
      this.originState,
      this.destinationName,
      this.destinationCode,
      this.destinationAddress,
      this.destinationZip,
      this.destinationState});

  Success.fromJson(Map<String, dynamic> json) {
    reqId = json['req_id'];
    reqStatus = json['req_status'];
    project = json['project'];
    document = json['document'];
    desc = json['desc'];
    createdAt = json['created_at'];
    createBy = json['create_by'];
    originName = json['origin_name'];
    originCode = json['origin_code'];
    originAddress = json['origin_address'];
    originZip = json['origin_zip'];
    originState = json['origin_state'];
    destinationName = json['destination_name'];
    destinationCode = json['destination_code'];
    destinationAddress = json['destination_address'];
    destinationZip = json['destination_zip'];
    destinationState = json['destination_state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['req_id'] = this.reqId;
    data['req_status'] = this.reqStatus;
    data['project'] = this.project;
    data['document'] = this.document;
    data['desc'] = this.desc;
    data['created_at'] = this.createdAt;
    data['create_by'] = this.createBy;
    data['origin_name'] = this.originName;
    data['origin_code'] = this.originCode;
    data['origin_address'] = this.originAddress;
    data['origin_zip'] = this.originZip;
    data['origin_state'] = this.originState;
    data['destination_name'] = this.destinationName;
    data['destination_code'] = this.destinationCode;
    data['destination_address'] = this.destinationAddress;
    data['destination_zip'] = this.destinationZip;
    data['destination_state'] = this.destinationState;
    return data;
  }
}