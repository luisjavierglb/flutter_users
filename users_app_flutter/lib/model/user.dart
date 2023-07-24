class User {
  final Name name;
  final String image;
  final String email;

  User._({
    required this.name,
    required this.image,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User._(
        name: Name.fromJson(json['name']),
        email: json['email'],
        image: json['picture']['large'],
      );

  static List<User> fromList(dynamic list) {
    final result = <User>[];

    if (list?.isNotEmpty) {
      for (final json in list) {
        result.add(User.fromJson(json));
      }
    }

    return result;
  }
}

class Name {
  final String title;
  final String first;
  final String last;

  Name._({
    required this.title,
    required this.first,
    required this.last,
  });

  String get fullName => '$title $first $last';

  factory Name.fromJson(Map<String, dynamic> json) => Name._(
        title: json['title'],
        first: json['first'],
        last: json['last'],
      );
}
