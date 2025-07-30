import 'dart:convert';

import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:giphy_gifs_core/src/data/datasources/giphy_api_client.dart';
import 'package:giphy_gifs_core/src/data/models/gif_model.dart';

import 'giphy_api_client_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late GiphyApiClient apiClient;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    apiClient = GiphyApiClient(apiKey: 'test_key', client: mockClient);
  });

  group('getTrendingGifs', () {
    test('returns a list of GifModel if the http call completes successfully', () async {
      final response = {
        'data': [
          {
            'id': '1',
            'title': 'Test GIF 1',
            'images': {
              'original': {
                'url': 'https://example.com/1.gif',
                'width': '100',
                'height': '100'
              }
            }
          }
        ]
      };

      when(mockClient.get(any)).thenAnswer((_) async => http.Response(json.encode(response), 200));

      final gifs = await apiClient.getTrendingGifs();

      expect(gifs, isA<List<GifModel>>());
      expect(gifs.first.id, '1');
    });

    test('throws an exception if the http call completes with an error', () {
      when(mockClient.get(any)).thenAnswer((_) async => http.Response('Not Found', 404));

      expect(apiClient.getTrendingGifs(), throwsException);
    });
  });
}
