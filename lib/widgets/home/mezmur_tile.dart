import 'package:flutter/material.dart';
import '../../helper/helper.dart' show ColorPallet, screenWidth;

class MezmurTile extends StatefulWidget {
  String image;
  String title;
  String subtitle;
  bool isFavorite;
  int index;
  MezmurTile(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle,
      required this.isFavorite,
      required this.index});

  @override
  State<MezmurTile> createState() => _MezmurTileState();
}

class _MezmurTileState extends State<MezmurTile> with ColorPallet {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: screenWidth(context),
      height: 55,
      decoration: BoxDecoration(
          color: foregroundColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              blurRadius: 3,
              color: Colors.black26,
              blurStyle: BlurStyle.inner,
            )
          ]),
      child: ListTile(
        minVerticalPadding: 10,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        leading: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage(widget.image),
                fit: BoxFit.cover),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        title:
            Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
        subtitle: Text(
          widget.subtitle,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        dense: true,
        selected: true,
        splashColor: blurWhite,
        trailing: InkWell(
          onTap: () {
            setState(() {
              widget.isFavorite = !widget.isFavorite;
            });
          },
          child: Icon(
            widget.isFavorite ? Icons.favorite : Icons.favorite_outline,
            color: blurWhite.withOpacity(0.8),
            size: 24,
          ),
        ),
      ),
    );
  }
}
