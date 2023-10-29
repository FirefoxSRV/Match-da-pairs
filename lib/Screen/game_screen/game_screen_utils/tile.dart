
import 'package:flutter/material.dart';

import '../../../Logic/functions_objects.dart';
import '../game_screen.dart';

class Tile extends StatefulWidget {
  String pathToImage;
  int tileIndex;
  GameScreenState state;

  Tile({super.key, required this.pathToImage, required this.tileIndex, required this.state});

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  bool _isClickable = true;

  void _onTileTap() async {
    if (!_isClickable || loadSelect) return;
    if (selectedTileIndex == widget.tileIndex) return;
    _isClickable = false;
    if (!loadSelect) {
      if (selectedImagePath != "") {
        if (selectedImagePath == itemDuos[widget.tileIndex].getImagePath()) {
          tries = tries + 1;
          playCorrectSound();
          print("Correct");
          loadSelect = true;
          Future.delayed(const Duration(seconds: 1), () {
            if (!mounted) return;
            points = points + 1;
            setState(() {});
            loadSelect = false;
            widget.state.setState(() {
              itemDuos[selectedTileIndex].setImagePath("");
              itemDuos[widget.tileIndex].setImagePath("");
            });
            selectedImagePath = "";
            _isClickable = true;
          });
        } else {
          playWrongSound();
          tries = tries + 1;
          print("Ni");
          loadSelect = true;
          Future.delayed(const Duration(seconds: 2), () {
            loadSelect = false;
            widget.state.setState(() {
              itemDuos[widget.tileIndex].setIsSelected(false);
              itemDuos[selectedTileIndex].setIsSelected(false);
            });

            selectedImagePath = "";
            selectedTileIndex = -1;
            _isClickable = true;
          });
        }
      } else {
        print("1 select");
        selectedTileIndex = widget.tileIndex;
        selectedImagePath = itemDuos[widget.tileIndex].getImagePath();
      }
      setState(() {
        itemDuos[widget.tileIndex].setIsSelected(true);
      });
      _isClickable = true;
    }

    await Future.delayed(const Duration(seconds: 1));
    _isClickable = true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTileTap,
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Theme.of(context).colorScheme.tertiary), borderRadius: BorderRadius.circular(50)),
        margin: const EdgeInsets.all(15),
        child: ClipOval(
          child: AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: itemDuos[widget.tileIndex].getImagePath() != ""
                ? Image.asset(itemDuos[widget.tileIndex].getSelected() ? itemDuos[widget.tileIndex].getImagePath() : widget.pathToImage)
                : Icon(
              Icons.check,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ),
      ),
    );
  }
}