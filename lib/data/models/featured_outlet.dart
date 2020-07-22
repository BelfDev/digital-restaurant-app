/// A model class representing a featured outlet.
class FeaturedOutlet {
  final String name;
  final String imgSrc;
  final String category;
  final double rating;
  final String priceRange;

  const FeaturedOutlet(
      this.name, this.category, this.rating, this.priceRange, this.imgSrc);
}
