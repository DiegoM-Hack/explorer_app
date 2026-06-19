import 'package:mongo_dart/mongo_dart.dart';

import '../models/game.dart';

class MongoService {

  static const String mongoUrl =
      'mongodb+srv://diegomontaluisa01_db_user:Aries1840@cluster0.a3wv22y.mongodb.net/Movil-games?retryWrites=true&w=majority';

  static const String collectionName = 'videojuegos';

  static late Db db;
  static late DbCollection collection;

  static Future<void> connect() async {

    db = await Db.create(mongoUrl);

    await db.open();

    collection = db.collection(collectionName);

    print("MongoDB conectado");
  }

  static Future<List<Game>> getGames() async {

    final List<Map<String, dynamic>> data =
        await collection.find().toList();

    return data.map((item) {

      item['id'] = (item['_id'] as ObjectId).oid;

      return Game.fromMap(item);

    }).toList();
  }

static Future<void> insertGame(Game game) async {

  final data = game.toMap();

  data.remove('id');

  await collection.insertOne(data);
}

  static Future<void> updateGame(Game game) async {
    print(game.id);

    await collection.updateOne(

      where.id(ObjectId.parse(game.id!)),

      modify
          .set('nombre', game.nombre)
          .set('genero', game.genero)
          .set('plataforma', game.plataforma)
          .set('imagen', game.imagen)
          .set('rating', game.rating)
          .set('nota', game.nota),
    );
  }

  static Future<void> deleteGame(String id) async {

    await collection.deleteOne(
      where.id(ObjectId.parse(id)),
    );
  }
}