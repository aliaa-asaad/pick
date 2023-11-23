class EGPaymentDetails {
  EGDataDetails? data;

  EGPaymentDetails({this.data});

  EGPaymentDetails.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? EGDataDetails.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class EGDataDetails {
  int? invoiceId;
  String? invoiceKey;
  EGPaymentDetailsData? paymentData;

  EGDataDetails({this.invoiceId, this.invoiceKey, this.paymentData});

  EGDataDetails.fromJson(Map<String, dynamic> json) {
    invoiceId = json['invoice_id'];
    invoiceKey = json['invoice_key'];
    paymentData = json['payment_data'] != null
        ? EGPaymentDetailsData.fromJson(json['payment_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['invoice_id'] = invoiceId;
    data['invoice_key'] = invoiceKey;
    if (paymentData != null) {
      data['payment_data'] = paymentData!.toJson();
    }
    return data;
  }
}

class EGPaymentDetailsData {
  String? fawryCode;
  String? expireDate;
  String? meezaReference;
  String? meezaQrCode;
  String? masaryCode;

  String? amanCode;

  String? redirectTo;

  EGPaymentDetailsData({this.fawryCode, this.expireDate, this.redirectTo});

  EGPaymentDetailsData.fromJson(Map<String, dynamic> json) {
    fawryCode = json['fawryCode'] ?? '';
    expireDate = json['expireDate'] ?? '';
    meezaReference = json['meezaReference'].toString() ?? '';
    meezaQrCode = json['meezaQrCode'] ?? '';
    masaryCode = json['masaryCode'] ?? '';

    amanCode = json['amanCode'] ?? '';
    redirectTo = json['redirectTo'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fawryCode'] = fawryCode;
    data['expireDate'] = expireDate ?? '';
    data['meezaReference'] = meezaReference ?? '';
    data['meezaQrCode'] = meezaQrCode ?? '';
    data['masaryCode'] = masaryCode ?? '';

    data['amanCode'] = amanCode ?? '';
    data['redirectTo'] = redirectTo ?? '';
    return data;
  }
}
