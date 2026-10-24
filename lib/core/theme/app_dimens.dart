/// Spacing scale measured from the Figma frames (375 x 812).
abstract final class AppSpacing {
  static const double xxs = 4;
  static const double xs = 8;
  static const double s = 12;
  static const double m = 16; // horizontal screen padding in every screen
  static const double l = 24; // horizontal padding of the sign in screens
  static const double xl = 32;

  /// Side margin of the search field (wider than the screen padding).
  static const double searchInset = 20;

  /// Gap between the two columns of product cards.
  static const double cardGap = 17;

  /// Vertical padding of a 48pt input with 15pt text.
  static const double inputVertical = 14;

  /// Vertical padding of the 64pt phone input with 18pt text.
  static const double inputVerticalLarge = 19;

  // Search field: 20pt magnifier 18pt from the edge, text 10pt after it
  // (the end padding is smaller: the icon box has its own inner margin).
  static const double searchIconStart = 14;
  static const double searchIconEnd = 5;

  // Product card
  static const double imageToStars = 8;
  static const double starsToName = 6;
  static const double nameToPrice = 4;
  static const double saleBadgeTop = 9;
  static const double heartButtonEnd = 8;
  static const double starGap = 0;
  static const double oldPriceGap = 6;

  // Cart pill: icon and texts
  static const double cartPillStart = 17;
  static const double cartPillIconGap = 9;

  // Bottom navigation: icon 12pt under the top edge, label 2pt under it.
  static const double navBarTop = 12;
  static const double navLabelGap = 2;
}

abstract final class AppRadius {
  static const double xs = 4; // product images
  static const double s = 8; // buttons, cards, inputs, size chips
  static const double m = 12;
  static const double sheet = 24; // bottom panels (total price, add to cart)
  static const double pill = 100; // search field, chips, cart pill
}

abstract final class AppSizes {
  /// Gradient header: status bar inset + this.
  static const double toolbarHeight = 44;

  /// In the design the toolbar content is not centred in the 44pt toolbar:
  /// its centre line is 13pt under the status bar.
  static const double toolbarContentCenter = 13;
  static const double toolbarContentHeight = 30;

  static const double buttonHeight = 48;
  static const double buttonHeightLarge = 64; // sign in screens
  static const double inputHeight = 48;
  static const double inputHeightLarge = 64; // phone number input
  static const double searchFieldHeight = 44;
  static const double icon = 24;
  static const double headerIcon = 28; // 20pt-wide arrow glyph
  static const double searchIcon = 26;
  static const double chevron = 20;
  static const double loader = 20;
  static const double cartPillIcon = 28;
  static const double selectedBorder = 2;

  // Product card
  static const double heartButton = 36;
  static const double heartIconSmall = 20; // inside the round button
  static const double heartIcon = 26; // product page bottom bar
  static const double starIcon = 12; // 9pt glyph, stars touch each other
  static const double saleBadgeWidth = 46;
  static const double saleBadgeHeight = 20;

  // Selectors (product page, add to cart sheet, filter)
  static const double selectorGap = 12;
  static const double colorDot = 37;

  // Quantity stepper: centres of + / count / - are 25pt apart.
  static const double stepperCountHeight = 26;

  // Bottom navigation + cart pill
  static const double navBarHeight = 53;
  static const double navItemGap = 22;
  static const double cartPillWidth = 115;
  static const double cartPillHeight = 56;
  static const double cartPillRise = 11; // how far it sticks out above the bar

  /// Width of the back arrow / heart slots around "Add to Cart".
  static const double bottomBarSideSlot = 80;
}
