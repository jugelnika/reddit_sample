import 'package:flutter/material.dart';
import 'package:reddit_project/core/data_handling/api_constants.dart';
import 'package:reddit_project/reddit_page/core/reddit_page_item.dart';

class RedditCardItem extends StatefulWidget {
  final RedditItem item;

  const RedditCardItem({Key? key, required this.item}) : super(key: key);

  @override
  State<RedditCardItem> createState() => _RedditCardItemState();
}

class _RedditCardItemState extends State<RedditCardItem> {
  @override
  Widget build(BuildContext context) => Card(
        child: Column(children: [
          _heading(),
          _image(),
        ]),
      );

  Widget _heading() => Container(
        height: 80,
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          children: [
            _author(),
            const SizedBox(height: 10),
            _title(),
          ],
        ),
      );

  Widget _author() => Align(
        alignment: Alignment.topLeft,
        child: Text(
          widget.item.author,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
      );

  Widget _title() => Align(
        alignment: Alignment.topLeft,
        child: Text(
          widget.item.title,
          maxLines: 2,
          style: const TextStyle(
              fontWeight: FontWeight.w500, fontSize: 18, color: Colors.black),
        ),
      );

  Widget _image() => Container(
        height: 150,
        margin: const EdgeInsets.only(
          bottom: 15,
        ),
        child: const Image(
          image: NetworkImage(ENVIROMENT.NO_PHOTO_URL),
        ),
      );
}
