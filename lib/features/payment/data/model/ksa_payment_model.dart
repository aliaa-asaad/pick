class KSAPaymentModel {
  KSAData? data;

  KSAPaymentModel({this.data});

  KSAPaymentModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? KSAData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class KSAData {
  KSATransactionModel? transaction;

  KSAData({
    this.transaction,
  });

  KSAData.fromJson(Map<String, dynamic> json) {
    transaction = json['transaction'] != null
        ? KSATransactionModel.fromJson(json['transaction'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (transaction != null) {
      data['transaction'] = transaction!.toJson();
    }
    return data;
  }
}

class KSATransactionModel {
  String? url;

  KSATransactionModel({
    this.url,
  });

  KSATransactionModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['url'] = url;

    return data;
  }
}
