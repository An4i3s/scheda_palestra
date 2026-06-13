
import 'package:flutter/material.dart';
import 'package:scheda_palestra/features/home/presentation/views/home_page.dart';
import 'package:scheda_palestra/features/schede/presentation/views/scheda_page.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_view.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _MainPageState();
}

class _MainPageState extends State<App> {
  int _currentIndex = 0;

  final _pages = const [
    HomePage(),
    WorkoutView(),
    SchedePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        backgroundColor: Colors.white,
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
              icon: Icon(Icons.man_rounded),
              selectedIcon: Icon(Icons.man_rounded),
              label: 'Workout',
            ),
            NavigationDestination(
              icon: Icon(Icons.fitness_center_outlined),
              selectedIcon: Icon(Icons.fitness_center),
              label: 'Schede',
            ),
            // NavigationDestination(
            //   icon: Icon(Icons.fitbit_outlined),
            //   selectedIcon: Icon(Icons.fitbit_outlined),
            //   label: 'Esercizi',
            // ),
          ],
        ),
      ),
    );
  }
}