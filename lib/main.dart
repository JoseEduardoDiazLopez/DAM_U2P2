import 'mostrar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PaginaInicio(),
  ));
}

class PaginaInicio extends StatefulWidget {
  const PaginaInicio({Key? key}) : super(key: key);

  @override
  _EstadoPaginaInicio createState() => _EstadoPaginaInicio();
}

class _EstadoPaginaInicio extends State<PaginaInicio> {
  final TextEditingController _controladorUsuario = TextEditingController();
  final TextEditingController _controladorContrasena = TextEditingController();

  final String _usuarioValido = 'usuario';
  final String _contrasenaValida = 'contraseña';
  String _mensajeError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Ingresar",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
              TextField(
                controller: _controladorUsuario,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelText: 'Nombre de Usuario',
                    labelStyle: TextStyle(color: Colors.black)),
              ),
              TextField(
                controller: _controladorContrasena,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle: TextStyle(color: Colors.black)),
                obscureText: true,
              ),
              SizedBox(height: 80),
              ElevatedButton(
                  onPressed: _iniciarSesion,
                  child: Text(
                    'INICIAR SESIÓN',
                    style: TextStyle(
                      color: Colors.purple,
                    ),
                  )),
              if (_mensajeError.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    _mensajeError,
                    style: TextStyle(
                        color: Colors.black, backgroundColor: Colors.yellow),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _iniciarSesion() {
    String usuarioIngresado = _controladorUsuario.text;
    String contrasenaIngresada = _controladorContrasena.text;
    if (usuarioIngresado == _usuarioValido &&
        contrasenaIngresada == _contrasenaValida) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Mostrar()),
      );
    } else {
      setState(() {
        _mensajeError = 'Datos incorrectos';
      });
    }
  }
}
