part of 'widgets.dart';

class TitleText extends StatelessWidget {
  const TitleText({
    required this.text,
    this.iconLeft,
    this.iconRight,
    this.onTap,
    super.key,
  });

  final String text;
  final IconData? iconLeft;
  final IconData? iconRight;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            iconLeft,
            color: Colors.grey,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Icon(
            iconRight,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
