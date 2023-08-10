part of 'widgets.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    required this.onChanged,
    required this.onCancel,
  });

  final void Function(String) onChanged;
  final void Function() onCancel;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Container(
          color: const Color.fromARGB(255, 219, 219, 219),
          child: TextField(
            controller: controller,
            autocorrect: false,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              prefixIconColor: const Color.fromARGB(255, 32, 32, 32),
              prefixIcon: const Icon(Icons.search),
              suffixIcon: GestureDetector(
                onTap: () {
                  controller.text = '';
                  widget.onCancel();
                },
                child: const Icon(
                  Icons.cancel_rounded,
                  color: Color.fromARGB(255, 129, 9, 0),
                ),
              ),
              border: InputBorder.none,
              hintText: 'Busca por nombre...',
            ),
          ),
        ),
      ),
    );
  }
}
