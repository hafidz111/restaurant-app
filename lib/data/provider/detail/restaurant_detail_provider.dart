import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantDetailProvider(this._apiServices);

  RestaurantDetailResultState _resultState = RestaurantDetailNoneState();

  RestaurantDetailResultState get resultState => _resultState;

  Future<void> fetchRestaurantDetail(String id) async {
    try {
      _resultState = RestaurantDetailLoadingState();

      final result = await _apiServices.getRestaurantDetail(id);

      if (result.error) {
        _resultState = RestaurantDetailErrorState(result.message);
      } else {
        _resultState = RestaurantDetailLoadedState(result.restaurant);
      }
    } on Exception catch (e) {
      String message = "Terjadi kesalahan. Silakan coba lagi.";

      if (e.toString().contains("SocketException")) {
        message = "Tidak ada koneksi internet. Periksa jaringan Anda.";
      } else if (e.toString().contains("TimeoutException")) {
        message = "Koneksi timeout. Coba lagi nanti.";
      }

      _resultState = RestaurantDetailErrorState(message);
    } finally {
      notifyListeners();
    }
  }

  void reset() {
    _resultState = RestaurantDetailNoneState();
    notifyListeners();
  }
}
