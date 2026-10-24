/// Unique enough ids for objects created at runtime (addresses, cards,
/// orders). The mock data has no backend to assign real ids.
String generateId() => DateTime.now().microsecondsSinceEpoch.toString();
