class DriverModel {
  bool? status;
  String? message;
  String? authToken;
  Driver? client;

  DriverModel({this.status, this.message, this.authToken, this.client});

  DriverModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    authToken = json['authToken'];
    client = json['client'] != null ? Driver.fromJson(json['client']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['authToken'] = authToken;
    if (client != null) {
      data['client'] = client!.toJson();
    }
    return data;
  }
}

class Driver {
  int? id;
  String? fullName;
  String? phoneNumber;
  String? email;
  String? imageUrl;
  String? nationalId;
  int? carType;
  String? carBrand;
  String? carModel;
  String? carNumber;
  String? isActive;
  int? type;
  bool? isValid;

  Driver(
      {this.id,
      this.fullName,
      this.phoneNumber,
      this.email,
      this.imageUrl,
      this.nationalId,
      this.carType,
      this.carBrand,
      this.carModel,
      this.carNumber,
      this.isActive,
      this.type,
      this.isValid});

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    imageUrl = json['imageUrl'];
    nationalId = json['nationalId'] ?? 'الهوية الوطنية';
    carType = json['carType'] ?? 0;
    carBrand = json['carBrand'] ?? 'ماركة السيارة';
    carModel = json['carModel'] ?? 'موديل السيارة';
    carNumber = json['carNumber'] ?? 'رقم السيارة';
    isActive = json['isActive'];
    type = json['type'];
    isValid = json['isValid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullName'] = fullName;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['imageUrl'] = imageUrl;
    data['nationalId'] = nationalId;
    data['carType'] = carType;
    data['carBrand'] = carBrand;
    data['carModel'] = carModel;
    data['carNumber'] = carNumber;
    data['isActive'] = isActive;
    data['type'] = type;
    data['isValid'] = isValid;
    return data;
  }
}
