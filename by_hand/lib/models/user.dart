class Users{
  int id;
  String address;
  String phone;
  String password;
  String email;
  String fname;
  String lname;
  String jop;
  String hobe;
  String imageUrl;
  String type;
  int countItem;
  bool vip;
  int type_id;

  Users(this.imageUrl);

  Users.fromJson(Map<String,dynamic>json){
    this.id=json['id'];
    this.address=json['address'];
    this.phone=json['phone'];
    this.password=json['password'];
    this.email=json['email'];
    this.fname=json['fname'];
    this.lname=json['lname'];
    this.jop=json['jop'];
    this.hobe=json['hobe'];
    this.imageUrl=json['image_url'];
    this.type_id=json['type_id'];
    this.type=json["TypeUser"]["type"];
    this.countItem=json["TypeUser"]["count_posts"];
    this.vip=json["TypeUser"]["vip_account"];

  }
}