import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/workout.dart';
import 'package:vipt/app/data/providers/firestoration.dart';

class WorkoutProvider implements Firestoration<String, Workout> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<Workout> add(Workout obj) async {
    await _firestore
        .collection(collectionPath)
        .add(obj.toMap())
        .then((value) => obj.id = value.id);
    return obj;
  }

  String generateLink(String name, String type, String extenstion) {
    return '${type}_' +
        name.replaceAll(' ', '_').toLowerCase() +
        '.$extenstion';
  }

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

  @override
  String get collectionPath => AppValue.workoutsPath;

  @override
  Future<String> delete(String id) {
    throw UnimplementedError();
  }

  @override
  Future<Workout> fetch(String id) async {
    final raw = await _firestore.collection(collectionPath).doc(id).get();
    return Workout.fromMap(raw.id, raw.data() ?? {});
  }

  @override
  Future<Workout> update(String id, Workout obj) async {
    await _firestore.collection(collectionPath).doc(id).update(obj.toMap());
    return obj;
  }

  @override
  Future<List<Workout>> fetchAll() async {
    QuerySnapshot<Map<String, dynamic>> raw =
        await _firestore.collection(collectionPath).get();

    List<Workout> list = [];
    for (var element in raw.docs) {
      list.add(Workout.fromMap(element.id, element.data()));
    }

    return list;
  }
}
