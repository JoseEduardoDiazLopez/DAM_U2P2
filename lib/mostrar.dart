import 'actualizar.dart';
import 'insertar.dart';
import 'eliminar.dart';
import 'main.dart';
import 'videojuego.dart';
import 'listaVideojuegos.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Mostrar(),
  ));
}

class Mostrar extends StatefulWidget {
  const Mostrar({Key? key}) : super(key: key);

  @override
  _MostrarState createState() => _MostrarState();
}

class _MostrarState extends State<Mostrar> {
  final ListaVideojuegos _listaVideojuegos = ListaVideojuegos();

  @override
  void initState() {
    super.initState();
    _cargarVideojuegos();
  }

  Future<void> _cargarVideojuegos() async {
    SharedPreferences almacen = await SharedPreferences.getInstance();
    List<String> buffer = almacen.getStringList("buffer") ?? [];
    List<Videojuego> tempData = [];
    for (String rawVideojuego in buffer) {
      tempData.add(_listaVideojuegos.toVideojuego(rawVideojuego));
    }

    if (mounted) {
      setState(() {
        _listaVideojuegos.data = tempData;
      });
    }
  }

  void _recargarLista() {
    _cargarVideojuegos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de Videojuegos',
          style: TextStyle(color: Colors.limeAccent),
        ),
        backgroundColor: Colors.black54,
      ),
      drawer: _buildDrawer(context),
      body: ListView.builder(
        itemCount: _listaVideojuegos.data.length,
        itemBuilder: (context, index) {
          Videojuego videojuego = _listaVideojuegos.data[index];
          return Card(
            child: ListTile(
              leading: Icon(Icons.videogame_asset, color: Colors.blue),
              title: Text('${videojuego.nombre}'),
              subtitle: Text(
                  'Plataforma: ${videojuego.plataforma} - Año de lanzamiento: ${videojuego.anoLanzamiento}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _recargarLista,
        tooltip: 'Recargar',
        child: Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 100,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black54,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.limeAccent,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Mostrar())),
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Capturar'),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Insertar())),
          ),
          ListTile(
            leading: Icon(Icons.arrow_circle_up),
            title: Text('Actualizar'),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Actualizar())),
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Eliminar'),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Eliminar())),
          ),
          ListTile(
            leading: Icon(Icons.door_back_door_outlined),
            title: Text('Cerrar sesión'),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => PaginaInicio())),
          ),
        ],
      ),
    );
  }
}
