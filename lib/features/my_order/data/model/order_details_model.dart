class OrderDetailsModel {
  OrderDetails? orderDetails;

  OrderDetailsModel({this.orderDetails});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    orderDetails = json['OrderDitiels'] != null
        ? OrderDetails.fromJson(json['OrderDitiels'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orderDetails != null) {
      data['OrderDitiels'] = orderDetails!.toJson();
    }
    return data;
  }
}

class OrderDetails {
  int? id;
  String? carType;
  String? shipmentType;
  String? shipmentDescription;
  int? pickupFloor;
  int? deleviryFloor;
  bool? elevatorAvilabel;
  bool? extramanAvilabel;
  String? pickupLocation;
  String? deliveryLocation;
  int? orderStatus;
  String? date;

  OrderDetails(
      {this.id,
      this.carType,
      this.shipmentType,
      this.shipmentDescription,
      this.pickupFloor,
      this.deleviryFloor,
      this.elevatorAvilabel,
      this.extramanAvilabel,
      this.pickupLocation,
      this.deliveryLocation,
      this.orderStatus,
      this.date});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    carType = json['carType']??'';
    shipmentType = json['shipmentType']??'';
    shipmentDescription = json['shipmentDescription']??'';
    pickupFloor = json['pickupFloor']??0;
    deleviryFloor = json['deleviryFloor']??0;
    elevatorAvilabel = json['elevatorAvilabel']??true;
    extramanAvilabel = json['extramanAvilabel']??true;
    pickupLocation = json['pickupLocation']??'القاهرة';
    deliveryLocation = json['deleviryLocation']??'القاهرة';
    orderStatus = json['orderStatus']??0;
    date = json['date']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['carType'] = carType;
    data['shipmentType'] = shipmentType;
    data['shipmentDescription'] = shipmentDescription;
    data['pickupFloor'] = pickupFloor;
    data['deleviryFloor'] = deleviryFloor;
    data['elevatorAvilabel'] = elevatorAvilabel;
    data['extramanAvilabel'] = extramanAvilabel;
    data['pickupLocation'] = pickupLocation;
    data['deleviryLocation'] = deliveryLocation;
    data['orderStatus'] = orderStatus;
    data['date'] = date;
    return data;
  }
}
