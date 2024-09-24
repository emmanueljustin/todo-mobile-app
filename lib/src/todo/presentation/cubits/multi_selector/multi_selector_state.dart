part of 'multi_selector_cubit.dart';

class MultiSelectorState extends Equatable {
  final List<int> selectedItems;
  final bool selectEnabled;

  const MultiSelectorState({
    this.selectedItems = const [],
    this.selectEnabled = false
  });

  MultiSelectorState copyWith({
    List<int>? selectedItems,
    bool? selectEnabled
  }) => MultiSelectorState(
    selectedItems: selectedItems ?? this.selectedItems,
    selectEnabled: selectEnabled ?? this.selectEnabled
  );

  @override
  List<Object> get props => [
    selectedItems,
    selectEnabled
  ];
}
