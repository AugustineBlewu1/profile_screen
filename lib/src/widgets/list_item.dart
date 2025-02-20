
import '../utils/export.dart';


//Widget Component for ProfileList Item
class ListItem extends StatefulWidget {
  const ListItem({super.key, this.svgAsset, this.name, this.isLogout = false, this.trailing, this.onTap });
  final String? svgAsset;
  final String? name;
  final bool? isLogout;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset("assets/svg/${widget.svgAsset!}"),
      title: Text(widget.name!, style:  widget.isLogout! ?  TextStyle(color: Colors.redAccent) : TextStyle(color: neutralStrong) ),
      trailing: widget.trailing,
      onTap: widget.onTap,
       
    );
  }
}
