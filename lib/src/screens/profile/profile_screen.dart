import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/health_controller.dart';
import '../../widgets/custom_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  final HealthController controller;

  const ProfileScreen({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final user = controller.user;
    final family = controller.familyMembers;

    return Scaffold(
      appBar: CustomAppBar(title: 'Perfil e Saúde', controller: controller),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Header Perfil do Paciente
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.teal.shade700,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 48, color: Colors.teal.shade800),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${user.age} anos • Idoso(a)',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Tipo Sanguíneo: ${user.bloodType}',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // CARTÃO DE ALERGIAS (Foco em Alto Contraste para o público 50+)
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.red.shade300, width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: Colors.red.shade800, size: 28),
                    const SizedBox(width: 8),
                    Text(
                      'ALERGIAS CONHECIDAS',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  user.allergies.join(', '),
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade900,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Seção Condições de Saúde e Medicamentos
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.health_and_safety, color: Colors.teal.shade700, size: 26),
                      const SizedBox(width: 10),
                      Text(
                        'Condições & Medicamentos',
                        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  ...user.conditions.map((cond) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.teal.shade700, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            cond,
                            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Contato de Emergência (Botão de toque amplo > 48px)
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.phone_in_talk, color: Colors.red.shade700, size: 26),
                      const SizedBox(width: 10),
                      Text(
                        'Contato de Emergência',
                        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      user.emergencyContactName,
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${user.emergencyContactRelation} • ${user.emergencyContactPhone}',
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    trailing: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Ligando para ${user.emergencyContactName}...',
                              style: GoogleFonts.poppins(fontSize: 16),
                            ),
                            backgroundColor: Colors.teal.shade800,
                          ),
                        );
                      },
                      icon: const Icon(Icons.call, size: 20),
                      label: Text('Ligar', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade700,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Familiares / Cuidadores Vinculados
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.family_restroom, color: Colors.teal.shade700, size: 26),
                      const SizedBox(width: 10),
                      Text(
                        'Familiares & Cuidadores',
                        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: family.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final member = family[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundColor: member.isCaregiver ? Colors.teal.shade100 : Colors.grey.shade200,
                          child: Icon(
                            member.isCaregiver ? Icons.health_and_safety : Icons.person,
                            color: member.isCaregiver ? Colors.teal.shade800 : Colors.grey.shade700,
                          ),
                        ),
                        title: Text(
                          member.name,
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '${member.relationship} • ${member.phone}',
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                        trailing: member.isCaregiver
                            ? Chip(
                                backgroundColor: Colors.teal.shade100,
                                label: Text(
                                  'Cuidador',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal.shade900,
                                  ),
                                ),
                              )
                            : null,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Botão de Sair da Conta (Logout)
          OutlinedButton.icon(
            onPressed: () {
              controller.logout();
            },
            icon: const Icon(Icons.logout_rounded, color: Colors.red, size: 24),
            label: Text(
              'Sair da Conta',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade700,
              ),
            ),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
              side: BorderSide(color: Colors.red.shade300, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
