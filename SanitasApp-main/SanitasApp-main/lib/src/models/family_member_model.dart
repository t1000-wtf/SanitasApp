class FamilyMemberModel {
  final String id;
  final String name;
  final String relationship;
  final String phone;
  final bool isCaregiver;

  const FamilyMemberModel({
    required this.id,
    required this.name,
    required this.relationship,
    required this.phone,
    this.isCaregiver = false,
  });
}
