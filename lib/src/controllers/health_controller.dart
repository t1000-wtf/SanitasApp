import 'package:flutter/material.dart';
import '../models/exam_model.dart';
import '../models/user_model.dart';
import '../models/family_member_model.dart';
import '../models/notification_model.dart';

/// Controller para gerenciar o estado da aplicação Sanitas
class HealthController extends ChangeNotifier {
  // Estado de autenticação do usuário
  bool _isAuthenticated = true;
  bool get isAuthenticated => _isAuthenticated;

  void login(String email, String password) {
    _isAuthenticated = true;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }

  void register(UserModel newUser) {
    _user = newUser;
    _isAuthenticated = true;
    notifyListeners();
  }

  // Modelo de usuário paciente padrão (exemplo 50+)
  UserModel _user = const UserModel(
    id: 'u1',
    name: 'Dona Maria da Silva',
    age: 68,
    bloodType: 'O+',
    allergies: ['Dipirona', 'Penicilina'],
    conditions: ['Hipertensão Controlada', 'Diabetes Tipo 2'],
    emergencyContactName: 'João da Silva',
    emergencyContactPhone: '(11) 98765-4321',
    emergencyContactRelation: 'Filho (Cuidador)',
  );

  UserModel get user => _user;

  // Lista de exames cadastrados no prontuário
  final List<ExamModel> _exams = [
    ExamModel(
      id: 'e1',
      title: 'Hemograma Completo',
      category: 'Sangue',
      date: DateTime.now().subtract(const Duration(days: 3)),
      doctor: 'Dra. Ana Martins',
      laboratory: 'Laboratório Central',
      summary: 'Glicemia de jejum: 95 mg/dL. Hemoglobina e plaquetas normais.',
    ),
    ExamModel(
      id: 'e2',
      title: 'Eletrocardiograma (ECG)',
      category: 'Cardiologia',
      date: DateTime.now().subtract(const Duration(days: 18)),
      doctor: 'Dr. Carlos Eduardo',
      laboratory: 'Clínica Coração Saudável',
      summary: 'Ritmo sinusal regular. Sem alterações agudas no traçado.',
    ),
    ExamModel(
      id: 'e3',
      title: 'Raio-X de Tórax',
      category: 'Imagem',
      date: DateTime.now().subtract(const Duration(days: 45)),
      doctor: 'Dr. Roberto Santos',
      laboratory: 'Imagens & Diagnósticos',
      summary: 'Campos pulmonares limpos. Transparência normal.',
    ),
  ];

  List<ExamModel> get exams {
    if (_selectedCategory == 'Todos') {
      return List.unmodifiable(_exams);
    }
    return List.unmodifiable(
      _exams.where((e) => e.category.toLowerCase() == _selectedCategory.toLowerCase()),
    );
  }

  // Lista de familiares e cuidadores vinculados
  final List<FamilyMemberModel> _familyMembers = const [
    FamilyMemberModel(
      id: 'f1',
      name: 'João da Silva',
      relationship: 'Filho',
      phone: '(11) 98765-4321',
      isCaregiver: true,
    ),
    FamilyMemberModel(
      id: 'f2',
      name: 'Camila da Silva',
      relationship: 'Filha',
      phone: '(11) 97654-3210',
      isCaregiver: false,
    ),
  ];

  List<FamilyMemberModel> get familyMembers => List.unmodifiable(_familyMembers);

  // Lista de notificações do aplicativo
  final List<NotificationModel> _notifications = [
    NotificationModel(
      id: 'n1',
      title: 'Novo Exame Adicionado',
      message: 'O resultado do seu Hemograma Completo já está disponível no prontuário.',
      date: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: false,
      type: 'exam',
    ),
    NotificationModel(
      id: 'n2',
      title: 'Consulta Agendada',
      message: 'Consulta com Dra. Ana Martins (Cardiologia) agendada para amanhã às 10:00.',
      date: DateTime.now().subtract(const Duration(days: 1)),
      isRead: false,
      type: 'appointment',
    ),
    NotificationModel(
      id: 'n3',
      title: 'Lembrete de Atualização',
      message: 'Lembrete: Mantenha seus contatos de emergência e alergias sempre atualizados.',
      date: DateTime.now().subtract(const Duration(days: 4)),
      isRead: true,
      type: 'reminder',
    ),
  ];

  List<NotificationModel> get notifications => List.unmodifiable(_notifications);

  int get unreadNotificationsCount => _notifications.where((n) => !n.isRead).length;

  void markNotificationAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
      notifyListeners();
    }
  }

  void markAllNotificationsAsRead() {
    for (int i = 0; i < _notifications.length; i++) {
      _notifications[i] = _notifications[i].copyWith(isRead: true);
    }
    notifyListeners();
  }

  // Filtro de categoria selecionado
  String _selectedCategory = 'Todos';
  String get selectedCategory => _selectedCategory;

  void setCategoryFilter(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  /// Adiciona um novo exame ao prontuário e dispara uma notificação
  void addExam(ExamModel exam) {
    _exams.insert(0, exam);
    _notifications.insert(
      0,
      NotificationModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: 'Novo Exame Adicionado',
        message: 'O exame "${exam.title}" foi registrado com sucesso.',
        date: DateTime.now(),
        isRead: false,
        type: 'exam',
      ),
    );
    notifyListeners();
  }
}
