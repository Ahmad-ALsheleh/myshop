import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../mock/mock_reviews.dart';
import '../models/review.dart';

final reviewRepositoryProvider = Provider<ReviewRepository>(
  (ref) => ReviewRepository(),
);

class ReviewRepository {
  /// Newest first.
  List<Review> getForProduct(String productId) =>
      (mockProductReviews[productId] ?? mockGenericReviews).toList()
        ..sort((a, b) => b.date.compareTo(a.date));
}
