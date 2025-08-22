import 'package:flutter/material.dart';
import 'package:mc_donalds/models/foods_model.dart';
import 'package:mc_donalds/models/main_card_model.dart';
import 'package:mc_donalds/models/more_model.dart';
import 'package:mc_donalds/models/vaucher_model.dart';

final List<News> newsList = [
  const News(
    'New McFlurry Flavors Arrived!',
    'Try the new McFlurry flavors — from strawberry cheesecake to caramel brownie.',
    'Cool down with the taste of summer!',
    'McDonald’s introduces new summer-inspired McFlurry flavors based on your favorite desserts. Available for a limited time only!',
    'assets/images/news1.webp',
  ),
  const News(
    'McDelivery Now Faster',
    'Delivery is now even faster — your order arrives in just 20 minutes on average.',
    'Fast. Tasty. At your door.',
    'We’ve upgraded our delivery system to bring your favorite burgers to you even quicker. Check out the new speed in your area!',
    'assets/images/news2.jpg',
  ),
  const News(
    'New Toys in Happy Meal',
    'New toy series in Happy Meal — straight from Disney Pixar!',
    'Collect them all!',
    'Discover the latest Disney Pixar toy collection in your Happy Meal. A new toy every week — don’t miss a single one!',
    'assets/images/news3.jpg',
  ),
  const News(
    'McDonald’s Supports Ukraine',
    'We donate ₴5 from each Combo to support Ukrainian Armed Forces.',
    'Together — to victory!',
    'McDonald’s Ukraine has launched a donation campaign — part of the proceeds from every Combo goes to humanitarian and military aid.',
    'assets/images/news4.jpg',
  ),
  const News(
    'Grimace\'s Celebration Week',
    'Celebrate Grimace\' Week with exclusive discounts and free gifts!',
    'More than just a burger!',
    'From August 1st to 7th, join the Big Mac celebration week. Get surprises and gifts when ordering through the app.',
    'assets/images/news5.jpg',
  ),
];
final List<Vaucher> vaucherList = [
  Vaucher(
    'Medium french fries',
    25,
    TypeVaucher.discount,
    'endlessly',
    'assets/images/fries.webp',
  ),
  Vaucher(
    'Coca Cola',
    0.5,
    TypeVaucher.priceDiscount,
    'endlessly',
    'assets/images/coca_cola.webp',
  ),
  Vaucher(
    'Double Cheeseburger',
    30,
    TypeVaucher.discount,
    'endlessly',
    'assets/images/doublecheesburger.webp',
  ),
];

const List<More> moreItems = [
  More("Profile", Icons.person, TypeMore.Profile),
  More("Website", Icons.public, TypeMore.Site),
  More("Instagram", Icons.camera_alt, TypeMore.Instagram),
  More("YourDelivery", Icons.delivery_dining_outlined, TypeMore.YourDelivery),
  More("Feedback", Icons.feedback, TypeMore.Feedback),
  More("Information", Icons.info, TypeMore.Information),
  More("Change Country", Icons.flag, TypeMore.ChangeCountry),
];

const List<ProfileAction> profileActions = [
  ProfileAction("View Profile", Icons.person, TypeProfileAction.View),
  ProfileAction("Sign out Profile", Icons.swap_horiz, TypeProfileAction.Change),
  ProfileAction("Edit Profile", Icons.edit, TypeProfileAction.Edit),
  ProfileAction("Share Profile", Icons.share, TypeProfileAction.Share),
  ProfileAction("Delete Profile", Icons.delete, TypeProfileAction.Delete),
];

