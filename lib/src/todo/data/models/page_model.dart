import 'package:todoapp/src/todo/domain/entities/page.dart';

class PageModel extends Page {
  const PageModel({
    super.currPage = 1,
    super.prevPage,
    super.nextPage,
    super.totalItems = 0
  });

  factory PageModel.fromJson(Map<String, dynamic> json) {
    return PageModel(
      currPage: json['curr_page'],
      prevPage: json['prev_page'],
      nextPage: json['next_page'],
      totalItems: json['total_items']
    );
  }

  Map<String, dynamic> toJson() => {
    "curr_page": currPage,
    "prev_page": prevPage,
    "next_page": nextPage,
    "total_items": totalItems
  };
}