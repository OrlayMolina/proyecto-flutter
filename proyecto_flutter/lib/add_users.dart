import 'package:flutter/material.dart';
import 'package:proyecto_flutter/main.dart';
import 'package:proyecto_flutter/models/user.dart';
import 'package:proyecto_flutter/data/DBHelper.dart';


class AddUsers extends StatelessWidget {
  const AddUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepOrange, // Personalizar el color del AppBar
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.white, // Cambiar el color del texto del título a blanco
            fontSize: 20, // Tamaño del texto del título
            fontWeight: FontWeight.bold, // Peso de la fuente del título
          ),
        ),
      ),
      home: const AddUser(title: 'Registrar'),
    );
  }
}

class AddUser extends StatelessWidget {
  final String title;
  const AddUser({Key? key, required this.title}) : super(key: key);

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
                pageBuilder: (_,__,___) => const MyApp(),
              )),
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )
        )
      ),
      body: const UserForm(),
    );
  }
}

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  UserFormState createState() {
    return UserFormState();
  }
}

class UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final _nombre = TextEditingController();
  final _apellido = TextEditingController();
  final _correo = TextEditingController();

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
              style: const TextStyle(
                fontSize: 20.0
              ),
              decoration: InputDecoration(
                labelText: "Nombre ",
                prefixIcon: const Icon(
                  Icons.person
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(),
                ),
              ),
              validator: (value){
                if(value?.isEmpty ?? true){
                  return 'Por favor ingrese el Nombre';
                }
                return null;
              },
              controller: _nombre,
            ),
          ),
          ///Input Apellido
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              style: const TextStyle(
                  fontSize: 20.0
              ),
              decoration: InputDecoration(
                labelText: "Apellido ",
                prefixIcon: const Icon(
                    Icons.person
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(),
                ),
              ),
              validator: (value){
                if(value?.isEmpty ?? true){
                  return 'Por favor ingrese el Apellido';
                }
                return null;
              },
              controller: _apellido,
            ),
          ),
          ///Input Correo
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            child: TextFormField(
                keyboardType: TextInputType.emailAddress,
              style: const TextStyle(
                  fontSize: 20.0
              ),
              decoration: InputDecoration(
                labelText: "Correo electrónico ",
                prefixIcon: const Icon(
                    Icons.email
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(),
                ),
              ),
              validator: (value){
                if(value?.isEmpty ?? true){
                  return 'Por favor ingrese el Correo electrónico';
                }
                return null;
              },
              controller: _correo,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            child: MaterialButton(
              minWidth: 200.0,
              height: 60.0,
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  var dbHelper = DBHelper();
                  await dbHelper.insertUser(User(
                      id: 0,
                      name: _nombre.text,
                      lastname: _apellido.text,
                      email: _correo.text
                  ), context);
                }
              },
              color: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0), // Define el radio de borde
              ),
              child: const Text(
                "Registrar",
                style: TextStyle(
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