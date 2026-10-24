/// Something the user keeps a list of and marks one as default
/// (shipping addresses, payment cards). The default one is used at checkout.
abstract interface class Defaultable<T> {
  String get id;

  bool get isDefault;

  T copyWithDefault(bool isDefault);
}

extension DefaultItem<T extends Defaultable<T>> on List<T> {
  /// The item marked as default, else the first one, else `null`.
  T? get defaultItem =>
      where((item) => item.isDefault).firstOrNull ?? firstOrNull;
}
