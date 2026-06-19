import 'package:flutter/material.dart';

import '../models/game.dart';
import '../services/mongo_service.dart';

class GameProvider extends ChangeNotifier {

  List<Game> _games = [];

  List<Game> get games => _games;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> loadGames() async {

    _isLoading = true;
    notifyListeners();

    try {

      _games = await MongoService.getGames();

    } catch (e) {

      debugPrint("Error cargando juegos: $e");

    } finally {

      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addGame(Game game) async {

    try {

      await MongoService.insertGame(game);

      await loadGames();

    } catch (e) {

      debugPrint("Error agregando juego: $e");
    }
  }

  Future<void> updateGame(Game game) async {

    try {

      await MongoService.updateGame(game);

      await loadGames();

    } catch (e) {

      debugPrint("Error actualizando juego: $e");
    }
  }

  Future<void> deleteGame(String id) async {

    try {

      await MongoService.deleteGame(id);

      _games.removeWhere(
        (game) => game.id == id,
      );

      notifyListeners();

    } catch (e) {

      debugPrint("Error eliminando juego: $e");
    }
  }

  Game? getById(String id) {

    try {

      return _games.firstWhere(
        (game) => game.id == id,
      );

    } catch (_) {

      return null;
    }
  }
}