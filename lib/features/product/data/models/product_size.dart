/// Clothing sizes. Labels are the same in every language.
enum ProductSize {
  xxs('XXS'),
  xs('XS'),
  s('S'),
  m('M'),
  l('L'),
  xl('XL');

  const ProductSize(this.label);

  final String label;
}
