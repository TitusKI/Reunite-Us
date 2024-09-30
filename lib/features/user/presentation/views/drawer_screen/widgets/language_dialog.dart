import 'package:afalagi/core/constants/presentation_export.dart';

void showLanguageDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return AlertDialog(
            title: const Text('Select Language'),
            // content: const LanguageDropdown(),
            actions: <Widget>[
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    },
  );
}
