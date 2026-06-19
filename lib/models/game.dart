class Game {
  String? id;
  String nombre;
  String genero;
  String plataforma;
  String imagen;
  double rating;
  String nota;

  Game({
    this.id,
    required this.nombre,
    required this.genero,
    required this.plataforma,
    required this.imagen,
    required this.rating,
    required this.nota,
  });

  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      id: map['id'],
      nombre: map['nombre'] ?? '',
      genero: map['genero'] ?? '',
      plataforma: map['plataforma'] ?? '',
      imagen: map['imagen'] ?? '',
      rating: (map['rating'] ?? 0).toDouble(),
      nota: map['nota'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'genero': genero,
      'plataforma': plataforma,
      'imagen': imagen,
      'rating': rating,
      'nota': nota,
    };
  }
}