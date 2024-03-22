import 'package:flutter/material.dart';
import 'listaVideojuegos.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'videojuego.dart';

class Actualizar extends StatefulWidget {
  const Actualizar({Key? key}) : super(key: key);
  @override
  State<Actualizar> createState() => _ActualizarState();
}

class _ActualizarState extends State<Actualizar> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _anoLanzamientoController =
      TextEditingController();
  final TextEditingController _plataformaController = TextEditingController();
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

  void _mostrarDialogoActualizar(Videojuego videojuego, int index) {
    _nombreController.text = videojuego.nombre;
    _anoLanzamientoController.text = videojuego.anoLanzamiento;
    _plataformaController.text = videojuego.plataforma;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Actualizar Videojuego'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                    controller: _nombreController,
                    decoration: InputDecoration(labelText: 'Nombre')),
                TextField(
                    controller: _anoLanzamientoController,
                    decoration:
                        InputDecoration(labelText: 'Año de lanzamiento')),
                TextField(
                    controller: _plataformaController,
                    decoration: InputDecoration(labelText: 'Plataforma')),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Actualizar'),
              onPressed: () {
                setState(() {
                  videojuego.nombre = _nombreController.text;
                  videojuego.anoLanzamiento = _anoLanzamientoController.text;
                  videojuego.plataforma = _plataformaController.text;
                  _listaVideojuegos.actualizar(videojuego, index);
                  _listaVideojuegos.guardarArchivo();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar Videojuego',
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
                  'Plataforma: ${videojuego.plataforma} - Año de lanzamiento: ${videojuego.anoLanzamiento}'), // Cambiar acceso a campos
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => _mostrarDialogoActualizar(videojuego, index),
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