const List<Food> list_of_Fries_and_Snacks = [
  Food(
    "Small french fries",
    "Seleced potatoes, fried in natural oil and slightly salted.",
    "60 g | 231 kcal",
    1.0,
    TypeFood.Fries_and_Snacks,
    "assets/images/fries.webp",
  ),
  Food(
    "Medium french fries",
    "Selected potatoes, fried in natural oil and slightly salted.",
    "90 g | 330 kcal",
    2.0,
    TypeFood.Fries_and_Snacks,
    "assets/images/fries.webp",
  ),
  Food(
    "Bif french fries",
    "Selected potatoes, fried in natural oil and slightly salted.",
    "120 g | 434 kcal",
    2.5,
    TypeFood.Fries_and_Snacks,
    "assets/images/fries.webp",
  ),
  Food(
    "French fries with cheese sauce and bacon",
    "Favorite French fries with a delicious cheese sauce, sprinkled with crispy fried bacon.",
    "190 g | 665 kcal",
    3.0,
    TypeFood.Fries_and_Snacks,
    "assets/images/fries_with_cheeses.webp",
  ),
  Food(
    "Chicken McNuggets",
    "Appetizing pieces of tender chicken fillet, fried in crispy breading.",
    "100 g | 265 kcal",
    1.5,
    TypeFood.Fries_and_Snacks,
    "assets/images/nagets.webp",
  ),
  Food(
    "Chicken Strips",
    "Strips of white, juicy chicken fillet fried in a crispy breading. How many pieces do you want? Three for one person, six for you and a friend, or twelve for a large group?",
    "160 g | 440 kcal",
    1.5,
    TypeFood.Fries_and_Snacks,
    "assets/images/strips.webp",
  ),
];

const List<Food> list_burgers = [
  Food(
    "Hamburger",
    "Classic burger with a juicy beef patty, pickles, onions, ketchup and mustard in a sesame bun.",
    "120 g | 250 kcal",
    1.2,
    TypeFood.Burgers,
    "assets/images/hamburger.webp",
  ),
  Food(
    "Big Tasty",
    "Big burger with beef patty, tomato, lettuce, cheese and signature Big Tasty sauce.",
    "225 g | 850 kcal",
    2.9,
    TypeFood.Burgers,
    "assets/images/bigtasty.webp",
  ),
  Food(
    "Cheeseburger",
    "Beef patty with melted cheese, pickles, onions, ketchup and mustard.",
    "115 g | 300 kcal",
    1.5,
    TypeFood.Burgers,
    "assets/images/cheeseburger.webp",
  ),
  Food(
    "Double Big Tasty",
    "Two juicy beef patties, lettuce, tomato, cheese and signature Big Tasty sauce.",
    "300 g | 1100 kcal",
    3.9,
    TypeFood.Burgers,
    "assets/images/doublebigtesty.webp",
  ),
  Food(
    "Double Cheeseburger",
    "Two beef patties with melted cheese, pickles, onions, ketchup and mustard.",
    "165 g | 450 kcal",
    2.4,
    TypeFood.Burgers,
    "assets/images/doublecheesburger.webp",
  ),
];
const List<Food> list_drinks = [
  Food(
    "Coca Cola",
    "Refreshing carbonated drink with classic cola taste.",
    "400 ml | 168 kcal",
    1.0,
    TypeFood.Drink,
    "assets/images/coca_cola.webp",
  ),
  Food(
    "Fanta",
    "Sweet orange-flavored sparkling drink, perfect for hot days.",
    "400 ml | 160 kcal",
    1.0,
    TypeFood.Drink,
    "assets/images/fanta.webp",
  ),
  Food(
    "Sprite",
    "Lemon-lime flavored soda with a light, refreshing taste.",
    "400 ml | 148 kcal",
    1.0,
    TypeFood.Drink,
    "assets/images/sprite.webp",
  ),
];

const List<Food> list_sides = [
  Food(
    "Ketchup",
    "Tomato ketchup in portion packaging — perfect for fries or nuggets.",
    "20 g | 25 kcal",
    0.2,
    TypeFood.Side,
    "assets/images/ketchup.webp",
  ),
  Food(
    "Cheese Dip",
    "Melted cheese sauce with a creamy texture and rich taste.",
    "40 g | 80 kcal",
    0.4,
    TypeFood.Side,
    "assets/images/cheese.webp",
  ),
  Food(
    "Dorblu cheese sauce",
    "A delicate sauce with the exquisite creamy taste of Dorblu cheese is the perfect complement to crunchy snacks.",
    "40 g   | 100 kcal/",
    0.5,
    TypeFood.Side,
    "assets/images/dourbly.webp",
  ),
];
