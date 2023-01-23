import 'package:flutter/material.dart';

/// Button Color
Color kButtonColor = Colors.pink.shade600;

/// Scaffold Color (Common for the complete App)
Color kAppBackground = Color(0xFF2C3333);

/// Large Heading
const kLargeHeading = TextStyle(
  color: Colors.white,
  fontSize: 30,
  fontWeight: FontWeight.bold,
);

const kLargeFontColor = Colors.white;

/// Subheading
const kSubHeading = TextStyle(
    color: Color(0xFFE7F6F2), fontSize: 18, fontWeight: FontWeight.bold);

/// Text Colors
const kTextColor = Colors.white ?? Color(0xFF2C3333);
const kServingsColor = Colors.white;
const kIngredientsColor = Colors.white;
const kIngredientQuantityColor = Colors.white;
const kNutritionInfoColor = Colors.white;
const kNutritionQuanColor = Colors.white;
const kDescriptionText = TextStyle(
  fontSize: 15,
  color: Colors.grey,
  overflow: TextOverflow.fade,
);

/// Container Colors
const kContainerColor = Color(0xFFA5C9CA);
const kPreparationContainerColor = Colors.white12;

const List<String> kDifficulty = [
  '5_ingredients_or_less',
  'easy',
  'under_1_hour',
  'under_15_minutes',
  'under_30_minutes',
  'under_45_minutes'
];
const List<String> kMeal = [
  'appetizers',
  'bakery_goods',
  'breakfast',
  'desserts',
  'dinner',
  'drinks',
  'lunch',
  'sides',
  'snacks'
];
const List<String> kOccasion = [
  'bbq',
  'brunch',
  'casual_party',
  'date_night',
  'happy_hour',
  'indulgent_sweets',
  'special_occasion',
  'weeknight'
];
const List<String> kDiet = [
  'contains_alcohol',
  'dairy_free',
  'gluten_free',
  'healthy',
  'keto',
  'pescatarian',
  'vegan',
  'vegetarian'
];
const List<String> kCuisine = [
  'african',
  'american',
  'brazilian',
  'british',
  'caribbean',
  'chinese',
  'cuban',
  'dominican',
  'ethiopian',
  'filipino',
  'french',
  'fusion',
  'german',
  'greek',
  'haitian',
  'hawaiian',
  'indian',
  'indigenous',
  'italian',
  'jamaican',
  'japanese',
  'kenyan',
  'korean',
  'laotian',
  'latin_american',
  'lebanese',
  'mexican',
  'middle_eastern',
  'persian',
  'peruvian',
  'puerto_rican',
  'seafood',
  'soul_food',
  'south_african',
  'swedish',
  'taiwanese',
  'thai',
  'venezuelan',
  'vietnamese',
  'west_african'
];
const List<String> kCookingStyle = [
  'bake',
  'big_batch',
  'comfort_food',
  'deep_fry',
  'grill',
  'kid_friendly',
  'mashup',
  'meal_prep',
  'no_bake_desserts',
  'pan_fry',
  'stream',
  'stuffed'
];
