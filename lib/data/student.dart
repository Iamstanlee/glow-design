import 'package:localstorage/localstorage.dart';

class Student {
  static LocalStorage storage = LocalStorage('store');
  bool active;
  int age;
  String fullname,
      email,
      phone,
      id,
      role,
      category,
      username,
      dob,
      sch,
      stdClass,
      parent,
      registed;
  Student._();
  Student.fromMap(Map<String, dynamic> map) {
    this.fullname = map['fullname'];
    this.email = map['email'];
    this.role = map['role'];
    this.category = map['category'];
    this.username = map['username'];
    this.id = map['_id'];
    this.dob = map['dateOfBirth'];
    this.sch = map['school'];
    this.parent = map['parent'] ?? ''; // breakpoint
    this.phone = map['phoneNumber'];
    this.stdClass = map['class'];
    this.age = map['age'];
    this.registed = map['registrationDate'];
    this.active = map['activeStudent'];
  }

  static toMap(Student student) {
    return {
      "role": student.role,
      "category": student.category,
      "activeStudent": student.active,
      "_id": student.id,
      "fullname": student.fullname,
      "email": student.email,
      "username": student.username,
      "phoneNumber": student.phone,
      "dateOfBirth": student.dob,
      "school": student.sch,
      "parent": student.parent,
      "class": student.stdClass,
      "registrationDate": student.registed,
      "age": student.age,
    };
  }

  static Future<Student> fromLocalStorage() async {
    Student student = new Student._();
    if (await storage.ready) {
      student = Student.fromMap(storage.getItem('student'));
    }
    return student;
  }

  static Future<Null> toLocalStorage(Student student) async {
    if (await storage.ready) {
      storage.setItem('student', Student.toMap(student));
    }
  }
}
