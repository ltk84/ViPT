import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';

class BodyStatusScreen extends StatefulWidget {
  const BodyStatusScreen({Key? key}) : super(key: key);

  @override
  State<BodyStatusScreen> createState() => _BodyStatusScreenState();
}

class _BodyStatusScreenState extends State<BodyStatusScreen> {
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();
  final CarouselController _carouselController = CarouselController();

  @override
  void initState() {
    _currentPageIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> bodyStatusList = [
      {
        'name': 'Đường huyết tăng'.tr,
        'asset': SVGAssetString.bloodSugarRises,
        'selectedAsset': SVGAssetString.selectedBloodSugarRises,
        'content':
            'Nhịn ăn theo nhịp sinh học là một cách tuyệt vời để dễ dàng nhịn ăn. Nó phù hợp với sự trao đổi chất tự nhiên của cơ thể, vì vậy bạn chỉ ăn khi ở trạng thái đầy đủ. Nhịn ăn có thể giúp giảm cân và thậm chí ngăn ngừa loại bệnh.'
                .tr,
        'duration': '0h - 4h',
      },
      {
        'name': 'Đường huyết giảm'.tr,
        'asset': SVGAssetString.bloodSugarFalls,
        'selectedAsset': SVGAssetString.selectedBloodSugarFalls,
        'content':
            'Lượng đường trong máu của bạn tiếp tục giảm khi cơ thể bắt đầu đốt cháy chất béo để lấy năng lượng.'
                .tr,
        'duration': '4h - 8h',
      },
      {
        'name': 'Đường huyết ổn định'.tr,
        'asset': SVGAssetString.bloodSugarStabilizes,
        'selectedAsset': SVGAssetString.selectedBloodSugarStabilizes,
        'content':
            'Lượng đường trong máu của bạn đang ở mức thấp nhất, điều này báo cho cơ thể bạn chuyển sang chất béo để lấy năng lượng.'
                .tr,
        'duration': '8h - 12h',
      },
      {
        'name': 'Ketosis'.tr,
        'asset': SVGAssetString.ketosis,
        'selectedAsset': SVGAssetString.selectedKetosis,
        'content':
            'Sau 8-12 giờ, glucose trong máu trở nên khan hiếm. Tại thời điểm này, cơ thể bạn bắt đầu đốt cháy các axit béo.\n\nĐiều này dẫn đến việc sản xuất xeton, một hợp chất hữu cơ dễ cháy. Khi bạn đang trong tình trạng ketosis, cơ thể bạn đang đốt cháy chất béo.\n\nTại thời điểm này, gan của bạn sản xuất xeton đốt cháy chất béo thay vì carbohydrate để làm nhiên liệu. Điều này làm giảm mức insulin, khiến cơ thể bạn đốt cháy nhiều chất béo hơn để làm nhiên liệu.'
                .tr,
        'duration': '12h - 14h',
      },
      {
        'name': 'Trao đổi chất'.tr,
        'asset': SVGAssetString.metabolism,
        'selectedAsset': SVGAssetString.selectedMetabolism,
        'content':
            'Thời gian nhịn ăn lâu hơn cho phép bạn đốt cháy nhiều chất béo hơn. Trong giai đoạn này, cơ thể bạn đang sản xuất xeton với tốc độ nhanh chóng vì không có glucose trong hệ thống. Điều này giúp tăng cường trao đổi chất và giảm viêm.'
                .tr,
        'duration': '14h - 16h',
      },
      {
        'name': 'Tự thực bào'.tr,
        'asset': SVGAssetString.autophagy,
        'selectedAsset': SVGAssetString.selectedAutophagy,
        'content':
            'Sau 12 giờ nhịn ăn, autophagy bắt đầu hoạt động. Nó có nghĩa là \'tự ăn\', bởi vì các tế bào của bạn bắt đầu tiêu thụ các protein bị hư hỏng của chính chúng.\n\nNhịn ăn hơn 12 giờ có thể thúc đẩy hormone tăng trưởng lên đến 2.000 phần trăm. Điều này là do nhịn ăn giúp giải phóng một hợp chất khác gọi là IGFBP1.\n\nMức độ IGFBP1 cao hơn có nghĩa là tăng cơ tốt hơn, tăng cường chức năng nhận thức và bảo vệ chống lại tác động của lão hóa.'
                .tr,
        'duration': '16h+',
      },
    ];

    double bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight -
        kBottomNavigationBarHeight;

    return Scaffold(
      //extendBodyBehindAppBar: true,
      backgroundColor: AppColor.fastingBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          iconSize: 20,
          color: Theme.of(context).backgroundColor,
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColor.accentTextColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text(
          'Trạng thái cơ thể'.tr,
          style: Theme.of(context).textTheme.headline4!.copyWith(
                color: AppColor.accentTextColor,
              ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            CarouselSlider.builder(
              carouselController: _carouselController,
              itemCount: bodyStatusList.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                if (itemIndex == _currentPageIndex) {
                  return _buildBodyStatusAsset(
                      bodyStatusList[itemIndex]['selectedAsset']);
                } else {
                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () async {
                      await _carouselController.animateToPage(itemIndex,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear);
                      await _pageController.animateToPage(itemIndex,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear);
                    },
                    child: _buildBodyStatusAsset(
                        bodyStatusList[itemIndex]['asset']),
                  );
                }
              },
              options: CarouselOptions(
                scrollPhysics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                height: bodyHeight * 0.25,
                viewportFraction: 0.32,
                enableInfiniteScroll: false,
                initialPage: _currentPageIndex,
                onPageChanged: (index, reason) async {
                  await _pageController.animateToPage(index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear);
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
              ),
            ),
            SizedBox(
              height: bodyHeight * 0.7,
              child: PageView(
                controller: _pageController,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                onPageChanged: (index) async {
                  await _carouselController.animateToPage(index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear);
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                children: [
                  ...bodyStatusList.map((status) {
                    return _buildBodyStatusContent(
                      context,
                      status['name'],
                      status['content'],
                      status['duration'],
                    );
                  }).toList()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildBodyStatusAsset(String? asset) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: asset != null
          ? SvgPicture.asset(
              asset,
              width: 60,
              height: 60,
            )
          : Container(),
    );
  }

  _buildBodyStatusContent(
      context, String? name, String? content, String? duration) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
                decoration: BoxDecoration(
                    color: AppColor.fastingLightSecondaryBackgroundColor,
                    borderRadius: BorderRadius.circular(24)),
                child: Text(
                  duration ?? '',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        color: AppColor.fastingBackgroundColor,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 24,
              bottom: 16,
            ),
            child: Text(
              name ?? '',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: AppColor.accentTextColor.withOpacity(0.90),
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            content ?? '',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: AppColor.accentTextColor.withOpacity(0.80),
                ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
