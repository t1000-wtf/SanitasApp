import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/health_controller.dart';
import '../../models/user_model.dart';

class RegisterScreen extends StatefulWidget {
  final HealthController controller;

  const RegisterScreen({
    super.key,
    required this.controller,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _ageController = TextEditingController();
  String _selectedBloodType = 'O+';

  final List<String> _bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      final age = int.tryParse(_ageController.text.trim()) ?? 68;
      final newUser = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        age: age,
        bloodType: _selectedBloodType,
        allergies: const ['Nenhuma declarada'],
        conditions: const ['Acompanhamento de Rotina'],
        emergencyContactName: 'Contato de Emergência',
        emergencyContactPhone: '(11) 98765-4321',
        emergencyContactRelation: 'Familiar',
      );

      widget.controller.register(newUser);
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Cadastro realizado com sucesso! Bem-vindo(a), ${newUser.name}.',
            style: GoogleFonts.poppins(fontSize: 16),
          ),
          backgroundColor: Colors.teal.shade800,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
        title: Text(
          'Criar Nova Conta',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Cadastro no Sanitas',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade900,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Preencha os dados do paciente ou familiar responsável.',
                style: GoogleFonts.poppins(fontSize: 15, color: Colors.black87),
              ),
              const SizedBox(height: 20),

              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Nome Completo
                        Text(
                          'Nome Completo *',
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _nameController,
                          style: GoogleFonts.poppins(fontSize: 18),
                          decoration: InputDecoration(
                            hintText: 'Ex: Dona Maria da Silva',
                            prefixIcon: Icon(Icons.person_outline, color: Colors.teal.shade700),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'Por favor, informe o nome completo';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // E-mail
                        Text(
                          'E-mail *',
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: GoogleFonts.poppins(fontSize: 18),
                          decoration: InputDecoration(
                            hintText: 'Ex: maria@email.com',
                            prefixIcon: Icon(Icons.email_outlined, color: Colors.teal.shade700),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'Por favor, informe o e-mail';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Idade
                        Text(
                          'Idade (anos)',
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _ageController,
                          keyboardType: TextInputType.number,
                          style: GoogleFonts.poppins(fontSize: 18),
                          decoration: InputDecoration(
                            hintText: 'Ex: 68',
                            prefixIcon: Icon(Icons.cake_outlined, color: Colors.teal.shade700),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Tipo Sanguíneo
                        Text(
                          'Tipo Sanguíneo',
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        DropdownButtonFormField<String>(
                          value: _selectedBloodType,
                          items: _bloodTypes.map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(type, style: GoogleFonts.poppins(fontSize: 16)),
                            );
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) setState(() => _selectedBloodType = val);
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.bloodtype_outlined, color: Colors.teal.shade700),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Senha
                        Text(
                          'Senha de Acesso *',
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          style: GoogleFonts.poppins(fontSize: 18),
                          decoration: InputDecoration(
                            hintText: 'Crie uma senha segura',
                            prefixIcon: Icon(Icons.lock_outline, color: Colors.teal.shade700),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          validator: (val) {
                            if (val == null || val.length < 4) {
                              return 'A senha deve ter no mínimo 4 caracteres';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),

                        // Botão Concluir Cadastro (>56px altura)
                        ElevatedButton.icon(
                          onPressed: _handleRegister,
                          icon: const Icon(Icons.check_circle_rounded, size: 28),
                          label: Text(
                            'Finalizar Cadastro',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
