class ExamModel {
  final String id;
  final String title;
  final String category;
  final DateTime date;
  final String doctor;
  final String laboratory;
  final String summary;
  final String status;

  const ExamModel({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.doctor,
    required this.laboratory,
    required this.summary,
    this.status = 'Concluído',
  });

  /// Formatação simples de data no padrão BR (dd/mm/aaaa)
  String get formattedDate {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;
    return '$day/$month/$year';
  }
}
