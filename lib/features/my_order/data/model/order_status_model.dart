class OrderStatusModel {
  List<Orders>? orders;

  OrderStatusModel({this.orders});

  OrderStatusModel.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  int? id;
  int? shipmentType;
  String? pickupLocation;
  String? deleviryLocation;
  int? orderStatus;
  int? isValid;
  String? date;

  Orders(
      {this.id,
      this.shipmentType,
      this.pickupLocation,
      this.deleviryLocation,
      this.orderStatus,
      this.isValid,
      this.date});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shipmentType = json['shipmentType'];
    pickupLocation = json['pickupLocation']??'القاهرة';
    deleviryLocation = json['deleviryLocation']??'القاهرة';
    orderStatus = json['orderStatus'];
    isValid = json['isValid'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['shipmentType'] = shipmentType;
    data['pickupLocation'] = pickupLocation;
    data['deleviryLocation'] = deleviryLocation;
    data['orderStatus'] = orderStatus;
    data['isValid'] = isValid;
    data['date'] = date;
    return data;
  }
}
