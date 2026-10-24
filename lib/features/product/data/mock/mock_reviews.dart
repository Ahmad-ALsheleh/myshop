import '../../../../core/l10n/localized_text.dart';
import '../models/review.dart';
import 'mock_products.dart';

/// Reviews written for a specific product, by product id.
final mockProductReviews = <String, List<Review>>{
  astylishCardigan.id: [
    Review(
      id: 'r1',
      authorName: 'Olha Chabanova',
      rating: 5,
      date: DateTime(2021, 6, 5),
      text: const LocalizedText(
        en:
            "I'm old (rolling through my 50's). But, this is my daughter in "
            "law's favorite color right now.❤️ So I wear it whenever we hang "
            "out! She's my fashion consultant who keeps me on trend🤪",
        ar:
            'أنا كبيرة في السن (في الخمسينيات من عمري). لكن هذا هو اللون المفضل '
            'لزوجة ابني حاليًا.❤️ لذلك أرتديه كلما خرجنا معًا! إنها مستشارتي '
            'في الموضة التي تبقيني مواكبة للصيحات🤪',
      ),
      helpfulCount: 835,
    ),
    Review(
      id: 'r2',
      authorName: 'Maria Lopez',
      rating: 5,
      date: DateTime(2021, 5, 28),
      text: const LocalizedText(
        en:
            'So soft and cozy! The chunky knit looks even better in person. '
            'I ordered my usual size and it fits perfectly oversized.',
        ar:
            'ناعم ودافئ جدًا! النسيج المحبوك السميك يبدو أجمل في الواقع. طلبت '
            'مقاسي المعتاد وجاء واسعًا بشكل مثالي.',
      ),
      helpfulCount: 412,
    ),
    Review(
      id: 'r3',
      authorName: 'Sarah Kim',
      rating: 4,
      date: DateTime(2021, 5, 17),
      text: const LocalizedText(
        en:
            'Beautiful color and very warm. It sheds a little on the first '
            'wear, but that stopped after washing it once.',
        ar:
            'لون جميل ودافئ جدًا. يتساقط منه القليل من الوبر في المرة الأولى، '
            'لكن ذلك توقف بعد غسله مرة واحدة.',
      ),
      helpfulCount: 158,
    ),
    Review(
      id: 'r4',
      authorName: 'Emily Carter',
      rating: 5,
      date: DateTime(2021, 5, 2),
      text: const LocalizedText(
        en:
            'I bought it in two colors already. Perfect with jeans and boots '
            'for fall.',
        ar: 'اشتريته بلونين حتى الآن. مثالي مع الجينز والبوت في الخريف.',
      ),
      helpfulCount: 97,
    ),
    Review(
      id: 'r5',
      authorName: 'Nadia Hassan',
      rating: 5,
      date: DateTime(2021, 4, 21),
      text: const LocalizedText(
        en:
            'Great quality for the price. The sleeves are long, which I love, '
            'and the pockets are a nice touch.',
        ar:
            'جودة رائعة مقابل السعر. الأكمام طويلة وهذا ما أحبه، والجيوب لمسة '
            'جميلة.',
      ),
      helpfulCount: 64,
    ),
    Review(
      id: 'r6',
      authorName: 'Laura Rossi',
      rating: 4,
      date: DateTime(2021, 4, 9),
      text: const LocalizedText(
        en:
            'Lovely cardigan, a bit heavier than I expected. Size down if you '
            'prefer a closer fit.',
        ar:
            'كارديغان جميل، أثقل قليلًا مما توقعت. اختاري مقاسًا أصغر إذا كنتِ '
            'تفضلين قَصّة أقرب للجسم.',
      ),
      helpfulCount: 41,
    ),
    Review(
      id: 'r7',
      authorName: 'Hannah Weber',
      rating: 5,
      date: DateTime(2021, 3, 30),
      text: const LocalizedText(
        en: 'Arrived quickly and looks exactly like the pictures. Very happy!',
        ar: 'وصل بسرعة ويبدو تمامًا كما في الصور. سعيدة جدًا!',
      ),
      helpfulCount: 23,
    ),
    Review(
      id: 'r8',
      authorName: 'Lina Haddad',
      rating: 5,
      date: DateTime(2021, 3, 14),
      text: const LocalizedText(
        en:
            'My favorite purchase this season. I get compliments every time I '
            'wear it.',
        ar: 'أفضل ما اشتريته هذا الموسم. أتلقى المديح في كل مرة أرتديه.',
      ),
      helpfulCount: 12,
    ),
  ],
};

/// Shown for products that have no specific reviews.
final mockGenericReviews = <Review>[
  Review(
    id: 'g1',
    authorName: 'Daniel Brooks',
    rating: 5,
    date: DateTime(2021, 6, 1),
    text: const LocalizedText(
      en: 'Exactly as described and arrived earlier than expected.',
      ar: 'تمامًا كما في الوصف ووصل أبكر مما توقعت.',
    ),
    helpfulCount: 54,
  ),
  Review(
    id: 'g2',
    authorName: 'Amira Saleh',
    rating: 5,
    date: DateTime(2021, 5, 19),
    text: const LocalizedText(
      en: 'Great quality for the price. I would definitely buy it again.',
      ar: 'جودة رائعة مقابل السعر. سأشتريه مرة أخرى بالتأكيد.',
    ),
    helpfulCount: 31,
  ),
  Review(
    id: 'g3',
    authorName: 'Chris Turner',
    rating: 4,
    date: DateTime(2021, 4, 27),
    text: const LocalizedText(
      en: 'Nice product overall, the packaging could be better though.',
      ar: 'منتج جيد بشكل عام، لكن التغليف يمكن أن يكون أفضل.',
    ),
    helpfulCount: 9,
  ),
];
