import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheda_palestra/core/i18n/local_cubit.dart';
import 'package:scheda_palestra/core/i18n/local_extension.dart';
import 'package:scheda_palestra/features/home/presentation/widgets/language_widget.dart';

class LanguageList extends StatefulWidget {
  const LanguageList({super.key});

  @override
  State<LanguageList> createState() => _LanguageListState();
}

class _LanguageListState extends State<LanguageList> {
  int _selectedIndex = 0;

  void _setSelectedIndex(int index, String locale) {
    setState(() {
      _selectedIndex = index;
    });
    context.read<LocaleCubit>().changeLocale(Locale(locale));  
  }

  @override
  void initState() {
    super.initState();
    String? locale = context.read<LocaleCubit>().state.toString();
    _selectedIndex = _getIntFormLocale(locale);
  }

  int _getIntFormLocale(String locale){
    switch(locale){
      case "it": return 0;
      case "en": return 1;
      case "es": return 2;
      case "fr": return 3;
      default: return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        LanguageContainerWidget(
          flag: '🇮🇹',
          language: context.i18n.italian,
          isSelected: _selectedIndex == 0,
          onPressed: () => _setSelectedIndex(0, "it"),
        ),
        LanguageContainerWidget(
          onPressed: () => _setSelectedIndex(1, "en"),
          flag: '🇬🇧',
          language: context.i18n.english,
          isSelected: _selectedIndex == 1,
        ),
           LanguageContainerWidget(
          onPressed: () => _setSelectedIndex(2, "es"),
          flag: '🇪🇸',
          language: context.i18n.spanish,
          isSelected: _selectedIndex == 2,
        ),
           LanguageContainerWidget(
          onPressed: () => _setSelectedIndex(3, "fr"),
          flag: '🇫🇷',
          language: context.i18n.french,
          isSelected: _selectedIndex == 3,
        ),
      ],
    );
  }
}
