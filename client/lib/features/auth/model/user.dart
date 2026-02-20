class User {
  final String id, name, email,token;

const  User({
  required this.id,
  required this.name,
  required this.email,
  required this.token,
});
Map<String, dynamic> toMap() => {
  'id': id,
  'name': name,
  'email': email,
};
factory User.fromMap(Map<String, dynamic> map) => User(
  id: map['id'],
  name: map['name'],
  email: map['email'],
  token: map['token']??'',
);
User copyWith({
  String? id,
  String? name,
  String? email,
  String? token,
}) => User(
  id: id ?? this.id,
  name: name ?? this.name,
  email: email ?? this.email,
  token: token ?? this.token,
);
}