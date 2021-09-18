class Rates{
  int id;
  int productId;
  String userproduct;
  double valueRate;

  Rates();

  Rates.fromJson(Map<String,dynamic>json){
    this.id=json['id'];
    this.productId=json['product_id'];
    this.valueRate=json['value_rate'];
  }
}