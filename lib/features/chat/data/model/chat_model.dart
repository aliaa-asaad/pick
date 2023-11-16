class ChatModel {
  List<Chat>? chat;

  ChatModel({this.chat});

  ChatModel.fromJson(Map<String, dynamic> json) {
    if (json['chat'] != null) {
      chat = <Chat>[];
      json['chat'].forEach((v) {
        chat!.add(Chat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (chat != null) {
      data['chat'] = chat!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chat {
  int? orderId;
  String? clientName;
  String? clientNumber;
  String? driverName;
  String? driverNumber;

  Chat(
      {this.orderId,
      this.clientName,
      this.clientNumber,
      this.driverName,
      this.driverNumber});

  Chat.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    clientName = json['clientName'];
    clientNumber = json['clientNumber'];
    driverName = json['driverName'];
    driverNumber = json['driverNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['clientName'] = clientName;
    data['clientNumber'] = clientNumber;
    data['driverName'] = driverName;
    data['driverNumber'] = driverNumber;
    return data;
  }
}
