class AllOrdersModel {
  List<Orders>? orders;

  AllOrdersModel({this.orders});

  AllOrdersModel.fromJson(Map<String, dynamic> json) {
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
  String? shipmentDescription;
  int? elevatorAvilabel;
  int? extramanAvilabel;
  int? carType;
  String? deleviryLocation;
  int? status;
  int? isValid;
  String? date;
  String? clientFullName;
  String? driverFullName;

  Orders(
      {this.id,
      this.shipmentType,
      this.pickupLocation,
      this.shipmentDescription,
      this.elevatorAvilabel,
      this.extramanAvilabel,
      this.carType,
      this.deleviryLocation,
      this.status,
      this.isValid,
      this.date,
      this.clientFullName,
      this.driverFullName});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shipmentType = json['shipmentType'];
    pickupLocation = json['pickupLocation'];
    shipmentDescription = json['shipmentDescription'];
    elevatorAvilabel = json['elevatorAvilabel'];
    extramanAvilabel = json['extramanAvilabel'];
    carType = json['carType'];
    deleviryLocation = json['deleviryLocation'];
    status = json['status'];
    isValid = json['isValid'];
    date = json['date'];
    clientFullName = json['clientFullName'];
    driverFullName = json['driverFullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['shipmentType'] = shipmentType;
    data['pickupLocation'] = pickupLocation;
    data['shipmentDescription'] = shipmentDescription;
    data['elevatorAvilabel'] = elevatorAvilabel;
    data['extramanAvilabel'] = extramanAvilabel;
    data['carType'] = carType;
    data['deleviryLocation'] = deleviryLocation;
    data['status'] = status;
    data['isValid'] = isValid;
    data['date'] = date;
    data['clientFullName'] = clientFullName;
    data['driverFullName'] = driverFullName;
    return data;
  }
}
