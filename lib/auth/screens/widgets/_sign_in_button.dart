part of '../auth_screen.dart';

// ---Texts---
const _kSignIn = 'Sign in';

// ---Parameters---
const _kSizeWidth = 200.0;
const _kSizeHeight = 40.0;
const _kRadius = 18.0;

class SignInButton extends StatelessWidget {
  const SignInButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(
          const Size(
            _kSizeWidth,
            _kSizeHeight,
          ),
        ),
        backgroundColor: MaterialStateProperty.all(Colors.white),
        side: MaterialStateProperty.all(
          const BorderSide(color: AppColors.darkBlue),
        ),
        shadowColor: MaterialStateProperty.all(AppColors.darkBlue),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(_kRadius)),
        ),
      ),
      child: Text(
        _kSignIn,
        style: context.theme.textTheme.bodyText1!.copyWith(
          fontSize: _kFontSizeTwo,
          color: AppColors.darkBlue,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
