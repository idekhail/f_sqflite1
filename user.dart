class User {
  late int? id;
  late String name;
  late String age;


  User({
    this.id,
    required this.name,
    required this.age,
  });

  // function to convert object to map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};

    map['id'] = id;
    map['name'] = name;
    map['age'] = age;

    return map;
  }

  // function to convert map to object
  // named constructor

  User.fromMap( Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    age = map['age'];
  }
}