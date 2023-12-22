import 'package:flutter/material.dart';
import 'package:proyecto_flutter/main.dart';
import 'package:proyecto_flutter/models/user.dart';
import 'package:proyecto_flutter/data/DBHelper.dart';


class AddUsers extends StatelessWidget {
  final User? _user;
  const AddUsers(this._user, {super.key});

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
      routes: <String, WidgetBuilder>{
        '/AddUsers': (BuildContext context) => const AddUsers(null),
        '/MyApp': (BuildContext context) => const MyApp(),
      },
      home: Scaffold(
        appBar: AppBar(
            title: Text('Registrar', style: Theme.of(context).textTheme.titleLarge),
            leading: IconButton(
                onPressed: () => {
                  ///Pasamos el contexto de la pantalla en donde nos encontramos y a tráves de push indicamos a
                  ///que otra pantalla vamos a ir.
                  Navigator.of(context).pushReplacementNamed('/MyApp'),
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                )
            ),
        ),
        body: UserForm(_user),
      ),
    );
  }
}

/*class AddUser extends StatelessWidget {
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
}*/

class UserForm extends StatefulWidget {
  final User? _user;
  const UserForm(this._user, {super.key});

  @override
  UserFormState createState() {
    return UserFormState(_user);
  }
}

class UserFormState extends State<UserForm> {
  final User? _user;
  final _formKey = GlobalKey<FormState>();
  final _nombre = TextEditingController();
  final _apellido = TextEditingController();
  final _correo = TextEditingController();
  UserFormState(this._user){
    if(_user != null){
      _nombre.text = _user.name;
      _apellido.text = _user.lastname;
      _correo.text = _user.email;
    }
  }

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
                  if(_user == null){
                    await dbHelper.insertUser(User(
                        id: 0,
                        name: _nombre.text,
                        lastname: _apellido.text,
                        email: _correo.text
                    ), context);
                  }else {
                    _user.name = _nombre.text;
                    _user.lastname = _apellido.text;
                    _user.email = _correo.text;
                    dbHelper.updateUser(_user);
                  }
                  Navigator.of(context).pushNamedAndRemoveUntil('/MyApp', ModalRoute.withName('/MyApp'));
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