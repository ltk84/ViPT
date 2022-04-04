import 'package:vipt/app/data/models/category.dart';
import 'package:vipt/app/data/models/ingredient.dart';
import 'package:vipt/app/data/models/meal.dart';
import 'package:vipt/app/data/models/meal_category.dart';

List<MealCategory> mealCatefakeData = [
  MealCategory.fromCategory(
      Category('', name: "Breakfast", asset: '', parentCategoryID: null)),
  MealCategory.fromCategory(
      Category('', name: "Lunch/Dinner", asset: '', parentCategoryID: null)),
  MealCategory.fromCategory(
      Category('', name: "Snack", asset: '', parentCategoryID: null)),
];

List<Ingredient> ingredientFakeData = [
  Ingredient(
      id: 'id',
      name: 'Almond flour',
      kcal: 582.1,
      fat: 50.7,
      carbs: 20,
      protein: 21.8),
  Ingredient(
      id: 'id', name: 'Apple', kcal: 52, fat: 0.2, carbs: 14, protein: 0.3),
  Ingredient(
      id: 'id',
      name: 'Apple sauce',
      kcal: 42,
      fat: 0.1,
      carbs: 11,
      protein: 0.2),
  Ingredient(
      id: 'id',
      name: 'Apple vinegar',
      kcal: 22,
      fat: 0,
      carbs: 0.9,
      protein: 0),
  Ingredient(
      id: 'id', name: 'Baking powder', kcal: 53, carbs: 28, protein: 0, fat: 0),
  Ingredient(
      id: 'id', name: 'Baking soda', kcal: 0, carbs: 0, protein: 0, fat: 0),
  Ingredient(
      id: 'id',
      name: 'Balsamic vinegar',
      kcal: 88,
      carbs: 17,
      protein: 0.5,
      fat: 0),
  Ingredient(
      id: 'id', name: 'Banana', kcal: 89, carbs: 23, protein: 1.1, fat: 0.3),
  Ingredient(
      id: 'id', name: 'Broccoli', kcal: 35, carbs: 7.2, protein: 2.4, fat: 0.4),
  Ingredient(
      id: 'id',
      name: 'Buckwheat flour',
      kcal: 335,
      carbs: 71,
      protein: 13,
      fat: 3.1),
  Ingredient(
      id: 'id', name: 'Carrot', kcal: 41, carbs: 10, protein: 0.9, fat: 0.2),
  Ingredient(
      id: 'id',
      name: 'Cauliflower',
      kcal: 25,
      carbs: 5,
      protein: 1.9,
      fat: 0.3),
  Ingredient(
      id: 'id',
      name: 'Cooked chickpeas',
      kcal: 164,
      carbs: 27,
      protein: 9,
      fat: 3),
  Ingredient(
      id: 'id',
      name: 'Curry powder',
      kcal: 325,
      carbs: 58,
      protein: 13,
      fat: 14),
  Ingredient(
      id: 'id',
      name: 'Date syrup',
      kcal: 281,
      carbs: 76,
      protein: 2.4,
      fat: 0.4),
  Ingredient(
      id: 'id', name: 'Firm tofu', kcal: 83, carbs: 1.2, protein: 10, fat: 5.3),
  Ingredient(
      id: 'id', name: 'Flour', kcal: 364, carbs: 76, protein: 10, fat: 1),
  Ingredient(
      id: 'id',
      name: 'Ginger powder',
      kcal: 333.4,
      carbs: 72.2,
      protein: 8.9,
      fat: 4.4),
  Ingredient(
      id: 'id',
      name: 'Ground flaxseed',
      kcal: 534,
      carbs: 29,
      protein: 18,
      fat: 42),
  Ingredient(
      id: 'id', name: 'Kiwifruit', kcal: 534, carbs: 29, protein: 18, fat: 42),
  Ingredient(
      id: 'id',
      name: 'Maple syrup',
      kcal: 260,
      carbs: 67,
      protein: 0,
      fat: 0.1),
  Ingredient(id: 'id', name: 'Milk', kcal: 42, carbs: 5, protein: 3.4, fat: 1),
  Ingredient(
      id: 'id', name: 'Molasses', kcal: 290, carbs: 75, protein: 0, fat: 0.1),
  Ingredient(
      id: 'id', name: 'Mushroom', kcal: 22, carbs: 3.3, protein: 3.1, fat: 0.3),
  Ingredient(
      id: 'id', name: 'Oat flake', kcal: 367, carbs: 56, protein: 12, fat: 8.4),
  Ingredient(
      id: 'id', name: 'Oat flour', kcal: 404, carbs: 66, protein: 15, fat: 9.1),
  Ingredient(
      id: 'id', name: 'Olive oil', kcal: 884, carbs: 0, protein: 0, fat: 100),
  Ingredient(
      id: 'id', name: 'Onion', kcal: 40, carbs: 9, protein: 1.1, fat: 0.1),
  Ingredient(
      id: 'id',
      name: 'Pea protein powder',
      kcal: 400,
      carbs: 5,
      protein: 75,
      fat: 7.5),
  Ingredient(
      id: 'id',
      name: 'Peanut butter',
      kcal: 588,
      carbs: 20,
      protein: 25,
      fat: 50),
  Ingredient(
      id: 'id',
      name: 'Plain yogurt',
      kcal: 73,
      carbs: 4,
      protein: 10,
      fat: 1.9),
  Ingredient(
      id: 'id', name: 'Quinoa', kcal: 120, carbs: 21, protein: 4.4, fat: 1.9),
  Ingredient(
      id: 'id', name: 'Raisin', kcal: 299, carbs: 79, protein: 3.1, fat: 0.5),
  Ingredient(
      id: 'id', name: 'Rice', kcal: 130, carbs: 28, protein: 2.7, fat: 0.3),
  Ingredient(
      id: 'id', name: 'Rice flour', kcal: 366, carbs: 80, protein: 6, fat: 1.4),
  Ingredient(id: 'id', name: 'Salt', kcal: 0, carbs: 0, protein: 0, fat: 0),
  Ingredient(
      id: 'id', name: 'Soy sauce', kcal: 53, carbs: 4.9, protein: 8, fat: 0.6),
  Ingredient(
      id: 'id', name: 'Spinach', kcal: 23, carbs: 3.6, protein: 2.9, fat: 0.4),
  Ingredient(
      id: 'id',
      name: 'Steamed pumpkin',
      kcal: 46,
      carbs: 7.9,
      protein: 1.1,
      fat: 1.8),
  Ingredient(
      id: 'id',
      name: 'Sunflower seed',
      kcal: 584,
      carbs: 20,
      protein: 21,
      fat: 51),
  Ingredient(
      id: 'id',
      name: 'Sweet potato',
      kcal: 86,
      carbs: 20,
      protein: 1.6,
      fat: 0.1),
  Ingredient(
      id: 'id',
      name: 'Sweet protein powder',
      kcal: 345,
      carbs: 72,
      protein: 12,
      fat: 1),
  Ingredient(
      id: 'id', name: 'Tahini', kcal: 595, carbs: 21, protein: 17, fat: 54),
  Ingredient(
      id: 'id',
      name: 'Tomato sauce',
      kcal: 29,
      carbs: 7,
      protein: 1.3,
      fat: 0.2),
  Ingredient(
      id: 'id', name: 'Tortilla', kcal: 237, carbs: 50, protein: 7, fat: 1),
  Ingredient(id: 'id', name: 'Vinegar', kcal: 18, carbs: 0, protein: 0, fat: 0),
  Ingredient(
      id: 'id', name: 'Walnut', kcal: 654, carbs: 14, protein: 15, fat: 65),
  Ingredient(id: 'id', name: 'Water', kcal: 0, carbs: 0, protein: 0, fat: 0),
];

