class CheckOngkirRequest {
  String key;
  String origin;
  String destination;
  int weight;
  String courier;

  CheckOngkirRequest(
      {this.key, this.origin, this.destination, this.weight, this.courier});

  CheckOngkirRequest.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    origin = json['origin'];
    destination = json['destination'];
    weight = json['weight'];
    courier = json['courier'];
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['origin'] = this.origin;
    data['destination'] = this.destination;
    data['weight'] = this.weight;
    data['courier'] = this.courier;
    return data;
  }
}
