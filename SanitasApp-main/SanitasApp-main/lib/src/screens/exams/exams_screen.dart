import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/health_controller.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/add_exam_sheet.dart';
import '../../models/exam_model.dart';

class ExamsScreen extends StatelessWidget {
  final HealthController controller;

  const ExamsScreen({
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
    final filteredExams = controller.exams;
    final categories = ['Todos', 'Sangue', 'Cardiologia', 'Imagem'];

    return Scaffold(
      appBar: CustomAppBar(title: 'Meus Exames', controller: controller),
      body: Column(
        children: [
          // Filtros de Categoria (Toque amplo >= 48px)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            color: Colors.teal.shade50.withOpacity(0.5),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  final isSelected = controller.selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                        child: Text(
                          category,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected ? Colors.white : Colors.teal.shade900,
                          ),
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: Colors.teal.shade700,
                      backgroundColor: Colors.white,
                      side: BorderSide(
                        color: isSelected ? Colors.teal.shade700 : Colors.teal.shade300,
                      ),
                      onSelected: (selected) {
                        if (selected) {
                          controller.setCategoryFilter(category);
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Linha do Tempo de Exames (Timeline format)
          Expanded(
            child: filteredExams.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.folder_off_outlined, size: 64, color: Colors.grey.shade400),
                        const SizedBox(height: 12),
                        Text(
                          'Nenhum exame encontrado nesta categoria.',
                          style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredExams.length,
                    itemBuilder: (context, index) {
                      final exam = filteredExams[index];
                      final isLast = index == filteredExams.length - 1;

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Coluna do Timeline (Linha + Ícone)
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.teal.shade700,
                                child: Icon(
                                  exam.category == 'Sangue'
                                      ? Icons.water_drop
                                      : exam.category == 'Cardiologia'
                                          ? Icons.favorite
                                          : Icons.camera_alt,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                              if (!isLast)
                                Container(
                                  width: 3,
                                  height: 80,
                                  color: Colors.teal.shade200,
                                ),
                            ],
                          ),
                          const SizedBox(width: 14),

                          // Conteúdo do Exame (Card com área de toque ampla)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: () => _showExamDetails(context, exam),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              exam.formattedDate,
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.teal.shade800,
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: Colors.teal.shade50,
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(color: Colors.teal.shade200),
                                              ),
                                              child: Text(
                                                exam.category,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.teal.shade900,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          exam.title,
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Médico: ${exam.doctor}',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          exam.summary,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => AddExamSheet.show(context, controller),
        icon: const Icon(Icons.add_a_photo, size: 26),
        label: Text(
          'Novo Exame',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
      ),
    );
  }
}
