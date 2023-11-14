class UserModel {
  bool? status;
  String? authToken;
  String? message;
  Client? client;

  UserModel({this.status, this.authToken, this.message, this.client});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    authToken = json['authToken'] ?? '';
    message = json['message'];
    client = json['client'] != null ? Client.fromJson(json['client']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['authToken'] = authToken ?? '';
    data['message'] = message;
    if (client != null) {
      data['client'] = client!.toJson();
    }
    return data;
  }
}

class Client {
  int? id;
  String? fullName;
  String? phoneNumber;
  String? email;
  String? imageUrl;
  int? type;
  bool? isValid;

  Client(
      {this.id,
      this.fullName,
      this.phoneNumber,
      this.email,
      this.imageUrl,
      this.type,
      this.isValid});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    imageUrl = json['imageUrl'];
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
    data['type'] = type;
    data['isValid'] = isValid;
    return data;
  }
}

