class User {
  int id;
  String name;
  String lastname;
  String email;

  User({required this.id, required this.name, required this.lastname, required this.email});

  Map<String, dynamic> toMap(){
    return {
      'email': email,
      'name': name,
      'lastname': lastname
    };
  }
}