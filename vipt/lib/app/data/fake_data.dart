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
