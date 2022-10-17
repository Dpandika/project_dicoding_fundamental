import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_dicoding_fundamental/data/model/dio_model.dart';
import 'package:project_dicoding_fundamental/data/model/dio_response.dart';

import 'json_reader.dart';

void main() {
  const testDioModel = DioModel(
    id: 'rqdv5juczeskfw1e867',
    name: 'Melting Pot',
    city: 'Medan',
    pictureId: '14',
    rating: 4.2,
    description:
    "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
  );

  const testDioToResponseModel =
  DioToResponse(restaurant: <DioModel>[testDioModel]);

  group('from json', () {
    test("should return a valid model from JSON", () async {
      final Map<String, dynamic> jsonMap =
      json.decode(readJson('dummy/restaurant_list_data.json'));

      final result = DioToResponse.fromJson(jsonMap);

      expect(result, testDioToResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map', () async {
      final result = testDioToResponseModel.toJson();
      final expectedJsonMap = {
        "restaurants": [
          {
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description":
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
            "pictureId": "14",
            "city": "Medan",
            "rating": 4.2,
          }
        ]
      };
      expect(result[0], expectedJsonMap[0]);
    });
  });
}
