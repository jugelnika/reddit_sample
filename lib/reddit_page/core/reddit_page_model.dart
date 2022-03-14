import '../../helpers/json_parser.dart';
import 'reddit_page_item.dart';

class RedditModel {
  RedditModel({
    required this.after,
    required this.dist,
    required this.modhash,
    required this.children,
  });

  String after;
  int dist;
  String modhash;
  List<RedditItem> children;

  factory RedditModel.fromJson(Map<String, dynamic> json) {
    List<RedditItem> children = json
        .asList('children')
        .map<RedditItem>((child) => RedditItem.fromJson(child['data']))
        .toList();

    return RedditModel(
      after: json.s('after'),
      dist: json.i('dist'),
      modhash: json.s('modhash'),
      children: children,
    );
  }
}
