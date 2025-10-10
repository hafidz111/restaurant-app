import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/data/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

import '../mocks/api_services_mock.mocks.dart';

void main() {
  late MockApiServices mockApiServices;
  late RestaurantListProvider provider;

  setUp(() {
    mockApiServices = MockApiServices();
    provider = RestaurantListProvider(mockApiServices);
  });

  test('State awal provider harus RestaurantListNoneState', () {
    expect(provider.resultState.runtimeType, equals(RestaurantListNoneState));
  });

  test('Harus mengembalikan daftar restoran ketika API berhasil', () async {
    final mockResponse = RestauranListResponse(
      error: false,
      message: "success",
      count: 2,
      restaurants: [
        Restaurant(
          id: "r1",
          name: "Resto Enak",
          description: "Deskripsi",
          city: "Jakarta",
          pictureId: "pic1",
          rating: 4.5,
        ),
        Restaurant(
          id: "r2",
          name: "Resto Mantap",
          description: "Deskripsi 2",
          city: "Bandung",
          pictureId: "pic2",
          rating: 4.2,
        ),
      ],
    );

    when(
      mockApiServices.getRestaurantList(),
    ).thenAnswer((_) async => mockResponse);

    await provider.fetchRestaurantList();

    expect(provider.resultState, isA<RestaurantListLoadedState>());
    final state = provider.resultState as RestaurantListLoadedState;
    expect(state.data.length, 2);
    expect(state.data.first.name, equals("Resto Enak"));
  });

  test(
    'Harus mengembalikan kesalahan ketika pengambilan data API gagal',
    () async {
      when(
        mockApiServices.getRestaurantList(),
      ).thenThrow(Exception('Failed to load'));

      await provider.fetchRestaurantList();

      expect(provider.resultState, isA<RestaurantListErrorState>());
      final state = provider.resultState as RestaurantListErrorState;
      expect(state.error, contains("Terjadi kesalahan"));
    },
  );
}
