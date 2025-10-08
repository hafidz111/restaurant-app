import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantListProvider(this._apiServices);

  RestaurantListResultState _resultState = RestaurantListNoneState();
  RestaurantListResultState get resultState => _resultState;

  Future<void> fetchRestaurantList() async {
    try {
      _resultState = RestaurantListLoadingState();

      final response = await _apiServices.getRestaurantList();
      _resultState = RestaurantListLoadedState(data: response.restaurants);
    } catch (e) {
      String message = "Terjadi kesalahan. Silakan coba lagi.";

      if (e.toString().contains("SocketException")) {
        message = "Tidak ada koneksi internet. Periksa jaringan Anda.";
      } else if (e.toString().contains("TimeoutException")) {
        message = "Koneksi timeout. Coba lagi nanti.";
      }
      _resultState = RestaurantListErrorState(
        error: message,
      );
    } finally {
      notifyListeners();
    }
  }
}
