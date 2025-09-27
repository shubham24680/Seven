import 'package:seven/app/app.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int initialIndex = 5;
  final List<List<String>> detail = [
    ["Username", "Shubham Patel"],
    ["Phone number", "+91 7764074475"],
    ["Date of birth", "11 July 2001"],
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomText(text: "Profile"),
          CustomButton(
            buttonType: ButtonType.ELEVATED,
            child: const CustomText(
              text: "Choose your avatar",
              weight: FontWeight.w900,
            ),
            onPressed: () => context.push("/chooseYourAvatar"),
          ),
        ],
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
