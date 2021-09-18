class NotificationsModel {
  String title;
  String body;
  String createdAt;

  NotificationsModel();

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    this.title = json['title'];
    this.body = json['body'];
    this.createdAt = json['createdAt'];
  }
}