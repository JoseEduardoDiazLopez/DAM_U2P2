import 'package:flutter/material.dart';
import 'listaVideojuegos.dart';
import 'videojuego.dart';

class Insertar extends StatefulWidget {
  const Insertar({Key? key}) : super(key: key);

  @override
  State<Insertar> createState() => _InsertarState();
}

class _InsertarState extends State<Insertar> {
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _anoLanzamiento = TextEditingController();
  final TextEditingController _plataforma = TextEditingController();
  final ListaVideojuegos _listaVideojuegos = ListaVideojuegos();

  @override
  void initState() {
    super.initState();
    _cargarVideojuegos();
  }

  Future<void> _cargarVideojuegos() async {
    await _listaVideojuegos.cargarDatos();
  }

  Future<void> _guardarVideojuego() async {
    final videojuego = Videojuego(
      nombre: _nombre.text,
      anoLanzamiento: _anoLanzamiento.text,
      plataforma: _plataforma.text,
    );

    _listaVideojuegos.nuevo(videojuego);
    await _listaVideojuegos.guardarArchivo();

    _nombre.clear();
    _anoLanzamiento.clear();
    _plataforma.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Videojuego agregado')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insertar Videojuegos',
            style: TextStyle(color: Colors.limeAccent, fontSize: 15)),
        backgroundColor: Colors.black54,
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextField(
              controller: _nombre,
              style: TextStyle(color: Colors.black54),
              cursorColor: Colors.black54,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nombre',
                  labelStyle: TextStyle(color: Colors.black54),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54))),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _anoLanzamiento,
              style: TextStyle(color: Colors.black54),
              cursorColor: Colors.black54,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Año de lanzamiento',
                  labelStyle: TextStyle(color: Colors.black54),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54))),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _plataforma,
              style: TextStyle(color: Colors.black54),
              cursorColor: Colors.black54,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Plataforma',
                labelStyle: TextStyle(color: Colors.black54),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _guardarVideojuego,
              child: Text("Agregar", style: TextStyle(color: Colors.black)),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed))
                      return Colors.white;
                    return Colors.limeAccent;
                  },
                ),
                foregroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed))
                      return Colors.limeAccent;
                    return Colors.white;
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
