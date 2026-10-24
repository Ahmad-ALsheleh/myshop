/// Spacing scale measured from the Figma frames (375 x 812).
abstract final class AppSpacing {
  static const double xxs = 4;
  static const double xs = 8;
  static const double s = 12;
  static const double m = 16; // horizontal screen padding in every screen
  static const double l = 24;
  static const double xl = 32;
}

abstract final class AppRadius {
  static const double s = 8; // buttons, cards, inputs, size chips
  static const double m = 12;
  static const double sheet = 24; // bottom panels (total price, add to cart)
  static const double pill = 100; // search field, chips, cart pill
}

abstract final class AppSizes {
  static const double headerHeight = 88; // status bar (44) + toolbar (44)
  static const double toolbarHeight = 44;
  static const double buttonHeight = 48;
  static const double searchFieldHeight = 44;
  static const double inputHeight = 48;
  static const double icon = 24;
}
