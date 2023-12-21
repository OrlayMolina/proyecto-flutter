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
      body: UserForm(),
    );
  }
}

class UserForm extends StatefulWidget {
  @override
  UserFormState createState() {
    return UserFormState();
  }
}

class UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          ///Input Nombre
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              style: TextStyle(
                fontSize: 20.0
              ),
              decoration: InputDecoration(
                labelText: "Nombre: ",
                prefixIcon: Icon(
                  Icons.person
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(),
                ),
              ),
              validator: (value){
                if(value?.isEmpty ?? true){
                  return 'Por favor ingrese el Nombre';
                }
                return null;
              },
            ),
          ),
          ///Input Apellido
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              style: TextStyle(
                  fontSize: 20.0
              ),
              decoration: InputDecoration(
                labelText: "Apellido: ",
                prefixIcon: Icon(
                    Icons.person
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(),
                ),
              ),
              validator: (value){
                if(value?.isEmpty ?? true){
                  return 'Por favor ingrese el Apellido';
                }
                return null;
              },
            ),
          ),
          ///Input Correo
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            child: TextFormField(
                keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                  fontSize: 20.0
              ),
              decoration: InputDecoration(
                labelText: "Correo electrónico: ",
                prefixIcon: Icon(
                    Icons.email
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(),
                ),
              ),
              validator: (value){
                if(value?.isEmpty ?? true){
                  return 'Por favor ingrese el Correo electrónico';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            child: MaterialButton(
              minWidth: 200.0,
              height: 60.0,
              onPressed: () => {
                if(_formKey.currentState?.validate() ?? false){

                }
              },
              color: Colors.teal,
              child: Text(
                "Registrar",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  
}