import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/health_controller.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  final HealthController controller;

  const LoginScreen({
    super.key,
    required this.controller,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      widget.controller.login(
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo & Marca Sanitas (Destaque visual 50+)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade700,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.health_and_safety_rounded,
                    size: 64,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),

                Text(
                  'SANITAS',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade900,
                    letterSpacing: 2.0,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Prontuário & Saúde Familiar',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 32),

                // Card do Formulário com alto contraste
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Acessar Prontuário',
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal.shade900,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Campo E-mail / CPF (Toque amplo)
                          Text(
                            'E-mail ou CPF',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: GoogleFonts.poppins(fontSize: 18),
                            decoration: InputDecoration(
                              hintText: 'Digite seu e-mail ou CPF',
                              prefixIcon: Icon(Icons.email_outlined, color: Colors.teal.shade700, size: 26),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return 'Por favor, informe seu e-mail ou CPF';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 18),

                          // Campo Senha (Toque amplo)
                          Text(
                            'Senha de Acesso',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            style: GoogleFonts.poppins(fontSize: 18),
                            decoration: InputDecoration(
                              hintText: 'Digite sua senha',
                              prefixIcon: Icon(Icons.lock_outline, color: Colors.teal.shade700, size: 26),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                  color: Colors.teal.shade700,
                                  size: 26,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Por favor, informe sua senha';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),

                          // Botão Principal Entrar (>56px altura)
                          ElevatedButton.icon(
                            onPressed: _handleLogin,
                            icon: const Icon(Icons.login_rounded, size: 28),
                            label: Text(
                              'Entrar',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal.shade700,
                              foregroundColor: Colors.white,
                              minimumSize: const Size.fromHeight(56),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Link para Cadastro de Novo Usuário / Cuidador
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RegisterScreen(controller: widget.controller),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: Text(
                    'Não tem uma conta? Cadastre-se aqui',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade900,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),

                // Botão de acesso demonstrativo rápido (Ideal para testes e acessibilidade)
                TextButton(
                  onPressed: () {
                    widget.controller.login('demo@sanitas.com', '123456');
                  },
                  child: Text(
                    'Entrar como Convidado (Modo Demonstração)',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
