import 'package:afalagi/bloc/language/language_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageDropdown extends StatelessWidget {
  const LanguageDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    String? selectedLanguage;
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return DropdownButton<String>(
          value: selectedLanguage,
          icon: const Icon(Icons.language, color: Colors.white),
          underline: const SizedBox(),
          items: const [
            DropdownMenuItem(
              value: 'en',
              child: Text('English'),
            ),
            DropdownMenuItem(
              value: 'am',
              child: Text('Amharic'),
            ),
          ],
          onChanged: (value) {
            selectedLanguage = value!;
            if (value == 'en') {
              context.read<LanguageBloc>().add(LanguageEvent(onEnglish: value));
            } else if (value == 'am') {
              context.read<LanguageBloc>().add(LanguageEvent(onAmharic: value));
            }
          },
          selectedItemBuilder: (context) {
            return [
              const Text('English', style: TextStyle(color: Colors.white)),
              const Text('Amharic', style: TextStyle(color: Colors.white)),
            ];
          },
          // hint: const Text(
          //   "Language",
          //   style: TextStyle(color: Colors.white),
          // ),
        );
      },
    );
  }
}
