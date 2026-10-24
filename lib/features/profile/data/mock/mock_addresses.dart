import '../models/address.dart';

const homeAddress = Address(
  id: 'a1',
  fullName: 'Oleh Chabanov',
  street: '225 Highland Ave',
  city: 'Springfield',
  region: 'IL',
  zipCode: '62704',
  country: 'USA',
  isDefault: true,
);

const workAddress = Address(
  id: 'a2',
  fullName: 'Oleh Chabanov',
  street: '48 Maple Street',
  city: 'Portland',
  region: 'OR',
  zipCode: '97205',
  country: 'USA',
);

const mockAddresses = <Address>[homeAddress, workAddress];
