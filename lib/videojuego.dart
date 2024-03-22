class Videojuego {
  String nombre;
  String anoLanzamiento;
  String plataforma;

  Videojuego({
    required this.nombre,
    required this.anoLanzamiento,
    required this.plataforma,
  });

  @override
  String toString() {
    return "$nombre&&$anoLanzamiento&&$plataforma";
  }
}
