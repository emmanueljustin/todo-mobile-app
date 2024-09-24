import 'package:equatable/equatable.dart';

class Page extends Equatable {
  final int currPage;
  final int? prevPage;
  final int? nextPage;
  final int totalItems;

  const Page({
    required this.currPage,
    this.prevPage,
    this.nextPage,
    required this.totalItems
  });

  @override
  List<Object?> get props => [
    currPage,
    prevPage,
    nextPage,
    totalItems
  ];
}