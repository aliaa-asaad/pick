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
  int? status;
  String? pickupLocation;
  String? deliveryLocation;
  String? date;
  bool? uploadaAndDownloadServices;
  int? price;

  OrderDetails(
      {this.id,
      this.carType,
      this.shipmentType,
      this.shipmentDescription,
      this.pickupFloor,
      this.deleviryFloor,
      this.elevatorAvilabel,
      this.extramanAvilabel,
      this.status,
      this.pickupLocation,
      this.deliveryLocation,
      this.date,
      this.uploadaAndDownloadServices,
      this.price});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carType = json['carType'];
    shipmentType = json['shipmentType'];
    shipmentDescription = json['shipmentDescription'];
    pickupFloor = json['pickupFloor'];
    deleviryFloor = json['deleviryFloor'];
    elevatorAvilabel = json['elevatorAvilabel'];
    extramanAvilabel = json['extramanAvilabel'];
    status = json['status'];
    pickupLocation = json['pickupLocation'];
    deliveryLocation = json['deleviryLocation'];
    date = json['date'];
    uploadaAndDownloadServices = json['uploadaAndDownloadServices'];
    price = json['price'];
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
    data['status'] = status;
    data['pickupLocation'] = pickupLocation;
    data['deleviryLocation'] = deliveryLocation;
    data['date'] = date;
    data['uploadaAndDownloadServices'] = uploadaAndDownloadServices;
    data['price'] = price;
    return data;
  }
}
