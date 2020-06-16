class Sch {
  String name, address, id, admin, email, imageUrl, registered, phoneNumber;
  int population;
  bool selected = false;
  bool subscribed;
  Sch.fromMap(Map<String, dynamic> map) {
    this.name = map['name'];
    this.email = map['email'];
    this.admin = map['admin'];
    this.phoneNumber = map['phoneNumber'];
    this.address = map['address'];
    this.population = map['population'];
    this.id = map['id'];
    this.imageUrl = map['imageUrl'];
    this.registered = map['registeredOn'];
    this.subscribed = map['isSubscribed'];
  }
}
