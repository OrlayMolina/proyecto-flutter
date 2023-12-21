import 'package:flutter/material.dart';
import 'package:proyecto_flutter/add_users.dart';

import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App de Usuarios",
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
      home: MyHomePage(title: 'App de Usuarios'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: Theme.of(context).textTheme.titleLarge), // Aplicar el estilo de titleLarge
        actions: [
          IconButton(
              onPressed: () => {
                ///Pasamos el contexto de la pantalla en donde nos encontramos y a tráves de push indicamos a
                ///que otra pantalla vamos a ir.
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (_,__,___) => AddUsers(),
                )),
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              )
          )
        ],
      ),
    );
  }

  Container? buildItem(User doc){
    return Container(
      height: 120.0,
      margin: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 5.0
      ),
      child: Stack(
        children: [
          card(doc)
        ],
      ),
    );
  }

  GestureDetector card(User doc){
    return GestureDetector(
      child: Container(
        height: 124.0,
        decoration: BoxDecoration(
          color: Color(0xFF333366),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 5.0,
              offset: new Offset(0.0, 5.0),
            )
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '${doc.name}',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white
                    ),
                  ),
                  Text(
                    '${doc.lastname}',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white
                    ),
                  ),
                ],
              )
            ],
          )
        ),
      ),
    );
  }
}
