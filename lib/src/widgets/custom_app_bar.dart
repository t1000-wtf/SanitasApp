// lib/src/widgets/custom_app_bar.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/health_controller.dart';
import '../screens/notifications/notifications_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final HealthController? controller;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final unreadCount = controller?.unreadNotificationsCount ?? 0;

    return AppBar(
      backgroundColor: Colors.teal.shade700,
      foregroundColor: Colors.white,
      elevation: 4,
      shadowColor: Colors.black26,
      titleSpacing: 16,
      title: Row(
        children: [
          // Ícone com fundo arredondado elegante
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.health_and_safety_rounded,
              size: 24,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 14),
          // Títulos: App em cima, Tela atual embaixo
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SANITAS',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.tealAccent.shade100,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.1,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
      actions: actions ?? [
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: Icon(
                unreadCount > 0 ? Icons.notifications_active : Icons.notifications_outlined,
                size: 26,
              ),
              tooltip: 'Notificações',
              onPressed: () {
                if (controller != null) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NotificationsScreen(controller: controller!),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Nenhuma notificação recente.',
                        style: GoogleFonts.poppins(fontSize: 15),
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
            if (unreadCount > 0)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    '$unreadCount',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
