import 'package:dr_app/data/models/cuisine_category.dart';
import 'package:dr_app/data/models/featured_outlet.dart';
import 'package:dr_app/data/models/outlet.dart';

const dummyCards = [
  'Restaurant 1',
  'Restaurant 2',
  'Restaurant 3',
  'Restaurant 4',
  'Restaurant 5',
  'Restaurant 6',
  'Restaurant 7',
  'Restaurant 8',
  'Restaurant 9',
  'Restaurant 10'
];

const dummyOutlets = [
  Outlet('Bar Soba', 'https://picsum.photos/200/300', 3, '\$\$'),
  Outlet('Sputini', 'https://picsum.photos/200/400', 3, '\$\$'),
  Outlet('Qdoba', 'https://picsum.photos/200/500', 2, '\$\$'),
  Outlet('McDonalds', 'https://picsum.photos/200/303', 3, '\$\$'),
  Outlet('Fogo de chão', 'https://picsum.photos/200/440', 3.5, '\$\$\$'),
  Outlet('BB King Steak House', 'https://picsum.photos/200/298', 5, '\$\$\$'),
];

const dummyCuisines = [
  CuisineCategory('Italian', 'https://picsum.photos/102'),
  CuisineCategory('Brazilian', 'https://picsum.photos/108'),
  CuisineCategory('Japanese', 'https://picsum.photos/110'),
  CuisineCategory('Greek', 'https://picsum.photos/222'),
];

const dummyFeaturedOutlets = [
  FeaturedOutlet(
      'Bar Soba', 'Asian Fusion', 4, '\$\$', 'https://picsum.photos/1001'),
  FeaturedOutlet(
      'Bar Soba', 'Asian Fusion', 4, '\$\$', 'https://picsum.photos/1002'),
  FeaturedOutlet(
      'Bar Soba', 'Asian Fusion', 4, '\$\$', 'https://picsum.photos/1003'),
  FeaturedOutlet(
      'Bar Soba', 'Asian Fusion', 4, '\$\$', 'https://picsum.photos/1004')
];

const List<String> dummySwiperImages = [
  'https://picsum.photos/200/400',
  'https://picsum.photos/200/500',
  'https://picsum.photos/200/200'
];
