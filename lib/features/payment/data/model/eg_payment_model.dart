class EgyptPaymentModel {
  EGDataModel? data;

  EgyptPaymentModel({this.data});

  EgyptPaymentModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? EGDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class EGDataModel {
  String? status;
  List<EGData>? data;

  EGDataModel({this.status, this.data});

  EGDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <EGData>[];
      json['data'].forEach((v) {
        data!.add(EGData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EGData {
  int? paymentId;
  String? nameEn;
  String? nameAr;
  String? redirect;
  String? logo;

  EGData({this.paymentId, this.nameEn, this.nameAr, this.redirect, this.logo});

  EGData.fromJson(Map<String, dynamic> json) {
    paymentId = json['paymentId'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    redirect = json['redirect'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paymentId'] = paymentId;
    data['name_en'] = nameEn;
    data['name_ar'] = nameAr;
    data['redirect'] = redirect;
    data['logo'] = logo;
    return data;
  }
}
