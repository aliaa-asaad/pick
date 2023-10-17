class SendOrderModel {
  bool? status;
  String? errNum;
  String? msg;
  Data? data;

  SendOrderModel({this.status, this.errNum, this.msg, this.data});

  SendOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['errNum'] = errNum;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? truckType;
  String? shipmentType;
  String? shipmentDescription;
  String? shipmentLat;
  String? shipmentLong;
  String? deliveryLat;
  String? deliveryLong;
  String? price;
  String? km;
  String? isLoadShipmentAvilabel;
  String? isExtraManAvilabel;
  String? isElevatorAvilabel;
  String? pickUpFloor;
  String? deleviryFloor;
  String? created;
  //Todo: check the data type
  String? clientSecret;

  Data(
      {this.truckType,
      this.shipmentType,
      this.shipmentDescription,
      this.shipmentLat,
      this.shipmentLong,
      this.deliveryLat,
      this.deliveryLong,
      this.price,
      this.km,
      this.isLoadShipmentAvilabel,
      this.isExtraManAvilabel,
      this.isElevatorAvilabel,
      this.pickUpFloor,
      this.deleviryFloor,
      this.created,
      this.clientSecret});

  Data.fromJson(Map<String, dynamic> json) {
    truckType = json['truckType'];
    shipmentType = json['shipmentType'];
    shipmentDescription = json['shipmentDescription'];
    shipmentLat = json['shipmentLat'];
    shipmentLong = json['shipmentLong'];
    deliveryLat = json['deliveryLat'];
    deliveryLong = json['deliveryLong'];
    price = json['price'];
    km = json['km'];
    isLoadShipmentAvilabel = json['isLoadShipmentAvilabel'];
    isExtraManAvilabel = json['isExtraManAvilabel'];
    isElevatorAvilabel = json['isElevatorAvilabel'];
    pickUpFloor = json['pickUpFloor'];
    deleviryFloor = json['deleviryFloor'];
    created = json['created'];
    clientSecret = json['clientSecret'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['truckType'] = truckType;
    data['shipmentType'] = shipmentType;
    data['shipmentDescription'] = shipmentDescription;
    data['shipmentLat'] = shipmentLat;
    data['shipmentLong'] = shipmentLong;
    data['deliveryLat'] = deliveryLat;
    data['deliveryLong'] = deliveryLong;
    data['price'] = price;
    data['km'] = km;
    data['isLoadShipmentAvilabel'] = isLoadShipmentAvilabel;
    data['isExtraManAvilabel'] = isExtraManAvilabel;
    data['isElevatorAvilabel'] = isElevatorAvilabel;
    data['pickUpFloor'] = pickUpFloor;
    data['deleviryFloor'] = deleviryFloor;
    data['created'] = created;
    data['clientSecret'] = clientSecret;
    return data;
  }
}
