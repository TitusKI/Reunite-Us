import 'package:afalagi/routes/export.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.SIGN_IN);
            },
            child: const Text("Sign in ")));
  }
}
