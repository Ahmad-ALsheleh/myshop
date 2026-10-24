import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/defaultable.dart';

/// Shared logic of the address book and the saved cards: add/edit, remove,
/// and keep exactly one item marked as default while the list is not empty.
abstract class DefaultableListNotifier<T extends Defaultable<T>>
    extends Notifier<List<T>> {
  /// Adds [item], or replaces the saved item with the same id.
  void save(T item) {
    final exists = state.any((saved) => saved.id == item.id);
    var items = exists
        ? [for (final saved in state) saved.id == item.id ? item : saved]
        : [...state, item];
    if (item.isDefault) {
      items = [
        for (final saved in items) saved.copyWithDefault(saved.id == item.id),
      ];
    }
    state = _withDefault(items);
  }

  void remove(String id) =>
      state = _withDefault(state.where((saved) => saved.id != id).toList());

  void setDefault(String id) => state = [
    for (final saved in state) saved.copyWithDefault(saved.id == id),
  ];

  /// Makes the first item the default when none is (e.g. after removing it).
  List<T> _withDefault(List<T> items) {
    if (items.isEmpty || items.any((saved) => saved.isDefault)) return items;
    return [items.first.copyWithDefault(true), ...items.skip(1)];
  }
}
