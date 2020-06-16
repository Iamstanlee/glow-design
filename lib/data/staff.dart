import 'package:localstorage/localstorage.dart';

class Staff {
  static LocalStorage storage = LocalStorage('store');
  bool active;
  String fullname, email, phone, id, role, category, username, sch, registed;
  List<dynamic> classes, subjects;
  Staff._();
  Staff.fromMap(Map<String, dynamic> map) {
    this.fullname = map['fullname'];
    this.email = map['email'];
    this.role = map['role'];
    this.subjects = map['subjects'];
    this.classes = map['classes'];
    this.category = map['category'];
    this.username = map['username'];
    this.phone = map['phoneNumber'];
    this.id = map['_id'];
    this.sch = map['school'];
    this.registed = map['registrationDate'];
    this.active = map['active'];
  }

  static toMap(Staff staff) {
    return {
      "role": staff.role,
      "category": staff.category,
      "active": staff.active,
      "_id": staff.id,
      "fullname": staff.fullname,
      'classes': staff.classes,
      'subjects': staff.subjects,
      "email": staff.email,
      "username": staff.username,
      "phoneNumber": staff.phone,
      "school": staff.sch,
      "registrationDate": staff.registed,
    };
  }

  static Future<Staff> fromLocalStorage() async {
    Staff staff = new Staff._();
    if (await storage.ready) {
      staff = Staff.fromMap(storage.getItem('staff'));
    }
    return staff;
  }

  static Future<Null> toLocalStorage(Staff staff) async {
    if (await storage.ready) {
      storage.setItem('staff', Staff.toMap(staff));
    }
  }
}
