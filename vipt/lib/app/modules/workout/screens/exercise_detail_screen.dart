import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:video_player/video_player.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/workout.dart';
import 'package:vipt/app/data/models/workout_equipment.dart';
import 'package:vipt/app/data/providers/workout_equipment_provider.dart';
import 'package:vipt/app/data/services/cloud_storage_service.dart';
import 'package:vipt/app/data/services/data_service.dart';

class ExerciseDetail extends StatefulWidget {
  ExerciseDetail({Key? key}) : super(key: key);

  @override
  State<ExerciseDetail> createState() => _ExerciseDetailState();
}

class _ExerciseDetailState extends State<ExerciseDetail> {
  final Workout workout = Get.arguments;
  String categories = '';
  List<WorkoutEquipment> equipment = [];
  VideoPlayerController? _controller;
  String animationLink = '';

  @override
  void initState() {
    _getCategories();
    _initVideoController();
    _getMuscleFocusLink();
    _getEquipmentList();
    super.initState();
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller!.dispose();
    }
    super.dispose();
  }

  _getEquipmentList() async {
    for (var item in workout.equipmentIDs) {
      final element = await WorkoutEquipmentProvider().fetch(item);
      if (!equipment.contains(element)) {
        equipment.add(element);
      }
    }

    print(equipment.length);
  }

  void _initVideoController() async {
    var link = await _getAnimationLink();
    if (link == null) return;
    _controller = VideoPlayerController.network(link)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller!.setLooping(true);
          _controller!.play();
        });
      });
  }

  void _getCategories() {
    var list = workout.categoryIDs
        .map((e) => DataService.instance.workoutCateList
            .firstWhere((element) => element.id == e)
            .name)
        .toList();
    for (int i = 0; i < list.length; i++) {
      if (i == list.length - 1) {
        categories += list[i];
      } else {
        categories += list[i] + ',' + ' ';
      }
    }
  }

  Future<dynamic> _getAnimationLink() async {
    return workout.animation;
  }

  Future<dynamic> _getMuscleFocusLink() async {
    try {
      final result = await CloudStorageService.instance.storage
          .ref()
          .child(AppValue.workoutsStorageCollectionPath)
          .child(AppValue.workoutsMuscleFocusStorageCollectionPath)
          .child(workout.muscleFocusAsset)
          .getDownloadURL();

      return result;
    } on FirebaseException catch (_) {
      return null;
    }
  }

  Future<dynamic> _getEquipmentLink() async {
    try {
      if (equipment.isEmpty || equipment[0].imageLink.isEmpty) return null;
      final result = await CloudStorageService.instance.storage
          .ref()
          .child(AppValue.equipmentStorageCollectionPath)
          .child(equipment[0].imageLink)
          .getDownloadURL();

      return result;
    } on FirebaseException catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Hero(
            tag: 'leadingButtonAppBar',
            child: Icon(Icons.arrow_back_ios_new_rounded),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
      body: Container(
        padding: AppDecoration.screenPadding.copyWith(top: 8, bottom: 0),
        child: LayoutBuilder(builder: (context, constraints) {
          return ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  workout.name,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  categories,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: constraints.maxWidth,
                  ),
                  child: _buildMediaPlayer(),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 24,
                  bottom: 8,
                ),
                child: Text(
                  'Trang thiết bị/dụng cụ',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              // Hình ảnh Equipment, mô phỏng bằng muscle focus
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: constraints.maxWidth,
                      maxHeight: constraints.maxHeight * 0.25,
                    ),
                    child: equipment.isNotEmpty
                        ? _buildEquipmentList()
                        : Container()),
              ),
              // Tên Equipment.
              Text(
                "Thiết bị",
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 24,
                  bottom: 8,
                ),
                child: Text(
                  'Gợi ý',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Text(workout.hints, style: Theme.of(context).textTheme.bodyText1),
              Container(
                padding: const EdgeInsets.only(top: 24, bottom: 8),
                child: Text(
                  'Hít thở',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Text(workout.breathing,
                  style: Theme.of(context).textTheme.bodyText1),
              Container(
                padding: const EdgeInsets.only(top: 24, bottom: 8),
                child: Text(
                  'Nhóm cơ tập trung',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              _buildMuscleFocus(constraints),
              SizedBox(
                height: constraints.maxHeight * 0.03,
              )
            ],
          );
        }),
      ),
    );
  }

  Widget _buildMuscleFocus(constraints) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: constraints.maxWidth,
          maxHeight: constraints.maxHeight * 0.5,
        ),
        child: Image.network(
          workout.muscleFocusAsset,
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                color: AppColor.textColor.withOpacity(AppColor.subTextOpacity),
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEquipmentList() {
    // return FutureBuilder(
    //     future: _getEquipmentLink(),
    //     builder: (_, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.done &&
    //           snapshot.hasData) {
    //         return Image.network(
    //           snapshot.data as String,
    //           fit: BoxFit.cover,
    //           loadingBuilder: (BuildContext context, Widget child,
    //               ImageChunkEvent? loadingProgress) {
    //             if (loadingProgress == null) {
    //               return child;
    //             }
    //             return Center(
    //               child: CircularProgressIndicator(
    //                 color:
    //                     AppColor.textColor.withOpacity(AppColor.subTextOpacity),
    //                 value: loadingProgress.expectedTotalBytes != null
    //                     ? loadingProgress.cumulativeBytesLoaded /
    //                         loadingProgress.expectedTotalBytes!
    //                     : null,
    //               ),
    //             );
    //           },
    //         );
    //       }
    //       return Container();
    //     });

    return Image.network(
      equipment[0].imageLink,
      fit: BoxFit.cover,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            color: AppColor.textColor.withOpacity(AppColor.subTextOpacity),
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
  }

  Widget _buildMediaPlayer() {
    if (_controller == null) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColor.textFieldFill,
        ),
      );
    }
    return FittedBox(
      fit: BoxFit.contain,
      child: SizedBox(
          width: _controller!.value.size.width,
          height: _controller!.value.size.height,
          child: VideoPlayer(_controller as VideoPlayerController)),
    );
  }

  Widget _buildAsset(String asset) {
    if (p.extension(asset) == '.svg') {
      return SvgPicture.asset(asset);
    } else {
      return Image.asset(asset);
    }
  }
}
