
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/home/presentation/views/home_page.dart';
import 'package:scheda_palestra/features/schede/presentation/views/scheda_page.dart';
import 'package:scheda_palestra/features/workout/presentation/views/workout_view.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        backgroundColor: Colors.white,
        indicatorColor: Colors.transparent,
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(color: AppColors.primaryBtnColor, fontWeight: FontWeight.w600);
          }
          return const TextStyle(color: Colors.black);
        }),
        destinations: [
          NavigationDestination(
            icon: SvgPicture.asset("assets/icons/home.svg"),
            selectedIcon:SvgPicture.asset("assets/icons/home.svg", colorFilter: ColorFilter.mode(AppColors.primaryBtnColor, BlendMode.srcIn),),
            label: 'Home',
          ),
            NavigationDestination(
            icon:  SvgPicture.asset("assets/icons/muscle.svg"),
            selectedIcon: SvgPicture.asset("assets/icons/muscle.svg", colorFilter: ColorFilter.mode(AppColors.primaryBtnColor, BlendMode.srcIn),),
            label: 'Workout',
          ),
          NavigationDestination(
            icon: SvgPicture.asset("assets/icons/note.svg"),
            selectedIcon: SvgPicture.asset("assets/icons/note.svg", colorFilter: ColorFilter.mode(AppColors.primaryBtnColor, BlendMode.srcIn),),
            label: 'Schede',
          ),
        ],
      ),
    );
  }
}