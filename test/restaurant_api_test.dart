import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tosik/data/api/api_service.dart';
import 'package:tosik/data/model/restaurant_detail_model.dart';
import 'package:tosik/data/model/restaurant_list_model.dart';
import 'restaurant_api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  const String getFetchAllRestaurantResponse = '''
  {
    "error": false,
    "message": "success",
    "count": 2,
    "restaurants": [
      {
        "id": "ygewwl55ktckfw1e867",
        "name": "Istana Emas",
        "description": "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
        "pictureId": "05",
        "city": "Balikpapan",
        "rating": 4.5
      },
      {
        "id": "fnfn8mytkpmkfw1e867",
        "name": "Makan mudah",
        "description": "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure.",
        "pictureId": "22",
        "city": "Medan",
        "rating": 3.7
      },
    ]
  }
  ''';

  const String getDetailRestaurantResponse = '''
  {
      "error": false,
      "message": "success",
      "restaurant": {
      "id": "ygewwl55ktckfw1e867",
      "name": "Istana Emas",
      "description": "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
      "city": "Balikpapan",
      "address": "Jln. Belimbing Timur no 27",
      "pictureId": "05",
      "rating": 4.5,
      "categories": [
        {
          "name": "Bali"
        }
      ],
      "menus": {
        "foods": [
          {
            "name": "Daging Sapi"
          },
          {
            "name": "Bebek crepes"
          },
        ],
        "drinks": [
          {
            "name": "Sirup"
         },
          {
            "name": "Jus mangga"
          },
        ]
      },
      "customerReviews": [
        {
          "name": "Gilang",
          "review": "Tempatnya bagus namun menurut saya masih sedikit mahal.",
          "date": "13 Juli 2019"
        },
        {
          "name": "Ahmad",
          "review": "Tidak ada duanya!",
          "date": "14 Agustus 2018"
        },
      ]
    }
  }
  ''';

  group('Test Restaurant API', () {
    final MockClient client = MockClient();
    final ApiService apiService = ApiService(client);

    test('verify json parsing fetch all restaurant', () async {
      when(client.get(Uri.parse('${ApiService.baseurl}/list'))).thenAnswer(
          (_) async => http.Response(getFetchAllRestaurantResponse, 200));

      expect(await apiService.getRestaurantList(), isA<RestaurantListResult>());
    });

    test('verify json parsing detail restaurant by id', () async {
      const String id = 'rqdv5juczeskfw1e867';

      when(client.get(Uri.parse('${ApiService.baseurl}/detail/$id')))
          .thenAnswer(
              (_) async => http.Response(getDetailRestaurantResponse, 200));

      expect(
        await apiService.getRestaurantDetail(id),
        isA<RestaurantDetailResult>(),
      );
    });
  });
}
