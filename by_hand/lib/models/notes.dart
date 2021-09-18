class Notes{
  String title;
  String details;
  int accountId;
  String createdAt;

  Notes();

  Notes.fromJson(Map<String,dynamic>json){
    this.title=json['title'];
    this.details=json['details'];
    this.accountId=json['account_id'];
    this.createdAt=json['createdAt'];
  }
}