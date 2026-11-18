import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/health_controller.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/consultation_mode_sheet.dart';
import '../../widgets/add_exam_sheet.dart';
import '../../models/exam_model.dart';

class HomeScreen extends StatelessWidget {
  final HealthController controller;

  const HomeScreen({
    super.key,
    required this.controller,
  });

  void _showExamDetails(BuildContext context, ExamModel exam) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.assignment, color: Colors.teal.shade800, size: 28),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                exam.title,
                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Data: ${exam.formattedDate}', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
            Text('Categoria: ${exam.category}', style: GoogleFonts.poppins(fontSize: 16)),
            Text('Médico: ${exam.doctor}', style: GoogleFonts.poppins(fontSize: 16)),
            Text('Laboratório: ${exam.laboratory}', style: GoogleFonts.poppins(fontSize: 16)),
            const Divider(height: 24),
            Text('Resumo do Resultado:', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(exam.summary, style: GoogleFonts.poppins(fontSize: 15, color: Colors.black87)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Fechar', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = controller.user;
    final recentExams = controller.exams;

    return Scaffold(
      appBar: CustomAppBar(title: 'Visão Geral', controller: controller),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Cartão de Boas-Vindas ao Paciente
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.teal.shade200, width: 1.5),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.teal.shade700,
                    child: const Icon(Icons.person, color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Olá, ${user.name} 👋',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal.shade900,
                          ),
                        ),
                        Text(
                          'Prontuário e saúde em dia',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // BOTÃO DE DESTAQUE: "Modo Consulta (Resumo Rápido)"
            // Foco 50+: Botão grande (>60px), ícone claro, alto contraste
            ElevatedButton.icon(
              onPressed: () => ConsultationModeSheet.show(context, user),
              icon: const Icon(Icons.medical_information, size: 32),
              label: Text(
                'Modo Consulta (Resumo Rápido)',
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade700,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Resumo dos Dados Vitais / Atalhos Rápidos
            Text(
              'Registros Recentes de Saúde',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _VitalCard(
                    icon: Icons.favorite,
                    iconColor: Colors.red.shade600,
                    title: 'Pressão',
                    value: '120/80',
                    subtitle: 'mmHg',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _VitalCard(
                    icon: Icons.bloodtype,
                    iconColor: Colors.teal.shade700,
                    title: 'Glicemia',
                    value: '95',
                    subtitle: 'mg/dL',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Lista dos Últimos Exames Adicionados
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Últimos Exames',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '${recentExams.length} registrados',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            if (recentExams.isEmpty)
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'Nenhum exame cadastrado ainda.',
                    style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey.shade600),
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: recentExams.length > 3 ? 3 : recentExams.length,
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final exam = recentExams[index];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal.shade100,
                        child: Icon(
                          exam.category == 'Sangue'
                              ? Icons.water_drop
                              : exam.category == 'Cardiologia'
                                  ? Icons.favorite
                                  : Icons.badge,
                          color: Colors.teal.shade800,
                        ),
                      ),
                      title: Text(
                        exam.title,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${exam.formattedDate} • ${exam.category}',
                        style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey.shade700),
                      ),
                      trailing: const Icon(Icons.chevron_right, size: 28),
                      onTap: () => _showExamDetails(context, exam),
                    ),
                  );
                },
              ),
            const SizedBox(height: 18),

            // NOVIDADE: Botão de atalho "Adicionar Novo Exame" no mesmo estilo da ação de exames
            ElevatedButton.icon(
              onPressed: () => AddExamSheet.show(context, controller),
              icon: const Icon(Icons.add_a_photo, size: 26),
              label: Text(
                'Adicionar Novo Exame',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade700,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                minimumSize: const Size.fromHeight(54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VitalCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;
  final String subtitle;

  const _VitalCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 24),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey.shade700, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          Text(
            subtitle,
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
