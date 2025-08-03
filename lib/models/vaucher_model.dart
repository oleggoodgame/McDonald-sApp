enum TypeVaucher { discount, priceDiscount }

class Vaucher {
  final String title;
  final double discount;
  final TypeVaucher type;
  final String time;
  final String photoPath;

  Vaucher(this.title, this.discount, this.type, this.time, this.photoPath);
  
}