List<Meal> mealFakeData = [
  Meal(
    id: '',
    name: 'Apple Sauce Oatmeal',
    asset:
        'https://firebasestorage.googleapis.com/v0/b/vipt-506b2.appspot.com/o/meals%2Fasset_apple_sauce_oatmeal.png?alt=media&token=b45c78e7-661e-4b15-8014-e9a7646fefbc',
    categoryIDs: ['DEMmwUKFWFfNQYV1X4y0'],
    cookTime: 5,
    steps: [
      '1. Cover oat flakes with double the amount of water.',
      '2. Bring to a boil and stir for 3 minutes or until it thickens.',
      '3. Transfer cooked oatmeal to a plate.',
      '4. Add apple sauce.',
      '5. Add hazelnuts and sprinkle with cinnamon (optional).',
    ],
    ingreIDToAmount: {
      'yPR5hUIshhnzfZf0eOWg': '200g',
      'kGyAUda4xege1GUdCxgu': '200g',
    },
  ),
  Meal(
    id: '',
    name: 'Protein Kiwi Pizza',
    asset:
        'https://firebasestorage.googleapis.com/v0/b/vipt-506b2.appspot.com/o/meals%2Fasset_protein_kiwi_pizza.png?alt=media&token=375de353-2a5f-4c52-939d-ee4c85ac1e74',
    categoryIDs: ['DEMmwUKFWFfNQYV1X4y0'],
    cookTime: 7,
    steps: [
      '1. Toast tortilla and add to a plate.',
      '2. Add yogurt and protein powder to a mixing bowl. Mix well until well combined.',
      '3. Top tortilla with yogurt mix.',
      '4. Ad sliced kiwi fruit.',
      '5. Sprinkle with hemp hearts and top with cranberries and and cashews.',
    ],
    ingreIDToAmount: {
      'TvipONTJ4WmylIAn02WC': '394g',
      'yAfIu0NTXPGfRtIjMVDs': '138g',
      'Qyjcqee6P8ZFyH0Kmvyn': '200ml',
      'N1WhJsVsa9XMQJHKSrwS': '60g',
    },
  ),
  Meal(
    id: '',
    name: 'Oat Cookies',
    asset:
        'https://firebasestorage.googleapis.com/v0/b/vipt-506b2.appspot.com/o/meals%2Fasset_oat_cookies.png?alt=media&token=cbede925-ae34-45a5-b882-0734967999b2',
    categoryIDs: ['DEMmwUKFWFfNQYV1X4y0'],
    cookTime: 40,
    steps: [
      '1. Preheat the oven to 180 C degrees botoom heat. Combine all of the ingredients in a mixing bowl.',
      '2. Mix well until combined and dough-like.',
      '3. Split into 16 portions and shape into cookies.',
      '4. Bake in the oven for 20 minutes. Allow to cool completely before serving.',
    ],
    ingreIDToAmount: {
      'yPR5hUIshhnzfZf0eOWg': '200g',
      'UZpl2MgI6Rvv9bsWs3fp': '120g',
      'spDkobzO906VJUYrIFY8': '300ml',
      'HGa0H7TNtF5qg0OejFKu': '60ml',
      'gI9kSVX1JMG8ixnFBvtx': '30g',
    },
  ),
  Meal(
    id: '',
    name: 'Apple Cookies',
    asset:
        'https://firebasestorage.googleapis.com/v0/b/vipt-506b2.appspot.com/o/meals%2Fasset_apple_cookies.png?alt=media&token=7cfe4899-80e8-4701-b6c1-fd8f2ad93581',
    categoryIDs: ['DEMmwUKFWFfNQYV1X4y0'],
    cookTime: 60,
    steps: [
      '1. Preheat the oven to 200 C degrees bottom heat. Add all of the ingredients to a mixing bowl.',
      '2. Mix until combined. If you have time, chill the batter in the fridge for 15 minutes.',
      '3. Scoop the batter on top of a baking tray lined with baking paper. Optional: Add a teaspoon of apple sauce on top of each cookie and use a toothpick to integrate.',
      '4. Bake in the oven for 15 minutes or until the cookies are cooked through. Allow to cool for 15 minutes before servng.',
    ],
    ingreIDToAmount: {
      'kGyAUda4xege1GUdCxgu': '250g',
      'UZpl2MgI6Rvv9bsWs3fp': '150g',
      'gI9kSVX1JMG8ixnFBvtx': '30g',
      '81dxEcSPU0BB8YcF1e71': '4.6g',
      '5rnsdZGPQw5JiQLiXprU': '2.3g',
    },
  ),
  Meal(
    id: '',
    name: 'Tortilla Mushroom Pie',
    asset:
        'https://firebasestorage.googleapis.com/v0/b/vipt-506b2.appspot.com/o/meals%2Fasset_tortilla_mushroom_pie.png?alt=media&token=c66ded21-3383-4cf7-88fd-68bc59b8faf7',
    categoryIDs: ['DEMmwUKFWFfNQYV1X4y0'],
    cookTime: 30,
    steps: [
      '1. Finely dice the onion and mushrooms. Add mushrooms, onion and frozen spinach to a frying pan. Season for taste and mix. Cook on medium het, covered, for 20 minutes.',
      '2. Dissolve rice flour in milk and add to the mushroom mix. Mix well, add nutritional yeast, if using, and cook for another 2 minutes.',
      '3. Spread 1/2 of the mix on a tortilla. Repeat with the second one. Fold in two.',
      '4. Fry or bake the tortilla for 2 minutes, on each side - until nicely toasted. Cut in two and serve hot.',
    ],
    ingreIDToAmount: {
      'KEIs9qtbgCPrnUiwBBmq': '300g',
      'HyS70XOEBTZM5b6SPxS1': '70g',
      'g2GXGHdtqQm4fg4VDtMc': '70g',
      'spDkobzO906VJUYrIFY8': '100ml',
      'S5GHHWyS3TKvDe2KQtyB': '14.3g',
      'TvipONTJ4WmylIAn02WC': '394g',
    },
  ),
  Meal(
    id: '',
    name: 'Oatmeal With Apples & Raisins',
    asset:
        'https://firebasestorage.googleapis.com/v0/b/vipt-506b2.appspot.com/o/meals%2Fasset_oatmeal_with_apples_raisins.png?alt=media&token=0dfc1a8d-a729-4267-b8dd-3fb3612a4265',
    categoryIDs: ['DEMmwUKFWFfNQYV1X4y0'],
    cookTime: 7,
    steps: [
      '1. Cover oat flakes with double the amount of water.',
      '2. Bring to a boil and stir for 3 minutes until it thickens.',
      '3. Transfer cooked oatmeal to a plate.',
      '4. Add diced apple.',
      '5. Add raisins and sprinkle with cinnamon and nutmeg.',
    ],
    ingreIDToAmount: {
      'yPR5hUIshhnzfZf0eOWg': '200g',
      '17bcJ4B5vyVSdX1RLUj9': '300g',
      'MFoYsaaIvPDFw7gLG62N': '90g',
    },
  ),
  Meal(
    id: '',
    name: 'Quinoa With Banana',
    asset:
        'https://firebasestorage.googleapis.com/v0/b/vipt-506b2.appspot.com/o/meals%2Fasset_quinoa_with_banana.png?alt=media&token=4f484fda-1efa-4e27-8390-2b77556abd49',
    categoryIDs: ['DEMmwUKFWFfNQYV1X4y0'],
    cookTime: 20,
    steps: [
      '1. Rinse quinoa really well until the water runs clear.',
      '2. Transfer the quinoa to a cooking pot. Cover with double the amount of water and stir once. Bring water to a boil then lower heat to low. Cover with a lid. Cook the quinoa until it is tender and it has completely absorbed the water ~ 15 minutes.',
      '3. Transfer cooked quinoa to plate.',
      '4. Add sliced banana.',
      '5. Combine peanut butter with water 1:3 ratio and stir until creamy. Drizzle over the quinoa.',
      '6. Sprinkle with cinnamon.',
    ],
    ingreIDToAmount: {
      '8UkxnvrWuD02qyP9GXL2': '200g',
      'AD7bxVVLGV3VIpL3v7xC': '200g',
      '4oF5IxjCQsqpoOcVqeRd': '28.6g',
    },
  ),
  Meal(
    id: '',
    name: 'Protein Cauliflower Bites',
    asset:
        'https://firebasestorage.googleapis.com/v0/b/vipt-506b2.appspot.com/o/meals%2Fasset_protein_cauliflower_bites.png?alt=media&token=32e1e765-5c36-4765-bbc2-58fd557cb7c8',
    categoryIDs: ['N4l3MZe2OXxMgY92Fgyz'],
    cookTime: 50,
    steps: [
      '1. Add all of the ingredients into a food processor.',
      '2. Blend until well combined and dough-like.',
      '3. Preheat the oven to 200 C degrees. Shape the dough into bite-sized balls. Place on top of a baking tray lined with baking paper.',
      '4. Bake in the oven for 30 minutes. Allow to cool on the rack for at least 10 minutes. Serve with sauce of chocie.',
    ],
    ingreIDToAmount: {
      'AJsfoAVUWOv3BeCGHj0d': '300g',
      'RppqGEQm83IbCWp8gLc0': '60g',
      '8kxy6as92KVjYrgepN3n': '200ml',
      'gI9kSVX1JMG8ixnFBvtx': '30g',
      '0OQl7NyxgVPC2NLAvGXH': '5g',
    },
  ),
  Meal(
    id: '',
    name: 'Broccoli & Cauliflower Curry With Rice',
    asset:
        'https://firebasestorage.googleapis.com/v0/b/vipt-506b2.appspot.com/o/meals%2Fasset_broccoli_cauliflower_curry_with_rice.png?alt=media&token=257a2302-ecc8-42d0-a1c5-1453af056ecc',
    categoryIDs: ['N4l3MZe2OXxMgY92Fgyz'],
    cookTime: 50,
    steps: [
      '1. Rinse rice really well. Transfer the rice to a cooking pot. Cover with double the amount of water, season for taste and stir once. Bring water to a boil then lower heat to low. Cover with a lid and simmer until it has completely absorbed the water. It will take ~ 20 minutes for white rice; 35 minutes for brown rice.',
      '2. Add vegetables to a large cooking pot. Add water and bring to a boil. Cover with a lid and cook for 10 minutes.',
      '3. Combine curry powder, molasses, tomato sauce, milk, flour in a bowl. Mix well and add to the vegetables. Add spices, if using, season for taste, stir and cook for another 5 minutes.',
      '4. Fill a cup with 1/2 cooked rice and flip it into a bowl. Repeat with the other bowl.',
      '5. Add curry. Top with spring onions and sprinkle with sesame seeds.',
    ],
    ingreIDToAmount: {
      'MPWQ5F3Eo9NrBMYdJsVr': '200g',
      'xO0Ll5m1A37S7lVGnmcj': '300g',
      'AJsfoAVUWOv3BeCGHj0d': '300g',
      'TfCV7k1WC9Za7FqTf6yM': '100g',
      '8kxy6as92KVjYrgepN3n': '200ml',
      'spDkobzO906VJUYrIFY8': '200ml',
      'RFSAV4Aaq0GWSIgzkkRn': '6.3g',
      'T1NYaaR9uxiQ4Sl9Qn9D': '20g',
      'BnRD1XEihi2C8XVSuQWo': '42.3g',
      'S5GHHWyS3TKvDe2KQtyB': '10g',
    },
  ),
  Meal(
    id: '',
    name: 'Air-Fried Tofu',
    asset:
        'https://firebasestorage.googleapis.com/v0/b/vipt-506b2.appspot.com/o/meals%2Fasset_air_fried_tofu.png?alt=media&token=825f9ff2-0daf-4523-b031-dc458e9f86da',
    categoryIDs: ['N4l3MZe2OXxMgY92Fgyz'],
    cookTime: 25,
    steps: [
      '1. Break a firm block of tofu into bite-sized pieces using your hands. Add to an air-fryer. Drizzle with soy sauce and add spices of choice.',
      '2. Air fry for 20 minutes.',
    ],
    ingreIDToAmount: {
      'yDxe8lbFGS0Djbs8RCpK': '400g',
      'AMDNhAYmYSuw7QL9idxo': '32g',
    },
  ),
  Meal(
    id: '',
    name: 'Quinoa & Sweet Potato',
    asset:
        'https://firebasestorage.googleapis.com/v0/b/vipt-506b2.appspot.com/o/meals%2Fasset_quinoa_sweet_potato.png?alt=media&token=38246d65-012d-4980-9bcb-98a54dedcd37',
    categoryIDs: ['N4l3MZe2OXxMgY92Fgyz'],
    cookTime: 45,
    steps: [
      '1. Preheat the oven to 200 C degrees bottom heat. Place peeled and sliced sweet potatoes on top of a baking tray lined with baking paper in a single layer. Season for taste.',
      '2. Bake in the oven for 20 minutes or until the potatoes are cooked through.',
      '3. Transfer the quinoa to a cooking pot. Cover with double the amount of water and stir once. Bring water to a boil then lower heat to low. Cover with a lid. Cook the quinoa until it is tender and it has completely absorbed the water ~ 15 minutes.',
      '4. Transfer cooked quinoa to a plate.',
      '5. Add cooked sweet potatoes.',
      '6. Thin tahini with water 1:3 ratio, add vinegar and mix until smooth, Drizzle over the potatoes. Garnish with spring onions and sprinkle with sesame seeds.',
    ],
    ingreIDToAmount: {
      '8UkxnvrWuD02qyP9GXL2': '200g',
      'eZfZpqcbsv0dBsnXkxrI': '260g',
      'Bf2nCMGjS1Tey0pkMN9f': '30g',
      'ob5GMe2hwTuMFCLLgazn': '5g',
    },
  ),
  Meal(
    id: '',
    name: 'Sweet Potato Curry With Rice',
    asset:
        'https://firebasestorage.googleapis.com/v0/b/vipt-506b2.appspot.com/o/meals%2Fasset_sweet_potato_curry_with_rice.png?alt=media&token=adb72f95-a1aa-4c99-abb2-a24182b5d336',
    categoryIDs: ['N4l3MZe2OXxMgY92Fgyz'],
    cookTime: 50,
    steps: [
      '1. Rinse rice really well. Transfer the rice to a cooking pot. Cover with double the amount of water, season for taste and stir once. Bring water to a boil then lower heat to low. Cover with a lid and simmer until it has completely absorbed the water. It will take ~ 20 minutes for white rice; 35 minutes for brown rice.',
      '2. Peel and cut sweet potato into bite-sized pieces. Cover with 1 cup of water. Cover with a lid and bring to a boil. Saute for 10 minutes or until tender. Drain.',
      '3. Combine coconut milk, curry powder and tomato paste together and pour over the potatoes.',
      '4. Add spinach - can be taken directly from the freezer, season for taste and stir. Cook for another 2-3 minutes or until the curry thickens.',
      '5. Add cooked rice to one side of the plate and add ready sweet potato curry to the other.',
      '6. Sprinkle with sesame seeds.',
    ],
    ingreIDToAmount: {
      'eZfZpqcbsv0dBsnXkxrI': '260g',
      'S5GHHWyS3TKvDe2KQtyB': '100g',
      'HyS70XOEBTZM5b6SPxS1': '100g',
      'BnRD1XEihi2C8XVSuQWo': '47.6g',
      'spDkobzO906VJUYrIFY8': '200ml',
      'T1NYaaR9uxiQ4Sl9Qn9D': '20g',
      'RFSAV4Aaq0GWSIgzkkRn': '6.3g',
    },
  ),
  Meal(
    id: '',
    name: 'Mushroom Steak',
    asset:
        'https://firebasestorage.googleapis.com/v0/b/vipt-506b2.appspot.com/o/meals%2Fasset_mushroom_steak.png?alt=media&token=cc69cb11-6c9c-44c7-886e-3840558b0211',
    categoryIDs: ['N4l3MZe2OXxMgY92Fgyz'],
    cookTime: 40,
    steps: [
      '1. Place all of the ingredients into a food processor. Season for taste.',
      '2. Blend until well combined. If you don/’t have a food processor, finely dice mushrooms and then combine them with the rest of the ingredients.',
      '3. Preheat the oven to 200 C degrees. Transfer the mix to a baking tray lined with baking paper.',
      '4. Shape the mix into steaks with a spoon. Bake in the oven for 30 minutes.',
      '5. Transfer to a plate.',
      '6. Make the sauce by mixing yogurt with dried dill. Garnish with sliced cucumbers.',
    ],
    ingreIDToAmount: {
      'KEIs9qtbgCPrnUiwBBmq': '400g',
      'UZpl2MgI6Rvv9bsWs3fp': '90g',
      'gI9kSVX1JMG8ixnFBvtx': '30g',
      'j6TD1SggLbZTguWD47HF': '32g',
    },
  ),
  Meal(
    id: '',
    name: 'Mushroom Walnut Burger',
    asset:
        'https://firebasestorage.googleapis.com/v0/b/vipt-506b2.appspot.com/o/meals%2Fasset_mushroom_walnut_burger.png?alt=media&token=e03f5a23-13e2-4dcf-9370-40327a0bb19f',
    categoryIDs: ['N4l3MZe2OXxMgY92Fgyz'],
    cookTime: 40,
    steps: [
      '1. Place all of the ingredients into a food processor. Season for taste.',
      '2. Blend until combined and paste-like. If you don/’t have a food processor, finely dice mushrooms and crush the walnuts and then combine them with the rest of the ingredients.',
      '3. Preheat the oven to 200 C degrees. Shape the mix into burger patties. Place the patties on top of a baking tray lined with baking paper.',
      '4. Bake in the oven for 15 minutes. Flip the patties over and bake them for another 15 minutes, 30 minutes in total.',
      '5. Transfer to a plate. Serve with yogurt sauce on the side and garnish with tomatoes and pine nuts.',
    ],
    ingreIDToAmount: {
      'KEIs9qtbgCPrnUiwBBmq': '400g',
      '7GhVWZSWDsBiEkmUJ3YH': '50g',
      'UZpl2MgI6Rvv9bsWs3fp': '50g',
      'gI9kSVX1JMG8ixnFBvtx': '30g',
      'j6TD1SggLbZTguWD47HF': '32g',
    },
  ),
  Meal(
    id: '',
    name: 'Carrot Cake Bites',
    asset:
        'https://firebasestorage.googleapis.com/v0/b/vipt-506b2.appspot.com/o/meals%2Fasset_carrot_cake_bites.png?alt=media&token=bdd22047-ab25-4f24-adc0-18f298bb39e7',
    categoryIDs: ['UrMFD5dZYHMvcQ4t9ed4'],
    cookTime: 15,
    steps: [
      '1. Add dates, frozen carrots and water to a blender. Blend until smooth.',
      '2. Combine pureed date and carrots with oat flour and mix until well combined and dough-like.',
      '3. Shape into bite-sized balls. Keep refrigerated.',
    ],
    ingreIDToAmount: {
      '8kxy6as92KVjYrgepN3n': '100ml',
      'TfCV7k1WC9Za7FqTf6yM': '100g',
      'HKZQvQyHjFHJuhZLvBLs': '200g',
    },
  ),
  Meal(
    id: '',
    name: 'Raw Gingerbread Bites',
    asset:
        'https://firebasestorage.googleapis.com/v0/b/vipt-506b2.appspot.com/o/meals%2Fasset_raw_gingerbread_bites.png?alt=media&token=d8e8c4ca-c2e6-4b28-b1fe-ade52d27d0a5',
    categoryIDs: ['UrMFD5dZYHMvcQ4t9ed4'],
    cookTime: 15,
    steps: [
      '1. Add all of the ingredients to a bowl. Note: If you don/’t have oat flour you can use a blender and grind rolled oats into flour first. ',
      '2. Mix until well combined.',
      '3. Shape into bite-sized balls. To make working with the dough easier, wet your hands from time to time. Serve with a glass of almond milk.',
    ],
    ingreIDToAmount: {
      'HKZQvQyHjFHJuhZLvBLs': '200g',
      'rvZVB29KNgwFxTriay7g': '2.7g',
      'T1NYaaR9uxiQ4Sl9Qn9D': '20g',
      '8f3TIS03haL4uKIfySPb': '60ml',
      'spDkobzO906VJUYrIFY8': '90ml',
    },
  ),
  Meal(
    id: '',
    name: 'Buckwheat Bread',
    asset:
        'https://firebasestorage.googleapis.com/v0/b/vipt-506b2.appspot.com/o/meals%2Fasset_buckwheat_bread.png?alt=media&token=cfd4405b-f8b8-4c9d-93b7-104e58e331a1',
    categoryIDs: ['UrMFD5dZYHMvcQ4t9ed4'],
    cookTime: 75,
    steps: [
      '1. Combine buckwheat flour, sunflower seeds, ground flaxseeds, water, molasses, vinegar and psyllium husks if using, and season for taste.',
      '2. Mix until well combined.',
      '3. Transfer the dough to a baking sheet, fold it around the dough to shape a log. If the paper comes off easily, you can bake right away, otherwise place the ‘log’ into the freezer for 30 minutes and then remove the paper.',
      '4. Preheat the oven to 200 C degrees.',
      '5. Place the log on top of a baking tray lined with a fresh sheet of baking paper. Bake for 20 minutes.',
      '6. Cool on the rack for 10 minutes and slice.',
    ],
    ingreIDToAmount: {
      'g7DiEPnjqqlAofzdVj9p': '200g',
      'gI9kSVX1JMG8ixnFBvtx': '30g',
      'MxXujbaWC3Cc68CFUUos': '60g',
      'T1NYaaR9uxiQ4Sl9Qn9D': '20g',
      'ob5GMe2hwTuMFCLLgazn': '5g',
      '8kxy6as92KVjYrgepN3n': '200ml',
    },
  ),
  Meal(
    id: '',
    name: 'Onion Rings',
    asset:
        'https://firebasestorage.googleapis.com/v0/b/vipt-506b2.appspot.com/o/meals%2Fasset_onion_rings.png?alt=media&token=f638bb8f-1dfe-4d6a-9853-79611a7ded99',
    categoryIDs: ['UrMFD5dZYHMvcQ4t9ed4'],
    cookTime: 35,
    steps: [
      '1. Combine all of the ingredients, except onions, in a mixing bowl to make the batter. Mix until well combined.',
      '2. Preheat the oven to 200 C degrees. Slice the onion into rings and remove the middle. Place on top of a baking tray lined with baking paper.',
      '3. Spoon the batter and pour it over the rings.',
      '4. Bake in the oven for 20 minutes.',
    ],
    ingreIDToAmount: {
      'g2GXGHdtqQm4fg4VDtMc': '150g',
      'B0SDZEdTdLHuny4dCRXv': '30g',
      'UZpl2MgI6Rvv9bsWs3fp': '100g',
      '8kxy6as92KVjYrgepN3n': '160ml',
      '81dxEcSPU0BB8YcF1e71': '4.6g',
      'ob5GMe2hwTuMFCLLgazn': '5g',
      '0OQl7NyxgVPC2NLAvGXH': '3g',
    },
  ),
  Meal(
    id: '',
    name: 'Pumpkin Oat Bites',
    asset:
        'https://firebasestorage.googleapis.com/v0/b/vipt-506b2.appspot.com/o/meals%2Fasset_pumpkin_oat_bites.png?alt=media&token=9ae62482-d123-4a5c-b28c-1f253d715734',
    categoryIDs: ['UrMFD5dZYHMvcQ4t9ed4'],
    cookTime: 15,
    steps: [
      '1. Add all of the ingredients to a bowl. Note: If you don/’t have oat flour you can use a blender and grind rolled oats into flour first.',
      '2. Mix until well combined.',
      '3. Shape into bite-sized balls. Chill in the fridge before serving.',
    ],
    ingreIDToAmount: {
      'Y3iNjgkud5FsnBJr8tI1': '200g',
      'HKZQvQyHjFHJuhZLvBLs': '150g',
      '8f3TIS03haL4uKIfySPb': '60ml',
    },
  ),
  Meal(
    id: '',
    name: 'Apple Nachos',
    asset:
        'https://firebasestorage.googleapis.com/v0/b/vipt-506b2.appspot.com/o/meals%2Fasset_apple_nachos.png?alt=media&token=ee1e2337-e176-4be1-a5dd-0697194b084e',
    categoryIDs: ['UrMFD5dZYHMvcQ4t9ed4'],
    cookTime: 7,
    steps: [
      '1. Slice apples and add to a plate.',
      '2. Thin peanut butter with water 1:3 ratio. Add vinegar and mix until smooth. Drizzle over the apples.',
      '3. Sprinkle with coconut flakes and cinnamon. Add sliced dried apricots.',
    ],
    ingreIDToAmount: {
      '17bcJ4B5vyVSdX1RLUj9': '300g',
      '4oF5IxjCQsqpoOcVqeRd': '32g',
      'LoKFnfitZs4Cm7fkIuba': '29.8g',
    },
  ),
  Meal(
    id: '',
    name: 'Roasted Chickpeas',
    asset:
        'https://firebasestorage.googleapis.com/v0/b/vipt-506b2.appspot.com/o/meals%2Fasset_roasted_chickpeas.png?alt=media&token=ad619084-5a5e-4f75-967a-9c2d09de565f',
    categoryIDs: ['UrMFD5dZYHMvcQ4t9ed4'],
    cookTime: 30,
    steps: [
      '1. Preheat the oven to 200 C degrees. Drain and drizzle the chickpeas with olive oil and season for taste. Arrange them on top of a baking tray lined with baking paper in a single layer.',
      '2. Roast in the oven for 20 minutes or until they begin to form a golden brown crust.',
      '3. Transfer to a bowl.',
    ],
    ingreIDToAmount: {
      'D3K8K0mArwKo06NAtm5g': '240g',
      'UdBfLxYThTH0z56n5Rzz': '26.6g',
    },
  ),
];


