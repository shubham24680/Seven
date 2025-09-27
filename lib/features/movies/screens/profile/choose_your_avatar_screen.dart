import 'package:seven/app/app.dart';

class ChooseYourAvatarScreen extends StatefulWidget {
  const ChooseYourAvatarScreen({super.key});

  @override
  State<ChooseYourAvatarScreen> createState() => _ChooseYourAvatarScreenState();
}

class _ChooseYourAvatarScreenState extends State<ChooseYourAvatarScreen> {
  int initialIndex = 5;
  final List<List<String>> detail = [
    ["Username", "Shubham Patel"],
    ["Phone number", "+91 7764074475"],
    ["Date of birth", "11 July 2001"],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding:
              const EdgeInsets.symmetric(vertical: AppConstants.SIDE_PADDING),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                AppColors.transparent,
                AppColors.vividNightfall4.withAlpha(100)
              ])),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomImage(
                    imageType: ImageType.SVG_LOCAL,
                    imageUrl: AppSvgs.SEARCH,
                    color: AppColors.lightSteel1,
                    event: () => context.pop(),
                  ),
                  const CustomText(
                      text: "Choose your avatar",
                      family: AppFonts.STAATLICHES,
                      size: 36),
                  SizedBox(width: 0.07.sw)
                ],
              ).paddingSymmetric(horizontal: AppConstants.SIDE_PADDING),
              const Spacer(),
              CarouselSlider(
                  items: generateImage(),
                  options: CarouselOptions(
                      initialPage: initialIndex,
                      height: 0.25.sh,
                      viewportFraction: 0.55,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.8,
                      enableInfiniteScroll: false)),
              const Spacer(),
              ...List.generate(
                  detail.length,
                  (index) => Row(
                        children: [
                          CustomText(
                              text: detail[index][0],
                              size: 0.016.sh,
                              weight: FontWeight.w900,
                              color: AppColors.lightSteel1.withAlpha(150)),
                          const Spacer(),
                          CustomText(
                              text: detail[index][1],
                              size: 0.016.sh,
                              weight: FontWeight.w900),
                          // SizedBox(width: 0.02.sw),
                          // const CustomImage(
                          //   imageType: ImageType.SVG_LOCAL,
                          //   imageUrl: AppSvgs.SAVE,
                          //   color: AppColors.lightSteel1,
                          // ),
                        ],
                      ).paddingSymmetric(
                          horizontal: AppConstants.SIDE_PADDING,
                          vertical: 0.01.sh)),
              // const Spacer(),
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: CustomText(
              //       text: "Avatar",
              //       size: 0.016.sh,
              //       weight: FontWeight.w900,
              //       color: AppColors.lightSteel1.withAlpha(150)),
              // ).paddingSymmetric(horizontal: AppConstants.SIDE_PADDING),
              // SizedBox(height: 0.02.sh),
              // CarouselSlider(
              //     items: generateImage(),
              //     options: CarouselOptions(
              //         onPageChanged: (index, reason) {
              //           setState(() {
              //             initialIndex = index;
              //           });
              //         },
              //         initialPage: initialIndex,
              //         height: 0.1.sh,
              //         viewportFraction: 0.25,
              //         padEnds: false,
              //         enableInfiniteScroll: false)),
              const Spacer(),
              CustomButton(
                onPressed: () {},
                buttonType: ButtonType.ELEVATED,
                backgroundColor: AppColors.lightSteel1.withAlpha(40),
                height: 0.065.sh,
                child: const CustomText(
                  text: "Edit",
                  weight: FontWeight.w900,
                ),
              ).paddingSymmetric(horizontal: AppConstants.SIDE_PADDING),
              SizedBox(height: 0.02.sh),
              CustomButton(
                onPressed: () {},
                buttonType: ButtonType.ELEVATED,
                backgroundColor: AppColors.vividNightfall4,
                height: 0.065.sh,
                child: const CustomText(
                  text: "Save",
                  weight: FontWeight.w900,
                ),
              ).paddingSymmetric(horizontal: AppConstants.SIDE_PADDING)
            ],
          ),
        ),
      ),
    );
  }

  generateImage() {
    return List.generate(
        AppAssets.AVATARS.length,
        (index) => CustomImage(
            imageType: ImageType.LOCAL,
            imageUrl: AppAssets.AVATARS[index],
            borderRadius: BorderRadius.circular(100)));
  }
}
