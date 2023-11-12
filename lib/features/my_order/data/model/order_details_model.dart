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
    id = json['id'];
    carType = json['carType'];
    shipmentType = json['shipmentType'];
    shipmentDescription = json['shipmentDescription'];
    pickupFloor = json['pickupFloor'];
    deleviryFloor = json['deleviryFloor'];
    elevatorAvilabel = json['elevatorAvilabel'];
    extramanAvilabel = json['extramanAvilabel'];
    pickupLocation = json['pickupLocation'];
    deliveryLocation = json['deleviryLocation'];
    orderStatus = json['orderStatus'];
    date = json['date'];
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