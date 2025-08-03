
enum TypeFood { Fries_and_Snacks, Burgers, Drink, Side }

class Food {
  final String title;
  final String photoPath;
  final double price;
  final String description;
  final TypeFood type;
  final String value;

  const Food(this.title, this.description, this.value, this.price,  this.type, this.photoPath);
}
