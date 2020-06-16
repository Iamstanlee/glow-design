import 'package:localstorage/localstorage.dart';

class Parent {
  static LocalStorage storage = LocalStorage('store');
  bool active;
  String fullname, email, phone, id, role, category, username, registed;
  Parent._();
  Parent.fromMap(Map<String, dynamic> map) {
    this.fullname = map['fullname'];
    this.email = map['email'];
    this.role = map['role'];
    this.category = map['category'];
    this.username = map['username'];
    this.id = map['_id'];
    this.phone = map['phone'];
    this.registed = map['registrationDate'];
    this.active = map['active'];
  }

  static toMap(Parent parent) {
    return {
      "role": parent.role,
      "category": parent.category,
      "active": parent.active,
      "_id": parent.id,
      "fullname": parent.fullname,
      "email": parent.email,
      "username": parent.username,
      "phoneNumber": parent.phone,
      "registrationDate": parent.registed,
    };
  }

  static Future<Parent> fromLocalStorage() async {
    Parent parent = new Parent._();
    if (await storage.ready) {
      parent = Parent.fromMap(storage.getItem('parent'));
    }
    return parent;
  }

  static Future<Null> toLocalStorage(Parent parent) async {
    if (await storage.ready) {
      storage.setItem('parent', Parent.toMap(parent));
    }
  }
}
