import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/app_strings.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/data/models/answer.dart';
import 'package:vipt/app/data/models/question.dart';
import 'package:vipt/app/enums/app_enums.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'colors.dart';

class AppDecoration {
  static const EdgeInsets screenPadding = EdgeInsets.fromLTRB(24, 24, 24, 24);
  static InputDecoration noHighlightInputDecoration = InputDecoration(
    border: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColor.textFieldUnderlineColor)),
    enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColor.textFieldUnderlineColor)),
    focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColor.textFieldUnderlineColor)),
  );
  static InputDecoration fillInputDecoration = InputDecoration(
    filled: true,
    fillColor: AppColor.textFieldFill,
    border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(28),
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        )),
  );
  static InputDecoration dateTimeFieldDecoration = InputDecoration(
    filled: true,
    suffixIcon: const Icon(
      Icons.calendar_today_rounded,
      size: 18,
    ),
    fillColor: AppColor.textFieldFill,
    border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(28),
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(10),
        )),
  );
}

class AppQuiz {
  static const Map<int, int> moduleMap = {
    0: 11,
    1: 4,
    2: 4,
  };

  static Map<Question, List<Answer>> questions = {
    // Module 1
    Question(
        title: 'Tên của bạn là gì?'.tr,
        description: '',
        moduleParent: 0,
        moduleIndex: 1,
        propertyLink: PropertyLink.userName,
        layoutType: QuestionLayoutType.textField): [],
    Question(
        title: 'Mục tiêu về cân nặng'.tr,
        description: 'Bạn muốn mình có thể đạt được mức cân nặng bao nhiêu?'.tr,
        moduleParent: 0,
        moduleIndex: 2,
        propertyLink: PropertyLink.userGoalWeight,
        layoutType: QuestionLayoutType.measurementPicker): [],
    Question(
        title: 'Giới tính'.tr,
        propertyLink: PropertyLink.userGender,
        description:
            'Việc thu thập thông tin này sẽ giúp tôi có thể tính toán BMI và tạo ra một kế hoạch cân nặng lành mạnh cá nhân cho riêng bạn.'
                .tr,
        moduleParent: 0,
        moduleIndex: 3,
        layoutType: QuestionLayoutType.singleChoiceOneColumn): [
      Answer(
          title: 'Nam'.tr,
          description: '',
          asset: SVGAssetString.male,
          enumValue: Gender.male),
      Answer(
          title: 'Nữ'.tr,
          description: '',
          asset: SVGAssetString.female,
          enumValue: Gender.female),
      Answer(
          title: 'Khác'.tr,
          description: '',
          asset: SVGAssetString.otherGender,
          enumValue: Gender.other),
    ],
    Question(
        propertyLink: PropertyLink.userDateOfBirth,
        title: 'Ngày sinh'.tr,
        description:
            'Việc thu thập thông tin này sẽ giúp tôi có thể tính toán BMI và tạo ra một kế hoạch cân nặng lành mạnh cá nhân cho riêng bạn.'
                .tr,
        moduleParent: 0,
        moduleIndex: 4,
        layoutType: QuestionLayoutType.datePicker): [],
    Question(
        propertyLink: PropertyLink.userWeight,
        title: 'Cân nặng hiện tại'.tr,
        description:
            'Việc thu thập thông tin này sẽ giúp tôi có thể tính toán BMI và tạo ra một kế hoạch cân nặng lành mạnh cá nhân cho riêng bạn.'
                .tr,
        moduleParent: 0,
        moduleIndex: 5,
        layoutType: QuestionLayoutType.measurementPicker): [],
    Question(
        propertyLink: PropertyLink.userHeight,
        title: 'Chiều cao hiện tại'.tr,
        description:
            'Việc thu thập thông tin này sẽ giúp tôi có thể tính toán BMI và tạo ra một kế hoạch cân nặng lành mạnh cá nhân cho riêng bạn.'
                .tr,
        moduleParent: 0,
        moduleIndex: 6,
        layoutType: QuestionLayoutType.measurementPicker): [],
    Question(
        title: 'Mục tiêu chính'.tr,
        propertyLink: PropertyLink.userMainGoal,
        description:
            'Bạn hãy chọn một lựa chọn phù hợp nhất trong những lựa chọn bên dưới.'
                .tr,
        moduleParent: 0,
        moduleIndex: 7,
        layoutType: QuestionLayoutType.singleChoiceOneColumn): [
      Answer(
          title: 'Giảm cân, giảm mỡ'.tr,
          description:
              'Đốt mỡ một cách hợp lý để không làm mất kích cỡ và sức mạnh của cơ bắp'
                  .tr,
          asset: null,
          enumValue: MainGoal.loseWeight),
      Answer(
          title: 'Tăng cơ bắp'.tr,
          description: 'Xây dựng cơ bắp to khỏe, săn chắc, chất lượng'.tr,
          asset: null,
          enumValue: MainGoal.buildMuscle),
      Answer(
          title: 'Có vóc dáng đẹp, vừa vặn'.tr,
          description: 'Giữ vóc dáng vừa vặn, tăng cường sức bền của cơ thể'.tr,
          asset: null,
          enumValue: MainGoal.getFit),
      Answer(
          title: 'Tăng sức mạnh'.tr,
          description: 'Trở nên mạnh mẽ hơn về thể chất, sức mạnh'.tr,
          asset: null,
          enumValue: MainGoal.gainStrength),
    ],
    Question(
        canBeSkipped: true,
        title: 'Các vấn đề đặc biệt'.tr,
        propertyLink: PropertyLink.userLimit,
        description: '',
        moduleParent: 0,
        moduleIndex: 8,
        layoutType: QuestionLayoutType.multipleChoiceOneColumn): [
      Answer(
          title: 'Có vấn đề về khớp gối'.tr,
          description: '',
          asset: null,
          enumValue: PhyscialLimitaion.kneePain),
      Answer(
          title: 'Có vấn đề về lưng'.tr,
          description: '',
          asset: null,
          enumValue: PhyscialLimitaion.backPain),
      Answer(
          title: 'Khả năng di chuyển hạn chế'.tr,
          description: '',
          asset: null,
          enumValue: PhyscialLimitaion.limitedMobility),
    ],
    Question(
        title: 'Kiểu cơ thể'.tr,
        propertyLink: PropertyLink.userBodyType,
        description: 'Hình ảnh nào dưới đây gần giống với bạn nhất?'.tr,
        moduleParent: 0,
        moduleIndex: 9,
        layoutType: QuestionLayoutType.singleChoiceOneColumn): [
      Answer(
          title: 'Endomorph'.tr,
          description: '',
          asset: null,
          enumValue: BodyType.endomorph),
      Answer(
          title: 'Mesomorph'.tr,
          description: '',
          asset: null,
          enumValue: BodyType.mesomorph),
      Answer(
          title: 'Ectomorph'.tr,
          description: '',
          asset: null,
          enumValue: BodyType.ectomorph),
    ],
    Question(
        canBeSkipped: true,
        title: 'Sở thích'.tr,
        propertyLink: PropertyLink.userHobby,
        description: '',
        moduleParent: 0,
        moduleIndex: 10,
        layoutType: QuestionLayoutType.multipleChoiceOneColumn): [
      Answer(
          title: 'Tập luyện tại nhà'.tr,
          description: '',
          asset: null,
          enumValue: Hobby.homeWorkOut),
      Answer(
          title: 'Đi bộ'.tr,
          description: '',
          asset: null,
          enumValue: Hobby.walking),
      Answer(
          title: 'Chạy bộ'.tr,
          description: '',
          asset: null,
          enumValue: Hobby.running),
      Answer(
          title: 'Yoga'.tr,
          description: '',
          asset: null,
          enumValue: Hobby.yoga),
      Answer(
          title: 'Nhảy'.tr,
          description: '',
          asset: null,
          enumValue: Hobby.dancing),
      Answer(
          title: 'Gym'.tr, description: '', asset: null, enumValue: Hobby.gym),
      Answer(
          title: 'Đánh nhau'.tr,
          description: '',
          asset: null,
          enumValue: Hobby.fighting),
    ],
    Question(
        title: 'Kinh nghiệm'.tr,
        propertyLink: PropertyLink.userExp,
        description: '',
        moduleParent: 0,
        moduleIndex: 11,
        layoutType: QuestionLayoutType.singleChoiceOneColumn): [
      Answer(
          title: 'Mới bắt đầu'.tr,
          description: '',
          asset: null,
          enumValue: Experience.beginner),
      Answer(
          title: 'Có kinh nghiệm'.tr,
          description: '',
          asset: null,
          enumValue: Experience.intermediate),
      Answer(
          title: 'Chuyên nghiệp'.tr,
          description: '',
          asset: null,
          enumValue: Experience.advanced),
    ],

    // Module 2
    Question(
        title: 'Kiểu ngày bình thường của bạn?'.tr,
        propertyLink: PropertyLink.userTypicalDay,
        description:
            'Để có thể đạt được mục tiêu về vóc dáng cơ thể thì mỗi cá nhân đều có một hướng tiếp cận riêng dựa trên thói quen của chính mình.'
                .tr,
        moduleParent: 1,
        moduleIndex: 1,
        layoutType: QuestionLayoutType.singleChoiceOneColumn): [
      Answer(
          title: 'Công việc văn phòng'.tr,
          description: '',
          asset: null,
          enumValue: TypicalDay.office),
      Answer(
          title: 'Đi bộ mỗi ngày'.tr,
          description: '',
          asset: null,
          enumValue: TypicalDay.walkingDaily),
      Answer(
          title: 'Hầu như chỉ ở nhà'.tr,
          description: '',
          asset: null,
          enumValue: TypicalDay.mostlyAtHome),
      Answer(
          title: 'Vận động tay chân'.tr,
          description: '',
          asset: null,
          enumValue: TypicalDay.workPhysically),
    ],
    Question(
        title: 'Bạn thường vận động như thế nào?'.tr,
        description:
            'Bạn dành ra bao nhiêu buổi vào mỗi tuần cho việc tập luyện?'.tr,
        moduleParent: 1,
        propertyLink: PropertyLink.userActiveFrequency,
        moduleIndex: 2,
        layoutType: QuestionLayoutType.singleChoiceOneColumn): [
      Answer(
          title: 'Không nhiều'.tr,
          description: '',
          asset: null,
          enumValue: ActiveFrequency.notMuch),
      Answer(
          title: 'Ít'.tr,
          description: 'Từ 1 đến 2 buổi trong một tuần'.tr,
          asset: null,
          enumValue: ActiveFrequency.few),
      Answer(
          title: 'Trung bình'.tr,
          description: 'Từ 3 đến 5 buổi trong một tuần'.tr,
          asset: null,
          enumValue: ActiveFrequency.average),
      Answer(
          title: 'Nhiều'.tr,
          description: 'Từ 6 đến 7 buổi trong một tuần'.tr,
          asset: null,
          enumValue: ActiveFrequency.much),
    ],
    Question(
        title: 'Mỗi đêm bạn dành ra bao nhiêu thời gian để ngủ?'.tr,
        description:
            'Việc ngủ đủ giấc là rất cần thiết trong việc hình thành nên vóc dáng cơ thể đẹp.'
                .tr,
        moduleParent: 1,
        propertyLink: PropertyLink.userSleepTime,
        moduleIndex: 3,
        layoutType: QuestionLayoutType.singleChoiceOneColumn): [
      Answer(
          title: 'Không nhiều'.tr,
          description: '',
          asset: null,
          enumValue: SleepTime.notMuch),
      Answer(
          title: 'Ít'.tr,
          description: 'Từ 3 đến 6 giờ'.tr,
          asset: null,
          enumValue: SleepTime.few),
      Answer(
          title: 'Trung bình'.tr,
          description: 'Từ 7 đến 8 giờ'.tr,
          asset: null,
          enumValue: SleepTime.average),
      Answer(
          title: 'Nhiều'.tr,
          description: 'Trên 8 giờ'.tr,
          asset: null,
          enumValue: SleepTime.much),
    ],
    Question(
        canBeSkipped: true,
        title: 'Thói quen xấu'.tr,
        propertyLink: PropertyLink.userBadHabit,
        description: '',
        moduleParent: 1,
        moduleIndex: 4,
        layoutType: QuestionLayoutType.singleChoiceOneColumn): [
      Answer(
          title: 'Không nghỉ ngơi đủ'.tr,
          description: '',
          asset: null,
          enumValue: BadHabit.notRestMuch),
      Answer(
          title: 'Ăn nhiều đồ ngọt'.tr,
          description: '',
          asset: null,
          enumValue: BadHabit.drinkSoftDrink),
      Answer(
          title: 'Uống nhiều nước ngọt'.tr,
          description: '',
          asset: null,
          enumValue: BadHabit.eatManySweets),
      Answer(
          title: 'Ăn đồ mặn'.tr,
          description: '',
          asset: null,
          enumValue: BadHabit.eatSalty),
      Answer(
          title: 'Ăn vặt'.tr,
          description: '',
          asset: null,
          enumValue: BadHabit.eatSnackLate),
      Answer(
          title: 'Uống rượu bia nhiều'.tr,
          description: '',
          asset: null,
          enumValue: BadHabit.drinkMuchBeer),
    ],

    // Module 3
    Question(
        title: 'Chế độ ăn kiêng của bạn'.tr,
        description:
            'Hãy chọn theo thói quen hằng ngày hoặc sở thích của bạn.'.tr,
        moduleParent: 2,
        propertyLink: PropertyLink.userDiet,
        moduleIndex: 1,
        layoutType: QuestionLayoutType.singleChoiceOneColumn): [
      Answer(
          title: 'Truyền thống'.tr,
          description: '',
          asset: null,
          enumValue: Diet.traditional),
      Answer(
          title: 'Ăn nửa chay'.tr,
          description: '',
          asset: null,
          enumValue: Diet.vegetarian),
      Answer(
          title: 'Keto'.tr, description: '', asset: null, enumValue: Diet.keto),
      Answer(
          title: 'Ăn thuần chay'.tr,
          description: '',
          asset: null,
          enumValue: Diet.vegan),
      Answer(
          title: 'Keto chay'.tr,
          description: '',
          asset: null,
          enumValue: Diet.ketoVegan),
      Answer(
          title: 'Pescatarian'.tr,
          description: '',
          asset: null,
          enumValue: Diet.pescatarian),
      Answer(
          title: 'Không Lactose'.tr,
          description: '',
          asset: null,
          enumValue: Diet.lactoseFree),
      Answer(
          title: 'Không Gluten'.tr,
          description: '',
          asset: null,
          enumValue: Diet.glutenFree),
      Answer(
          title: 'Paleo'.tr,
          description: '',
          asset: null,
          enumValue: Diet.paleo),
      Answer(
          title: 'Mediterranean'.tr,
          description: '',
          asset: null,
          enumValue: Diet.mediterranean),
      Answer(
          title: 'Tiểu đường loại một'.tr,
          description: '',
          asset: null,
          enumValue: Diet.diabetsTypeOne),
      Answer(
          title: 'Tiểu đường loại hai'.tr,
          description: '',
          asset: null,
          enumValue: Diet.diabetsTypeTwo),
      Answer(
          title: 'Theo dịp lễ'.tr,
          description: '',
          asset: null,
          enumValue: Diet.holiday),
    ],
    Question(
        title: 'Nguồn chất đạm'.tr,
        propertyLink: PropertyLink.userProteinSource,
        description:
            'Hãy chọn theo thói quen hằng ngày hoặc sở thích của bạn.'.tr,
        moduleParent: 2,
        moduleIndex: 2,
        layoutType: QuestionLayoutType.singleChoiceOneColumn): [
      Answer(
          title: 'Ức gà'.tr,
          description: '',
          asset: null,
          enumValue: ProteinSource.chickenBreast),
      Answer(
          title: 'Trứng gà'.tr,
          description: '',
          asset: null,
          enumValue: ProteinSource.egg),
      Answer(
          title: 'Sữa chua'.tr,
          description: '',
          asset: null,
          enumValue: ProteinSource.yogurt),
      Answer(
          title: 'Phô mai tươi'.tr,
          description: '',
          asset: null,
          enumValue: ProteinSource.cottageCheese),
      Answer(
          title: 'Đậu hũ'.tr,
          description: '',
          asset: null,
          enumValue: ProteinSource.tofu),
      Answer(
          title: 'Dầu Ô-liu'.tr,
          description: '',
          asset: null,
          enumValue: ProteinSource.olives),
      Answer(
          title: 'Quả hạch'.tr,
          description: '',
          asset: null,
          enumValue: ProteinSource.nuts),
      Answer(
          title: 'Bơ đậu phộng'.tr,
          description: '',
          asset: null,
          enumValue: ProteinSource.peanutButter),
    ],
    Question(
        title: 'Mỗi ngày bạn uống khoảng bao nhiêu nước?'.tr,
        propertyLink: PropertyLink.userDailyWater,
        description: '',
        moduleParent: 2,
        moduleIndex: 3,
        layoutType: QuestionLayoutType.singleChoiceOneColumn): [
      Answer(
          title: 'Không nhiều'.tr,
          description: '',
          asset: null,
          enumValue: DailyWater.notMuch),
      Answer(
          title: 'Ít'.tr,
          description: 'Từ 1 đến 2 ly nước'.tr,
          asset: null,
          enumValue: DailyWater.few),
      Answer(
          title: 'Trung bình'.tr,
          description: 'Từ 3 đến 6 ly nước'.tr,
          asset: null,
          enumValue: DailyWater.average),
      Answer(
          title: 'Nhiều'.tr,
          description: 'Trên 6 ly nước'.tr,
          asset: null,
          enumValue: DailyWater.much),
    ],
  };
}

class AppValue {
  static const userCollectionPath = 'user';
}
