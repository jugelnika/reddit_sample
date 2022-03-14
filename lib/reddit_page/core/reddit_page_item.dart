import '../../helpers/json_parser.dart';
import 'reddit_page_item.dart';

class RedditItem {
  RedditItem({this.title = '', this.author = ''});

  String title;
  String author; // author_fullname

  factory RedditItem.fromJson(Map<String, dynamic> json) {
    return RedditItem(
      title: json.s('title'),
      author: json.s('author_fullname'),
    );
  }
}
