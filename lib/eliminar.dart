import 'package:flutter/material.dart';
import 'listaVideojuegos.dart';
import 'videojuego.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Eliminar extends StatefulWidget {
  const Eliminar({Key? key}) : super(key: key);

  @override
  State<Eliminar> createState() => _EliminarState();
}

class _EliminarState extends State<Eliminar> {
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

  void _eliminarVideojuego(int index) {
    setState(() {
      _listaVideojuegos.data.removeAt(index);
      _listaVideojuegos.guardarArchivo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eliminar Videojuego',
            style: TextStyle(color: Colors.limeAccent, fontSize: 15)),
        backgroundColor: Colors.black54,
      ),
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
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => _mostrarDialogoConfirmacion(index),
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }

  void _mostrarDialogoConfirmacion(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Eliminación'),
          content:
              Text('¿Estás seguro de que quieres eliminar este videojuego?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Eliminar'),
              onPressed: () {
                _eliminarVideojuego(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
