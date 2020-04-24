class Meal {
  final String id;
  final String image;
  final String name;
  final String price;
  final String cookTime;
  final String description;
  final String foodType;

  Meal({
    this.id,
    this.image,
    this.name,
    this.price,
    this.description,
    this.cookTime,
    this.foodType,
  });

  factory Meal.fromJson(Map data) {
    return Meal(
      cookTime: data['cook_time'],
      image: data['image'],
      name: data['name'],
      price: data['price'],
      description: data['description'],
      foodType: data['food_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cook_time': cookTime,
      'image': image,
      'name': name,
      'price': price,
      'description': description,
      'food_type': foodType,
    };
  }
}
