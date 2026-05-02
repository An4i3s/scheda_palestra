// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:scheda_palestra/core/utils/router/app_router.dart';

// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       title: 'Scheda Palestra',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       routerConfig: AppRouter.router,
//       builder: (context, child) {
//         return _AppScaffoldWrapper(child: child);
//       },
//     );
//   }
// }

// class _AppScaffoldWrapper extends StatelessWidget {
//   final Widget? child;

//   const _AppScaffoldWrapper({required this.child});

//   @override
//   Widget build(BuildContext context) {
//     final location = GoRouterState.of(context).uri.toString();
//     final selectedIndex = location == '/' ? 0 : (location.startsWith('/schede') ? 1 : 0);

//     return Scaffold(
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: selectedIndex,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.fitness_center),
//             label: 'Schede',
//           ),
//         ],
//         onTap: (index) {
//           switch (index) {
//             case 0:
//               context.goNamed('home');
//               break;
//             case 1:
//               context.goNamed('schede');
//               break;
//           }
//         },
//       ),
//       body: child,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:scheda_palestra/features/exercises/presentation/views/exercises_page.dart';
import 'package:scheda_palestra/features/home/presentation/views/home_page.dart';
import 'package:scheda_palestra/features/schede/presentation/views/scheda_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _MainPageState();
}

class _MainPageState extends State<App> {
  int _currentIndex = 0;

  final _pages = const [
    HomePage(),
    SchedePage(),
    ExercisesPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.fitness_center_outlined),
            selectedIcon: Icon(Icons.fitness_center),
            label: 'Schede',
          ),
          NavigationDestination(
            icon: Icon(Icons.fitbit_outlined),
            selectedIcon: Icon(Icons.fitness_center),
            label: 'Esercizi',
          ),
        ],
      ),
    );
  }
}