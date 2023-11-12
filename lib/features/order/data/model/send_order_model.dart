class OrderDataModel {
  String? message;
  int? orderId;
  int? price;
  OrderDataModel({this.message, this.orderId});

  OrderDataModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    orderId = json['order_id'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['order_id'] = orderId;
    data['price'] = price;
    return data;
  }
}

/* class OrderImagesDataModel {
  String? message;
  String? orderId;

  OrderImagesDataModel({this.message, this.orderId});

  OrderImagesDataModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['order_id'] = orderId;
    return data;
  }
} */

class OrderSubmitModel {
  String? message;

  OrderSubmitModel({this.message});

  OrderSubmitModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}
