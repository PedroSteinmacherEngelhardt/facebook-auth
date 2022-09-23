import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter login com Facebook',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Login com Facebook'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map? _userData;

  void _login() async {
    final result = await FacebookAuth.instance
        .login(permissions: ["public_profile", "email"]);

    if (result.status == LoginStatus.success) {
      final requestData =
          await FacebookAuth.instance.getUserData(fields: "email, name");

      setState(() {
        _userData = requestData;
      });
    }
  }

  void _logout() {
    setState(() {
      _userData = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Católica de Santa Catarina',
                style: Theme.of(context).textTheme.headline6),
            Text('aluno: Pedro Henrique Steinmacher Engelhardt'),
            Text(
              _userData == null
                  ? 'Logue utilizando o Facebook'
                  : 'Você está logado',
            ),
            OutlinedButton(
              onPressed: () async {
                /**
                 * Se não existir usuario abre a pagina de autentição do facebook
                 */
                if (_userData == null) {
                  _login();
                } else {
                  /**
                     * Se o usuário já estiver logado o botão será para deslogar
                     * setando o userData para null
                     */
                  _logout();
                }
              },
              child: Text(
                _userData == null ? 'Logar' : 'Deslogar',
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
