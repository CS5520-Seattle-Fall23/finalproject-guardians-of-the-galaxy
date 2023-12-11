class Users {
  final String userName;
  final String age;
  final String height;
  final String weight;
  final String cycleLength;
  final String medicalCondition;
  final String periodLength;
  final String email;

  Users({
    required this.userName,
    required this.age,
    required this.height,
    required this.weight,
    required this.cycleLength,
    required this.medicalCondition,
    required this.periodLength,
    required this.email,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      userName: json['UserName'],
      age: json['Age'],
      height: json['Height'],
      weight: json['Weight'],
      cycleLength: json['cycleLength'],
      medicalCondition: json['medicalCondition'],
      periodLength: json['periodLength'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserName': userName,
      'Age': age,
      'Height': height,
      'Weight': weight,
      'cycleLength': cycleLength,
      'medicalCondition': medicalCondition,
      'periodLength': periodLength,
      'email': email,
    };
  }
}