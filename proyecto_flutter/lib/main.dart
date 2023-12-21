import 'package:flutter/material.dart';
import 'package:proyecto_flutter/add_users.dart';
import 'package:proyecto_flutter/data/DBHelper.dart';

import 'models/user.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App de Usuarios",
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
      home: const HomePageMain(),
    );
  }
}

class HomePageMain extends StatefulWidget {
  const HomePageMain({super.key});

  @override
  MyHomePage createState() => MyHomePage();

}

class MyHomePage extends State<HomePageMain> {
  String title = 'App de Usuarios';
  final DBHelper _dbHelper = DBHelper();
  Widget _users = const SizedBox();
  Widget appBarTitle = Text(
    "Search user",
    style: TextStyle(color: Colors.white)
  );
  Icon icon = Icon(
    Icons.search,
    color: Colors.white
  );
  bool _isSearching = false;
  BuildContext? _context;
  final TextEditingController _controller = new TextEditingController();
  MyHomePage() {
    userList(null);
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle, // Aplicar el estilo de titleLarge
        actions: [
          IconButton(
              onPressed: (){
                setState(() {
                  if(this.icon.icon == Icons.search){
                    this.icon = Icon(
                      Icons.close,
                      color: Colors.white
                    );
                    this.appBarTitle = TextField(
                      controller: _controller,
                      style: TextStyle(
                        color: Colors.white
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.white),
                        hintText: "Search...",
                        hintStyle: TextStyle(color: Colors.white)
                      ),
                      onChanged: searchOperation,
                    );
                    _handleSearchStart();
                  }else {
                    searchOperation(null);
                    _handleSearchEnd();
                  }
                });
              },
              icon: icon
          ),
          IconButton(
              onPressed: () => {
                ///Pasamos el contexto de la pantalla en donde nos encontramos y a tráves de push indicamos a
                ///que otra pantalla vamos a ir.
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (_,__,___) => const AddUsers(),
                )),
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              )
          )
        ],
      ),
      body: ListView(
        children: [
          _users
        ],
      ),
    );
  }

  Container buildItem(User doc){
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
          color: const Color(0xFF333366),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 5.0,
              offset: Offset(0.0, 5.0),
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
                    doc.name,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white
                    ),
                  ),
                  Text(
                    doc.lastname,
                    style: const TextStyle(
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

  void _handleSearchStart(){
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd(){
    setState(() {
      this.icon = Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = Text(
        "Search user",
        style: new TextStyle(color: Colors.white),
      );
      _isSearching = false;
      _controller.clear();
    });
  }

  void searchOperation(String? searchText){
    if(_isSearching){
      print(searchText);
    }
  }

  Future userList(String? searchText) async {
    List<User>? listUser = await _dbHelper.getUsers();
    setState((){
      if(searchText == null || searchText == ""){
        _users = Column(
          children: listUser?.map((user) => buildItem(user)).toList() ?? [],
        );
      }
        });
  }
}
