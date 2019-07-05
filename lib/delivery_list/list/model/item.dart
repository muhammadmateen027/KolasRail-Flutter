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
  String userApprove;
  String userCreate;
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
      this.stockLoc,
      this.deliverLoc,
      this.created});

  factory Success.fromJson(Map<String, dynamic> parsedJson) {
    return Success(
      reqId: parsedJson['req_id'],
      reqStatus: parsedJson['req_status'],
      project: parsedJson['project'],
      document: parsedJson['document'],
      desc: parsedJson['desc'],
      userApprove: parsedJson['user_approve'],
      userCreate: parsedJson['user_create'],
      stockLoc: parsedJson['stock_loc'],
      deliverLoc: parsedJson['deliver_loc'],
      created: parsedJson['created'],
    );
  }
}

// class ItemModel {
//   List<Success> success;

//   ItemModel({this.success});

//   ItemModel.fromJson(Map<String, dynamic> json) {
//     if (json['success'] != null) {
//       success = new List<Success>();
//       json['success'].forEach((v) {
//         success.add(new Success.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.success != null) {
//       data['success'] = this.success.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Success {
//   int reqId;
//   int reqStatus;
//   String project;
//   String document;
//   String desc;
//   String userApprove;
//   String userCreate;
//   Null userRecevied;
//   String stockLoc;
//   String deliverLoc;
//   String created;

//   Success(
//       {this.reqId,
//       this.reqStatus,
//       this.project,
//       this.document,
//       this.desc,
//       this.userApprove,
//       this.userCreate,
//       this.userRecevied,
//       this.stockLoc,
//       this.deliverLoc,
//       this.created});

//   Success.fromJson(Map<String, dynamic> json) {
//     reqId = json['req_id'];
//     reqStatus = json['req_status'];
//     project = json['project'];
//     document = json['document'];
//     desc = json['desc'];
//     userApprove = json['user_approve'];
//     userCreate = json['user_create'];
//     userRecevied = json['user_recevied'];
//     stockLoc = json['stock_loc'];
//     deliverLoc = json['deliver_loc'];
//     created = json['created'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['req_id'] = this.reqId;
//     data['req_status'] = this.reqStatus;
//     data['project'] = this.project;
//     data['document'] = this.document;
//     data['desc'] = this.desc;
//     data['user_approve'] = this.userApprove;
//     data['user_create'] = this.userCreate;
//     data['user_recevied'] = this.userRecevied;
//     data['stock_loc'] = this.stockLoc;
//     data['deliver_loc'] = this.deliverLoc;
//     data['created'] = this.created;
//     return data;
//   }
// }

// // class ItemModel {
// //     int req_id;
// //     int req_status;
// //     String project;
// //     String document;
// //     String desc;
// //     String user_approve;
// //     String user_create;
// //     String user_recevied;
// //     String stock_loc;
// //     String deliver_loc;
// //     String created;

// //     ItemModel({
// //         this.req_id,
// //         this.req_status,
// //         this.project,
// //         this.document,
// //         this.desc,
// //         this.user_approve,
// //         this.user_create,
// //         this.user_recevied,
// //         this.stock_loc,
// //         this.deliver_loc,
// //         this.created,
// //     });

// //     factory ItemModel.fromJson(Map<String, dynamic> json) => new ItemModel(
// //         req_id: json["req_id"],
// //         req_status: json["req_status"],
// //         project: json["project"],
// //         document: json["document"],
// //         desc: json["desc"],
// //         user_approve: json["user_approve"],
// //         user_create: json["user_create"],
// //         user_recevied: json["user_recevied"],
// //         stock_loc: json["stock_loc"],
// //         deliver_loc: json["deliver_loc"],
// //         created: json["created"],
// //     );

// //     Map<String, dynamic> toJson() => {
// //         "req_id": req_id,
// //         "req_status": req_status,
// //         "project": project,
// //         "document": document,
// //         "desc": desc,
// //         "user_approve": user_approve,
// //         "user_create": user_create,
// //         "user_recevied": user_recevied,
// //         "stock_loc": stock_loc,
// //         "deliver_loc": deliver_loc,
// //         "created": created,
// //     };
// // }

// // List<ItemModel> ItemModelFromJson(String str) {
// //     final jsonData = json.decode(str);
// //     return new List<ItemModel>.from(jsonData.map((x) => ItemModel.fromJson(x)));
// // }

// // String ItemModelToJson(List<ItemModel> data) {
// //     final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
// //     return json.encode(dyn);
// // }
