import 'videojuego.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListaVideojuegos {
  List<Videojuego> data = [];

  Videojuego toVideojuego(String cod) {
    List res = cod.split("&&");
    Videojuego juego = Videojuego(
      nombre: res[0],
      anoLanzamiento: res[1],
      plataforma: res[2],
    );
    return juego;
  }

  Future<bool> guardarArchivo() async {
    SharedPreferences almacen = await SharedPreferences.getInstance();
    List<String> buffer = [];
    data.forEach((element) {
      buffer.add(element.toString());
    });
    almacen.setStringList("buffer", buffer);
    return true;
  }

  Future cargarDatos() async {
    SharedPreferences almacen = await SharedPreferences.getInstance();
    List<String> buffer = [];
    buffer = almacen.getStringList("buffer") ?? [];
    buffer.forEach((element) {
      data.add(toVideojuego(element));
    });
  }

  Future<bool> borrarAlmacen() async {
    SharedPreferences almacen = await SharedPreferences.getInstance();
    almacen.remove("buffer");
    return true;
  }

  void nuevo(Videojuego juego) {
    data.add(juego);
  }

  void actualizar(Videojuego juego, int pos) {
    data[pos] = juego;
  }

  void eliminar(int pos) {
    data.removeAt(pos);
  }

  Videojuego? buscarPorNombre(String nombre) {
    try {
      return data.firstWhere((juego) => juego.nombre == nombre);
    } catch (e) {
      return null;
    }
  }

  void actualizarVideojuego(Videojuego juegoActualizado) {
    int index =
        data.indexWhere((juego) => juego.nombre == juegoActualizado.nombre);
    if (index != -1) {
      data[index] = juegoActualizado;
    }
  }
}
