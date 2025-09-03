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
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: lightSteel1.withAlpha(20),
            fixedSize: const Size.fromHeight(56),
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
