import 'dart:io';

import 'package:http/http.dart';
import 'package:reddit_project/core/data_handling/api_constants.dart';

import '../../core/data_handling/data_states.dart';
import 'package:bloc/bloc.dart';
//Did not use DIO library to not complicate things,
//as we are using only one request.
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'core/reddit_page_model.dart';

class RedditPageCubit extends Cubit<DataState> {
  final client;
  late Response response;
  late DataState currentState;

  RedditPageCubit({required this.client}) : super(const DataInitial()) {
    retrieve();
  }

  notify(DataState state) {
    currentState = state;
    emit(currentState);
  }

  Future<http.Response> fetch() {
    return client.get(Uri.parse(ENVIROMENT.REDDIT_API_URL));
  }

  Future<void> retrieve() async {
    if (state is DataLoading) notify(state);

    try {
      final res = await fetch();
      if (res is Response && res.statusCode == 200) {
        response = res;
        final data = RedditModel.fromJson(jsonDecode(response.body)['data']);
        notify(DataLoaded<RedditModel>(data));
      } else {
        throw Exception('Error Occured');
      }
    } on SocketException catch (e) {
      notify(DataNetworkError(e.message));
    } catch (e) {
      notify(DataFailed('$e'));
    }
  }
}
