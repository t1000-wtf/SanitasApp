import 'package:flutter/material.dart';
import '../controllers/health_controller.dart';
import 'auth/login_screen.dart';
import 'home/home_screen.dart';
import 'exams/exams_screen.dart';
import 'profile/profile_screen.dart';

/// Tela Wrapper principal que gerencia as abas inferiores e o estado global da aplicação Sanitas.
class MainWrapperScreen extends StatefulWidget {
  const MainWrapperScreen({super.key});

  @override
  State<MainWrapperScreen> createState() => _MainWrapperScreenState();
}

class _MainWrapperScreenState extends State<MainWrapperScreen> {
  int _currentIndex = 0;
  late final HealthController _healthController;

  @override
  void initState() {
    super.initState();
    _healthController = HealthController();
  }

  @override
  void dispose() {
    _healthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _healthController,
      builder: (context, child) {
        // Exibe tela de autenticação caso o usuário esteja deslogado
        if (!_healthController.isAuthenticated) {
          return LoginScreen(controller: _healthController);
        }

        final List<Widget> screens = [
          HomeScreen(controller: _healthController),
          ExamsScreen(controller: _healthController),
          ProfileScreen(controller: _healthController),
        ];

        return Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            selectedItemColor: Colors.teal[800],
            unselectedItemColor: Colors.grey.shade600,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            unselectedLabelStyle: const TextStyle(fontSize: 14),
            elevation: 8,
            iconSize: 30, // Ícones ampliados para acessibilidade 50+
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Início',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.folder_open_outlined),
                activeIcon: Icon(Icons.folder_shared),
                label: 'Exames',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.account_circle),
                label: 'Perfil',
              ),
            ],
          ),
        );
      },
    );
  }
}
