part of 'widgets.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    super.key,
    required this.onTap,
  });

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Row(
        children: [
          Icon(Icons.search, color: Colors.yellow),
          SizedBox(width: 8),
          Text(
            'Buscar una película...',
            style: TextStyle(
              color: Colors.yellow,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
