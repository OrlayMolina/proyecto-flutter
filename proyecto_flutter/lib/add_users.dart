import 'package:flutter/material.dart';
import 'package:proyecto_flutter/main.dart';

class AddUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepOrange, // Personalizar el color del AppBar
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            color: Colors.white, // Cambiar el color del texto del título a blanco
            fontSize: 20, // Tamaño del texto del título
            fontWeight: FontWeight.bold, // Peso de la fuente del título
          ),
        ),
      ),
      home: AddUser(title: 'Registrar'),
    );
  }
}

class AddUser extends StatelessWidget {
  final String title;
  AddUser({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: Theme.of(context).textTheme.titleLarge),
        leading: IconButton(
            onPressed: () => {
              ///Pasamos el contexto de la pantalla en donde nos encontramos y a tráves de push indicamos a
              ///que otra pantalla vamos a ir.
              Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (_,__,___) => MyApp(),
              )),
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )
        )
      ),
    );
  }
}