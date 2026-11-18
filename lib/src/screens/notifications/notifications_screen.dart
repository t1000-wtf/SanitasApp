import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/health_controller.dart';
import '../../widgets/custom_app_bar.dart';

/// Tela de Notificações com suporte a atualização reativa em tempo real.
class NotificationsScreen extends StatelessWidget {
  final HealthController controller;

  const NotificationsScreen({
    super.key,
    required this.controller,
  });

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'exam':
        return Icons.assignment_turned_in_rounded;
      case 'appointment':
        return Icons.calendar_month_rounded;
      case 'reminder':
        return Icons.notifications_active_rounded;
      default:
        return Icons.info_rounded;
    }
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case 'exam':
        return Colors.teal.shade700;
      case 'appointment':
        return Colors.blue.shade700;
      case 'reminder':
        return Colors.orange.shade800;
      default:
        return Colors.grey.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    // ListenableBuilder garante a atualização reativa em tempo real na própria tela
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        final notifications = controller.notifications;
        final unreadCount = controller.unreadNotificationsCount;

        return Scaffold(
          appBar: CustomAppBar(
            title: 'Notificações',
            controller: controller,
          ),
          body: Column(
            children: [
              // Barra de ações superiores com botão proeminente (Área de toque > 48px)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50.withOpacity(0.8),
                  border: Border(
                    bottom: BorderSide(color: Colors.teal.shade100, width: 1.5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          unreadCount > 0 ? Icons.notifications_active : Icons.notifications_none,
                          color: unreadCount > 0 ? Colors.teal.shade800 : Colors.grey.shade700,
                          size: 26,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          unreadCount > 0 ? '$unreadCount não lida(s)' : 'Todas lidas',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal.shade900,
                          ),
                        ),
                      ],
                    ),
                    if (unreadCount > 0)
                      ElevatedButton.icon(
                        onPressed: () {
                          controller.markAllNotificationsAsRead();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Todas as notificações foram marcadas como lidas.',
                                style: GoogleFonts.poppins(fontSize: 15),
                              ),
                              backgroundColor: Colors.teal.shade800,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        icon: const Icon(Icons.done_all_rounded, size: 22),
                        label: Text(
                          'Marcar todas lidas',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal.shade700,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          minimumSize: const Size(0, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                      ),
                  ],
                ),
              ),

              // Lista de Notificações
              Expanded(
                child: notifications.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.notifications_off_outlined, size: 64, color: Colors.grey.shade400),
                            const SizedBox(height: 12),
                            Text(
                              'Nenhuma notificação no momento.',
                              style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: notifications.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final item = notifications[index];
                          final iconColor = _getNotificationColor(item.type);

                          return Card(
                            elevation: item.isRead ? 1 : 4,
                            color: item.isRead ? Colors.white : Colors.teal.shade50.withOpacity(0.7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(
                                color: item.isRead ? Colors.grey.shade300 : Colors.teal.shade400,
                                width: item.isRead ? 1 : 2,
                              ),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                if (!item.isRead) {
                                  controller.markNotificationAsRead(item.id);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 26,
                                      backgroundColor: iconColor.withOpacity(0.15),
                                      child: Icon(_getNotificationIcon(item.type), color: iconColor, size: 28),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  item.title,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ),
                                              if (!item.isRead)
                                                Container(
                                                  margin: const EdgeInsets.only(left: 8),
                                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                                  decoration: BoxDecoration(
                                                    color: Colors.teal.shade700,
                                                    borderRadius: BorderRadius.circular(12),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        width: 8,
                                                        height: 8,
                                                        decoration: const BoxDecoration(
                                                          color: Colors.white,
                                                          shape: BoxShape.circle,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 6),
                                                      Text(
                                                        'NOVA',
                                                        style: GoogleFonts.poppins(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                            ],
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            item.message,
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.black87,
                                              height: 1.3,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            item.formattedTime,
                                            style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: Colors.grey.shade700,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
          ],
        ),
      );
    },
  );
 }
}
