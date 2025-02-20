
import '../utils/export.dart';

class Label extends StatelessWidget {
  const Label({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: label,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.w700),
          children: [TextSpan(text: " *", style: TextStyle(color: red))]),
    );
  }
}
