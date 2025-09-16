import 'dart:developer';
import 'dart:ui';
import 'package:seven/app/app.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key, this.onPressed, required this.child});

  final void Function()? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(8),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: ElevatedButton(
          onPressed: onPressed ?? () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: lightSteel1.withAlpha(20),
            minimumSize: const Size.fromHeight(56),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: lightSteel1.withAlpha(20),
              ),
              borderRadius: BorderRadiusGeometry.circular(8),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({super.key, required this.icon, this.onTap});

  final String icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return blurEffect(
        3,
        GestureDetector(
          onTap: onTap ??
              () {
                log("Default Icon button");
              },
          child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: black5.withAlpha(70),
                borderRadius: BorderRadius.circular(100),
              ),
              child: SvgPicture.asset(
                icon,
                height: 32,
                colorFilter: ColorFilter.mode(
                    lightSteel1.withAlpha(200), BlendMode.srcIn),
              )),
        ),
        borderRadius: BorderRadius.circular(100));
  }
}
