class UserModel {
  final String id;
  final String name;
  final int age;
  final String bloodType;
  final List<String> allergies;
  final List<String> conditions;
  final String emergencyContactName;
  final String emergencyContactPhone;
  final String emergencyContactRelation;

  const UserModel({
    required this.id,
    required this.name,
    required this.age,
    required this.bloodType,
    required this.allergies,
    required this.conditions,
    required this.emergencyContactName,
    required this.emergencyContactPhone,
    required this.emergencyContactRelation,
  });
}
