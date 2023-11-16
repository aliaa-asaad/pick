class NotificationModel {
  List<NotificationsBody>? notifications;

  NotificationModel({this.notifications});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <NotificationsBody>[];
      json['notifications'].forEach((v) {
        notifications!.add(NotificationsBody.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notifications != null) {
      data['notifications'] = notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationsBody {
  int? id;
  String? title;
  String? body;
  String? clientId;
  String? driverId;
  String? createdAt;
  String? updatedAt;

  NotificationsBody(
      {this.id,
      this.title,
      this.body,
      this.clientId,
      this.driverId,
      this.createdAt,
      this.updatedAt});

  NotificationsBody.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    clientId = json['client_id'];
    driverId = json['driver_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['client_id'] = clientId;
    data['driver_id'] = driverId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
