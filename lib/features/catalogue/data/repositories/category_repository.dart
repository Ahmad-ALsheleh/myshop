import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../mock/mock_categories.dart';
import '../models/category.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>(
  (ref) => CategoryRepository(),
);

class CategoryRepository {
  List<Category> getAll() => mockCategories;

  Category? getById(String id) =>
      mockCategories.where((category) => category.id == id).firstOrNull;
}
