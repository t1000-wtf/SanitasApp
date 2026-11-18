import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/exam_model.dart';
import '../controllers/health_controller.dart';

/// Modal para adição de novos exames ao prontuário
class AddExamSheet extends StatefulWidget {
  final HealthController controller;

  const AddExamSheet({
    super.key,
    required this.controller,
  });

  static void show(BuildContext context, HealthController controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => AddExamSheet(controller: controller),
    );
  }

  @override
  State<AddExamSheet> createState() => _AddExamSheetState();
}

class _AddExamSheetState extends State<AddExamSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _doctorController = TextEditingController();
  final _labController = TextEditingController();
  final _summaryController = TextEditingController();

  String _selectedCategory = 'Sangue';
  final List<String> _categories = ['Sangue', 'Cardiologia', 'Imagem', 'Outros'];

  @override
  void dispose() {
    _titleController.dispose();
    _doctorController.dispose();
    _labController.dispose();
    _summaryController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final newExam = ExamModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        category: _selectedCategory,
        date: DateTime.now(),
        doctor: _doctorController.text.trim().isEmpty ? 'Não informado' : _doctorController.text.trim(),
        laboratory: _labController.text.trim().isEmpty ? 'Não informado' : _labController.text.trim(),
        summary: _summaryController.text.trim().isEmpty ? 'Sem observações.' : _summaryController.text.trim(),
      );

      widget.controller.addExam(newExam);
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Exame "${newExam.title}" cadastrado com sucesso!',
            style: GoogleFonts.poppins(fontSize: 16),
          ),
          backgroundColor: Colors.teal.shade800,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        top: 24,
        left: 20,
        right: 20,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.add_a_photo, color: Colors.teal.shade800, size: 28),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      'Novo Exame',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade900,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 28),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Campo Título
              Text(
                'Nome do Exame *',
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _titleController,
                style: GoogleFonts.poppins(fontSize: 18),
                decoration: InputDecoration(
                  hintText: 'Ex: Hemograma, Raio-X...',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, digite o nome do exame';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo Categoria
              Text(
                'Categoria',
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: _categories.map((cat) {
                  return DropdownMenuItem(
                    value: cat,
                    child: Text(cat, style: GoogleFonts.poppins(fontSize: 16)),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedCategory = val);
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),

              // Campo Médico
              Text(
                'Médico Responsável',
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _doctorController,
                style: GoogleFonts.poppins(fontSize: 18),
                decoration: InputDecoration(
                  hintText: 'Ex: Dra. Ana Martins',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),

              // Campo Laboratório
              Text(
                'Laboratório / Clínica',
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _labController,
                style: GoogleFonts.poppins(fontSize: 18),
                decoration: InputDecoration(
                  hintText: 'Ex: Lab Central',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),

              // Campo Resumo
              Text(
                'Resumo / Resultados',
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _summaryController,
                maxLines: 2,
                style: GoogleFonts.poppins(fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'Ex: Valores normais...',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 24),

              // Botão Salvar (Toque amplo > 52px)
              ElevatedButton.icon(
                onPressed: _saveForm,
                icon: const Icon(Icons.check_circle_rounded, size: 28),
                label: Text(
                  'Salvar Registro',
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade700,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
