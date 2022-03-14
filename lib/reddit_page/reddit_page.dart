import 'package:flutter/material.dart';
import 'package:reddit_project/reddit_page/reddit_card_item.dart';
import 'core/reddit_page_item.dart';
import 'reddit_page_cubit.dart';
import '../../core/data_handling/data_states.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_bloc/flutter_bloc.dart';

class RedditPage extends StatefulWidget {
  @override
  _RedditPageState createState() => _RedditPageState();
}

class _RedditPageState extends State<RedditPage> {
  final cubit = RedditPageCubit(client: http.Client());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(255, 69, 0, 1),
          title: const Text('Reddit'),
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: BlocBuilder<RedditPageCubit, DataState>(
            bloc: cubit,
            builder: _builder,
          ),
        ),
      );

  Widget _failed() => const Text('Data Failed');
  Widget _loading() => const Center(
        child: Text('Loading...'),
      );

  Widget _builder(_, state) {
    if (state is DataFailed) return _failed();

    if (state is DataLoaded) {
      return ListView(
        children: state.data.children
            .map<Widget>((RedditItem item) => RedditCardItem(item: item))
            .toList(),
      );
    }

    if (state is DataNetworkError) {
      return const Center(
        child: Text('Network Error. Check internet connection and try again.'),
      );
    }

    return _loading();
  }
}
