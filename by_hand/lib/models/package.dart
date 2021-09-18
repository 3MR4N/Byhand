class Package{
  int id;
  String name;
  String price;
  String description;

  Package();

  Package.fromJson(Map<String,dynamic>json){
    this.id=json['id'];
    this.name=json['name'];
    this.price=json['price'];
    this.description=json['description'];
  }
}