// void addFakeData() async {
  //   List<String> type = ['animation', 'thumbnail', 'muscle_focus'];
  //   String animationType = 'mp4';
  //   String thumbnailType = 'jpg';
  //   String muscleFocusType = 'png';
  //   List<Workout> data = [
  //     //
  //     Workout(null,
  //         name: 'Windmill',
  //         animation: generateLink('Windmill', type[0], animationType),
  //         thumbnail: generateLink('Windmill', type[1], thumbnailType),
  //         hints:
  //             'Do not slouch your back. Your arms are straight. Do not shrug your shoulders.',
  //         breathing: 'Breathe in going down, breathe out going up.',
  //         muscleFocusAsset: generateLink('Windmill', type[2], muscleFocusType),
  //         categoryIDs: ['Rxb89cZTkXtSLvghJeei'],
  //         metValue: 2.5,
  //         equipmentIDs: []),
  //     //
  //     //
  //     Workout(null,
  //         name: 'Yoga Backbend',
  //         animation: generateLink('Yoga Backbend', type[0], animationType),
  //         thumbnail: generateLink('Yoga Backbend', type[1], thumbnailType),
  //         hints:
  //             'Keep your core tight all the time. Engage your inner thighs and glutes. Push your pelvis forward. Keep stretching your arms further. Keep your spine long and straight. Spread your toes and firmly plant them into the mat - this brings more stability to your stance.',
  //         breathing: 'Breathe deeply. Do not hold your breath.',
  //         muscleFocusAsset:
  //             generateLink('Yoga Backbend', type[2], muscleFocusType),
  //         categoryIDs: ['Rxb89cZTkXtSLvghJeei'],
  //         metValue: 2.5,
  //         equipmentIDs: []),
  //     //
  //     //
  //     Workout(null,
  //         name: 'Jumping Jacks',
  //         animation: generateLink('Jumping Jacks', type[0], animationType),
  //         thumbnail: generateLink('Jumping Jacks', type[1], thumbnailType),
  //         hints:
  //             'Squeeze your abdominal muscles. Do not shrug your shoulders. Land softly on your feet. Be as fast as your can, but don\'t compromise the technique.',
  //         breathing: 'Breathe in going down, breathe out going up.',
  //         muscleFocusAsset:
  //             generateLink('Jumping Jacks', type[2], muscleFocusType),
  //         categoryIDs: ['Gwif2wxSJ4MCGh9xT9bs', '4JX1H4ZFDkb85zQkA6df'],
  //         metValue: 8,
  //         equipmentIDs: []),
  //     //
  //     //
  //     Workout(null,
  //         name: 'High Knees',
  //         animation: generateLink('High Knees', type[0], animationType),
  //         thumbnail: generateLink('High Knees', type[1], thumbnailType),
  //         hints:
  //             'Keep your core tight all the time. Do not shrug your shoulders. Avoid collapsing knees inwards. Be as fast as you can, but don\'t compromise the technique.',
  //         breathing: 'Breathe deeply. Do not hold your breath.',
  //         muscleFocusAsset:
  //             generateLink('High Knees', type[2], muscleFocusType),
  //         categoryIDs: [
  //           'Gwif2wxSJ4MCGh9xT9bs',
  //           '4JX1H4ZFDkb85zQkA6df',
  //           'jOLYMcvtft5eUGyv2ciW'
  //         ],
  //         metValue: 6,
  //         equipmentIDs: []),
  //     //
  //     //
  //     Workout(null,
  //         name: 'Plank Jacks',
  //         animation: generateLink('Plank Jacks', type[0], animationType),
  //         thumbnail: generateLink('Plank Jacks', type[1], thumbnailType),
  //         hints:
  //             'Feal the gluteal muscles - not your lower back. Engage your inner thighs and glutes. Knees hip width apart. The backside of the neck is on the mat. Do not overarch your lower back. Keep your back straight. Do not rest in the bottom position.',
  //         breathing: 'Breathe in going down, breathe out going up.',
  //         muscleFocusAsset:
  //             generateLink('Plank Jacks', type[2], muscleFocusType),
  //         categoryIDs: [
  //           '4JX1H4ZFDkb85zQkA6df',
  //           'jOLYMcvtft5eUGyv2ciW',
  //           'Gwif2wxSJ4MCGh9xT9bs',
  //           'TOcjJylRaR8D7tJHbz8z'
  //         ],
  //         metValue: 4,
  //         equipmentIDs: []),
  //     //
  //     //
  //     Workout(null,
  //         name: 'Bridges',
  //         animation: generateLink('Bridges', type[0], animationType),
  //         thumbnail: generateLink('Bridges', type[1], thumbnailType),
  //         hints:
  //             'Feal the gluteal muscles - not your lower back. Engage your inner thighs and glutes. Knees hip width apart. The back side of the neck is on the mat. Do not overarch your lower back. Keep your back straight. Do not rest in the bottom position.',
  //         breathing: 'Breathe in going down, breathe out going up.',
  //         muscleFocusAsset: generateLink('Bridges', type[2], muscleFocusType),
  //         categoryIDs: ['4JX1H4ZFDkb85zQkA6df', 'jOLYMcvtft5eUGyv2ciW'],
  //         metValue: 4,
  //         equipmentIDs: []),
  //     //
  //     //
  //     Workout(null,
  //         name: 'Plank',
  //         animation: generateLink('Plank', type[0], animationType),
  //         thumbnail: generateLink('Plank', type[1], thumbnailType),
  //         hints:
  //             'Squeeze your abdominal muscles. Do not shrug your shoulders. Land softly on your feet. Be as fast as your can, but don’t compromise the technique.',
  //         breathing: 'Breathe deeply. Do not hold your breath.',
  //         muscleFocusAsset: generateLink('Plank', type[2], muscleFocusType),
  //         categoryIDs: ['TOcjJylRaR8D7tJHbz8z', 'jOLYMcvtft5eUGyv2ciW'],
  //         metValue: 3,
  //         equipmentIDs: []),
  //     //
  //     //
  //     Workout(null,
  //         name: 'Push Ups',
  //         animation: generateLink('Push Ups', type[0], animationType),
  //         thumbnail: generateLink('Push Ups', type[1], thumbnailType),
  //         hints:
  //             'Flatten your back. Keep your core tight all the time. Align the shoulders right above your wrists. Keep your head and pelvis in the line with your spine. Draw the tops of your shoulders far away from your ears.',
  //         breathing: 'Breathe deeply. Do not hold your breath.',
  //         muscleFocusAsset: generateLink('Push Ups', type[2], muscleFocusType),
  //         categoryIDs: ['TOcjJylRaR8D7tJHbz8z'],
  //         metValue: 4,
  //         equipmentIDs: []),
  //     //
  //     //
  //     Workout(null,
  //         name: 'Crunches',
  //         animation: generateLink('Crunches', type[0], animationType),
  //         thumbnail: generateLink('Crunches', type[1], thumbnailType),
  //         hints:
  //             'Use your abdominals to get up, your neck and shoulders are relaxed. Do not pull your neck with your hands. Focus on muscle contraction, the range of motion is not important. Squeeze your shoulder blades together. Do not shrug your shoulders. Try to relax your neck muscles.',
  //         breathing: 'Breathe in going down, breathe out going up.',
  //         muscleFocusAsset: generateLink('Crunches', type[2], muscleFocusType),
  //         categoryIDs: ['jOLYMcvtft5eUGyv2ciW'],
  //         metValue: 4.5,
  //         equipmentIDs: []),
  //     //
  //     //
  //     Workout(null,
  //         name: 'Burpees',
  //         animation: generateLink('Burpees', type[0], animationType),
  //         thumbnail: generateLink('Burpees', type[1], thumbnailType),
  //         hints:
  //             'Do not slouch your back. Knees should not go over your toes. Do not shrug your shoulders. Keep your elbows slightly bent. Be as fast as you can, but don’t compromise the technique.',
  //         breathing: 'Breathe deeply. Do not hold your breath.',
  //         muscleFocusAsset: generateLink('Burpees', type[2], muscleFocusType),
  //         categoryIDs: [
  //           'jOLYMcvtft5eUGyv2ciW',
  //           'TOcjJylRaR8D7tJHbz8z',
  //           '4JX1H4ZFDkb85zQkA6df',
  //           'Gwif2wxSJ4MCGh9xT9bs'
  //         ],
  //         metValue: 7,
  //         equipmentIDs: []),
  //     //

  //     // GYM

  //     // ABS
  //     //
  //     Workout(null,
  //         name: 'Captain\'s Chair Leg Raise',
  //         animation:
  //             generateLink('Captain Chair Leg Raise', type[0], animationType),
  //         thumbnail:
  //             generateLink('Captain Chair Leg Raise', type[1], thumbnailType),
  //         hints:
  //             'Use your abs to raise your legs, not any of your body momentum. Don\'t arch your back or let your back sag. Keep your lower back remains as tight as possible.',
  //         breathing: 'Breathe deeply. Do not hold your breath.',
  //         muscleFocusAsset:
  //             generateLink('Captain Chair Leg Raise', type[2], muscleFocusType),
  //         categoryIDs: ['D1MmmI7lu04PKWW6iiD3'],
  //         metValue: 4.5,
  //         equipmentIDs: ['2IEPFCxE5VFCZf8PKd2j']),
  //     //
  //     //
  //     Workout(null,
  //         name: 'Rope Crunch',
  //         animation: generateLink('Rope Crunch', type[0], animationType),
  //         thumbnail: generateLink('Rope Crunch', type[1], thumbnailType),
  //         hints:
  //             'Keep your back straight. Use your abs muscles to move the pulley cable not the triceps of hip flexors. Engage your glutes and hamstrings during the exercise.',
  //         breathing: 'Breathe deeply. Do not hold your breath.',
  //         muscleFocusAsset:
  //             generateLink('Rope Crunch', type[2], muscleFocusType),
  //         categoryIDs: ['D1MmmI7lu04PKWW6iiD3'],
  //         metValue: 4.5,
  //         equipmentIDs: ['HRss7wXCRrhcxEOS2b7g']),
  //     //

  //     // CAVLES
  //     //
  //     Workout(null,
  //         name: 'Seated Calf Raise',
  //         animation: generateLink('Seated Calf Raise', type[0], animationType),
  //         thumbnail: generateLink('Seated Calf Raise', type[1], thumbnailType),
  //         hints: 'Don\'t use your hips or knees to lift.',
  //         breathing:
  //             'Breathe in when lower the heels. Breathe out when raise the heels.',
  //         muscleFocusAsset:
  //             generateLink('Seated Calf Raise', type[2], muscleFocusType),
  //         categoryIDs: ['EG9GiBTRIc3gwXRklYtN'],
  //         metValue: 4.5,
  //         equipmentIDs: ['WkEV9tCQqNqtjbIXgIvn']),
  //     //
  //     //
  //     Workout(null,
  //         name: 'Smith Machine Calf Raise',
  //         animation:
  //             generateLink('Smith Machine Calf Raise', type[0], animationType),
  //         thumbnail:
  //             generateLink('Smith Machine Calf Raise', type[1], thumbnailType),
  //         hints:
  //             'Keep your legs and your back straight. Hold the contracted position for a second before go back down.',
  //         breathing:
  //             'Breathe in when go back down.  Breath out right after that.',
  //         muscleFocusAsset: generateLink(
  //             'Smith Machine Calf Raise', type[2], muscleFocusType),
  //         categoryIDs: ['EG9GiBTRIc3gwXRklYtN'],
  //         metValue: 4.5,
  //         equipmentIDs: ['WkEV9tCQqNqtjbIXgIvn']),
  //     //

  //     // BACK
  //     //
  //     Workout(null,
  //         name: 'Seated Cable Rows',
  //         animation: generateLink('Seated Cable Rows', type[0], animationType),
  //         thumbnail: generateLink('Seated Cable Rows', type[1], thumbnailType),
  //         hints:
  //             'Keep the torso stationary. Squeezing the back muscles hard when pull back. Avoid swinging your torso back and forth.',
  //         breathing:
  //             'Breathe out when pull back. Breathe in while extend the arm.',
  //         muscleFocusAsset:
  //             generateLink('Seated Cable Rows', type[2], muscleFocusType),
  //         categoryIDs: ['EnJGIHpzLJTNZEaWYaTp'],
  //         metValue: 4.5,
  //         equipmentIDs: ['HRss7wXCRrhcxEOS2b7g']),
  //     //
  //     //
  //     Workout(null,
  //         name: 'Bent Over Barbell Row',
  //         animation:
  //             generateLink('Bent Over Barbell Row', type[0], animationType),
  //         thumbnail:
  //             generateLink('Bent Over Barbell Row', type[1], thumbnailType),
  //         hints: 'Keep the head up. Use forearms to hold the weight.',
  //         breathing:
  //             'Breathe out when lift the barbell. Breathe in when lower the barbell.',
  //         muscleFocusAsset:
  //             generateLink('Bent Over Barbell Row', type[2], muscleFocusType),
  //         categoryIDs: ['EnJGIHpzLJTNZEaWYaTp'],
  //         metValue: 4.5,
  //         equipmentIDs: ['vwUykASGzYM2XaDXYJGR']),
  //     //

  //     // TRICEPS
  //     //
  //     Workout(null,
  //         name: 'Triceps dip',
  //         animation: generateLink('Triceps dip', type[0], animationType),
  //         thumbnail: generateLink('Triceps dip', type[1], thumbnailType),
  //         hints:
  //             'The torso should be upright. Keep the elbows close to the body.',
  //         breathing:
  //             'Breathe in when lower yourself. Breathe out when push yourself up.',
  //         muscleFocusAsset:
  //             generateLink('Triceps dip', type[2], muscleFocusType),
  //         categoryIDs: ['ONYmT3ypfKyXSN0iHrwX'],
  //         metValue: 4.5,
  //         equipmentIDs: []),
  //     //
  //     //
  //     Workout(null,
  //         name: 'Weighted bench dip',
  //         animation: generateLink('Weighted bench dip', type[0], animationType),
  //         thumbnail: generateLink('Weighted bench dip', type[1], thumbnailType),
  //         hints:
  //             'Keep the elbows as close as possible. Forearms should always be pointing down.',
  //         breathing:
  //             'Breathe in when lower yourself. Breathe out when push yourself up.',
  //         muscleFocusAsset:
  //             generateLink('Weighted bench dip', type[2], muscleFocusType),
  //         categoryIDs: ['ONYmT3ypfKyXSN0iHrwX'],
  //         metValue: 4.5,
  //         equipmentIDs: []),
  //     //

  //     // FOREARMS
  //     //
  //     Workout(null,
  //         name: 'Palms-down wrist curl over bench',
  //         animation: generateLink(
  //             'Palms down wrist curl over bench', type[0], animationType),
  //         thumbnail: generateLink(
  //             'Palms down wrist curl over bench', type[1], thumbnailType),
  //         hints:
  //             'Use the wrist to move the barbell. Keep the forearms stationary.',
  //         breathing:
  //             'Breathe out when lift the barbell. Breathe in when lower the barbell.',
  //         muscleFocusAsset: generateLink(
  //             'Palms down wrist curl over bench', type[2], muscleFocusType),
  //         categoryIDs: ['WB8uCEADkLOO7N3R5ufQ'],
  //         metValue: 4.5,
  //         equipmentIDs: ['vwUykASGzYM2XaDXYJGR']),
  //     //
  //     //
  //     Workout(null,
  //         name: 'Seated finger curl',
  //         animation: generateLink('Seated finger curl', type[0], animationType),
  //         thumbnail: generateLink('Seated finger curl', type[1], thumbnailType),
  //         hints:
  //             'Hands space about shoulder width. Place the feet at a distance wider than shoulder width.',
  //         breathing:
  //             'Breathe in when lower the barbell. Breathe out when lift the barbell.',
  //         muscleFocusAsset:
  //             generateLink('Seated finger curl', type[2], muscleFocusType),
  //         categoryIDs: ['WB8uCEADkLOO7N3R5ufQ'],
  //         metValue: 4.5,
  //         equipmentIDs: ['vwUykASGzYM2XaDXYJGR']),
  //     //

  //     // SHOULDER
  //     //
  //     Workout(null,
  //         name: 'Clean and press',
  //         animation: generateLink('Clean and press', type[0], animationType),
  //         thumbnail: generateLink('Clean and press', type[1], thumbnailType),
  //         hints:
  //             'Keep the back flat. Pull the bar as high as possible. Keep the elbows out.',
  //         breathing:
  //             'Breathe in before lift the barbell. Breathe out when the barbell at the top.',
  //         muscleFocusAsset:
  //             generateLink('Clean and press', type[2], muscleFocusType),
  //         categoryIDs: ['bX2VABYBtuJv2MyAp7Of'],
  //         metValue: 4.5,
  //         equipmentIDs: ['vwUykASGzYM2XaDXYJGR']),
  //     //
  //     //
  //     Workout(null,
  //         name: 'Dumbbell front raise to lateral raise',
  //         animation: generateLink(
  //             'Dumbbell front raise to lateral raise', type[0], animationType),
  //         thumbnail: generateLink(
  //             'Dumbbell front raise to lateral raise', type[1], thumbnailType),
  //         hints:
  //             'Keep the arms extended. Raise the weight to the shoulder height.',
  //         breathing:
  //             'Breathe in when lift the weight. Breathe out when lower the weight.',
  //         muscleFocusAsset: generateLink(
  //             'Dumbbell front raise to lateral raise',
  //             type[2],
  //             muscleFocusType),
  //         categoryIDs: ['bX2VABYBtuJv2MyAp7Of'],
  //         metValue: 4.5,
  //         equipmentIDs: ['EpDMgHL0pW9xg8ftCngh']),
  //     //

  //     // BICEPS
  //     //
  //     Workout(null,
  //         name: 'Biceps curl to shoulder press',
  //         animation: generateLink(
  //             'Biceps curl to shoulder press', type[0], animationType),
  //         thumbnail: generateLink(
  //             'Biceps curl to shoulder press', type[1], thumbnailType),
  //         hints:
  //             ' Place the feet at the distance shoulder width. Do not use momentum or flex through the shoulder, instead use a controlled motion.',
  //         breathing:
  //             'Breathe in when lift the weight. Breathe out when lower the weight.',
  //         muscleFocusAsset: generateLink(
  //             'Biceps curl to shoulder press', type[2], muscleFocusType),
  //         categoryIDs: ['dSttCngur4jce5Cr9vxx'],
  //         metValue: 4.5,
  //         equipmentIDs: ['EpDMgHL0pW9xg8ftCngh']),
  //     //

  //     // CHEST
  //     //
  //     Workout(null,
  //         name: 'Dumbbell Bench Press',
  //         animation:
  //             generateLink('Dumbbell Bench Press', type[0], animationType),
  //         thumbnail:
  //             generateLink('Dumbbell Bench Press', type[1], thumbnailType),
  //         hints: ' Lower the weight take about twice as long as possible.',
  //         breathing:
  //             'Breathe out when lift the weight. Breathe in when lower the weight.',
  //         muscleFocusAsset:
  //             generateLink('Dumbbell Bench Press', type[2], muscleFocusType),
  //         categoryIDs: ['fZ9aeJi6QWnFPCQcsx4x'],
  //         metValue: 4.5,
  //         equipmentIDs: ['EpDMgHL0pW9xg8ftCngh']),
  //     //
  //     //
  //     Workout(null,
  //         name: 'Decline Dumbbell Flyes',
  //         animation:
  //             generateLink('Decline Dumbbell Flyes', type[0], animationType),
  //         thumbnail:
  //             generateLink('Decline Dumbbell Flyes', type[1], thumbnailType),
  //         hints:
  //             'The arms should remain stationary. The movement should only occur at the shoulder joint.',
  //         breathing:
  //             'Breathe in when lower the weight. Breathe out when lift the weight.',
  //         muscleFocusAsset:
  //             generateLink('Decline Dumbbell Flyes', type[2], muscleFocusType),
  //         categoryIDs: ['fZ9aeJi6QWnFPCQcsx4x'],
  //         metValue: 4.5,
  //         equipmentIDs: ['EpDMgHL0pW9xg8ftCngh']),
  //     //

  //     // THIGH
  //     //
  //     Workout(null,
  //         name: 'Barbell Full Squat',
  //         animation: generateLink('Barbell Full Squat', type[0], animationType),
  //         thumbnail: generateLink('Barbell Full Squat', type[1], thumbnailType),
  //         hints: 'Keep your head up at all times and maintain a straight back.',
  //         breathing:
  //             'Breathe in when lower the weight. Breathe out when lift the weight.',
  //         muscleFocusAsset:
  //             generateLink('Barbell Full Squat', type[2], muscleFocusType),
  //         categoryIDs: ['jsdZ9gn4OdXRCh7P8aEp'],
  //         metValue: 4.5,
  //         equipmentIDs: ['vwUykASGzYM2XaDXYJGR']),
  //     //
  //     //
  //     Workout(null,
  //         name: 'Leg Press',
  //         animation: generateLink('Leg Press', type[0], animationType),
  //         thumbnail: generateLink('Leg Press', type[1], thumbnailType),
  //         hints:
  //             'Make sure that you do not lock your knees. Your torso and the legs should make a perfect 90 degree angle.',
  //         breathing:
  //             'Breathe in when lower the platform. Breathe out when lift the platform.',
  //         muscleFocusAsset: generateLink('Leg Press', type[2], muscleFocusType),
  //         categoryIDs: ['jsdZ9gn4OdXRCh7P8aEp'],
  //         metValue: 4.5,
  //         equipmentIDs: ['WkEV9tCQqNqtjbIXgIvn']),
  //     //
  //     //
  //   ];
  //   for (var item in data) {
  //     await add(item);
  //   }
  // }

  // void updateFakeData() async {
  //   List<Workout> list = await fetchAll();
  //   list.map((e) {
  //     var s = e.thumbnail.replaceAll('.jpg', '.png');
  //     update(
  //         e.id ?? '',
  //         Workout(e.id,
  //             name: e.name,
  //             animation: e.animation,
  //             thumbnail: s,
  //             hints: e.hints,
  //             breathing: e.breathing,
  //             muscleFocusAsset: e.muscleFocusAsset,
  //             categoryIDs: e.categoryIDs,
  //             metValue: e.metValue,
  //             equipmentIDs: e.equipmentIDs));
  //   }).toList();
  // }
