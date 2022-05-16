class Food {
  final String name;
  final int price;
  final String description;
  final String image;
  // final bool isAvailable;
  // final int avgRating;
  // final int avgPrepTime;

  Food({
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    // required this.isAvailable,
    // required this.avgRating,
    // required this.avgPrepTime
  });

  factory Food.fromJson(Map<String, dynamic> foodData) {
    return Food(
      name: foodData['name'],
      price: foodData['price'],
      description: foodData['description'],
      image: foodData['image'],
      // isAvailable: foodData['isAvailable'],
      // avgRating: foodData['avgRating'],
      // avgPrepTime: foodData['avgPrepTime']
    );
  }
}
