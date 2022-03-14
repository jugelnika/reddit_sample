import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:reddit_project/core/data_handling/api_constants.dart';
import 'package:reddit_project/core/data_handling/data_states.dart';
import 'package:reddit_project/reddit_page/reddit_page_cubit.dart';

class MockHttp extends Mock implements http.Client {}

void main() {
  late MockHttp mockHttpClient;
  late RedditPageCubit cubit;
  Uri url = Uri.parse(ENVIROMENT.REDDIT_API_URL);

  setUp(() {
    mockHttpClient = MockHttp();
    cubit = RedditPageCubit(client: mockHttpClient);
  });

  test('Empty response gives failed State', () async {
    when(() => mockHttpClient.get(url))
        .thenAnswer((_) async => http.Response('', 200));

    await cubit.retrieve();

    expect(cubit.currentState is DataFailed, isTrue);
  });

  test('Incorrect json structure gives failed state', () async {
    when(() => mockHttpClient.get(url)).thenAnswer((_) async => http.Response(
        '{"kind": "Listing","DATA": {"after": "t3_tcpepp"}}', 200));

    await cubit.retrieve();

    expect(cubit.currentState is DataFailed, isTrue);
  });

  test('Correct json structure but failed http status code gives failed state',
      () async {
    when(() => mockHttpClient.get(url)).thenAnswer((_) async => http.Response(
        '{"kind": "Listing","data": {"after": "t3_tcpepp"}}', 400));

    await cubit.retrieve();

    expect(cubit.currentState is DataFailed, isTrue);
  });
}
