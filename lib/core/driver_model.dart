class DriverModel {
  bool? status;
  String? message;
  String? authToken;
  Driver? driver;

  DriverModel({this.status, this.message, this.authToken, this.driver});

  DriverModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    authToken = json['authToken'];
    driver = json['driver'] != null ? Driver.fromJson(json['driver']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['authToken'] = authToken;
    if (driver != null) {
      data['driver'] = driver!.toJson();
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
  int? isActive;
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
    nationalId = json['nationalId'];
    carType = json['carType'];
    carBrand = json['carBrand'];
    carModel = json['carModel'];
    carNumber = json['carNumber'];
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
