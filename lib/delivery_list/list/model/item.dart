class DeliveryItem {
  List<Success> success;

  DeliveryItem({this.success});

  DeliveryItem.fromJson(Map<String, dynamic> json) {
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
  String userApprove;
  String userCreate;
  Null userRecevied;
  String stockLoc;
  String deliverLoc;
  String created;

  Success(
      {this.reqId,
      this.reqStatus,
      this.project,
      this.document,
      this.desc,
      this.userApprove,
      this.userCreate,
      this.userRecevied,
      this.stockLoc,
      this.deliverLoc,
      this.created});

  Success.fromJson(Map<String, dynamic> json) {
    reqId = json['req_id'];
    reqStatus = json['req_status'];
    project = json['project'];
    document = json['document'];
    desc = json['desc'];
    userApprove = json['user_approve'];
    userCreate = json['user_create'];
    userRecevied = json['user_recevied'];
    stockLoc = json['stock_loc'];
    deliverLoc = json['deliver_loc'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['req_id'] = this.reqId;
    data['req_status'] = this.reqStatus;
    data['project'] = this.project;
    data['document'] = this.document;
    data['desc'] = this.desc;
    data['user_approve'] = this.userApprove;
    data['user_create'] = this.userCreate;
    data['user_recevied'] = this.userRecevied;
    data['stock_loc'] = this.stockLoc;
    data['deliver_loc'] = this.deliverLoc;
    data['created'] = this.created;
    return data;
  }
}