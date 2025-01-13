
import 'package:flutter/material.dart';

import 'functions.dart';
import '../../../Logic/structure.dart';


class Tile extends StatefulWidget {
  final TileManager tileManager;
  final int tileIndex;

  Tile({super.key, required this.tileManager, required this.tileIndex});

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  void _onTileTap() {
    setState(() {
      widget.tileManager.onTilePress(widget.tileIndex, _updateUI);  // Trigger tile press in TileManager
    });
  }

  void _updateUI() {
    setState(() {});  // Trigger UI update when the tile state changes
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTileTap,
      child: ValueListenableBuilder<SelectState>(
        valueListenable: widget.tileManager.tiles[widget.tileIndex].selected,
        builder: (context, selectedState, _) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.tertiary),
              borderRadius: BorderRadius.circular(50),
            ),
            margin: const EdgeInsets.all(15),
            child: ClipOval(
              child: AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                child: selectedState == SelectState.notSelected
                    ? Image.asset(widget.tileManager.hiddenImgPath)  // Hidden image if not selected
                    : (selectedState == SelectState.selected
                    ? Image.asset(widget.tileManager.tiles[widget.tileIndex].pathToImage)
                    : Icon(Icons.check, color: Theme.of(context).colorScheme.tertiary)),
              ),
            ),
          );
        },
      ),
    );
  }
}

class TileManager {
  List<TileModel> tiles = List.generate(16, (index) => TileModel(tileIndex: index, pathToImage: ""));
  List<String> questions = List.generate(16, (index) => "");
  List<SelectState> tilesState = List.generate(16, (index) => SelectState.notSelected);
  int selectedTileIndex = -1;
  String hiddenImgPath = "assets/images/black.png";
  bool hideItems = false;
  bool resetting = false;
  Function? updateGameState;
  String mode = "easy";

  TileManager({this.updateGameState}) {
    selectedTileIndex = -1;
    generatePairs(mode);
  }

  void setMode(String mode){
    if(mode != this.mode) {
      this.mode = mode;
      generatePairs(mode);
    }
  }

  void pauseGame() {
    for (int i = 0; i < 16; i++) {
      tilesState[i] = tiles[i].selected.value;
    }
    for (int i = 0; i < 16; i++) {
      tiles[i].selected.value = SelectState.notSelected;
    }
    resetting = true;
  }
  void unPauseGame() {
    for (int i = 0; i < 16; i++) {
      tiles[i].selected.value = tilesState[i];
    }
    resetting = false;
  }

  void generatePairs(String mode){
    String folderPath = "assets/images/$mode";
    int name = 0;
    for (int i = 0; i < 8; i++) {
      name = i+97;
      String finalName = (mode=="hard") ? "bw_"+String.fromCharCode(name) : String.fromCharCode(name);
      questions[i] = "$folderPath/${finalName}.png";
      questions[i+8] = "$folderPath/${finalName}.png";
    }
    questions.shuffle();

    for (int i = 0; i < 16; i++) {
      tiles[i].pathToImage = questions[i];
      tiles[i].selected.value = SelectState.notSelected;
      tilesState[i] = SelectState.notSelected;
    }
  }

  void viewModeAll(bool show){
    for (int i = 0; i < 16; i++) {
      tiles[i].selected.value = show ? SelectState.selected : SelectState.notSelected;
      tilesState[i] = show ? SelectState.selected : SelectState.notSelected;
    }
  }

  void onTilePress(int index, Function updateUI) {
    if (resetting || tiles[index].selected.value != SelectState.notSelected) return;
    if (selectedTileIndex == -1 ) {
      selectedTileIndex = index;
      tiles[index].selected.value = SelectState.selected;
    }
    else {
      // if (selectedTileIndex == index) {
      //   selectedTileIndex = -1;
      //   tiles[index].selected = SelectState.notSelected;
      //   updateUIPrevious = () {};
      //   updateUI();
      //   return;
      // }
      int newPoints = 0;
      int newTries = 1;
      tiles[index].selected.value = SelectState.selected;
      updateUI();
      if (questions[selectedTileIndex] == questions[index]) {
        playCorrectSound();
        resetting = true;
        newPoints = 1;
        Future.delayed(const Duration(seconds: 1), () {
          tiles[selectedTileIndex].selected.value = SelectState.paired;
          tiles[index].selected.value = SelectState.paired;
          resetting = false;
          selectedTileIndex = -1;
        });
      } else {
        playWrongSound();
        resetting = true;
        Future.delayed(const Duration(seconds: 2), () {
          tiles[selectedTileIndex].selected.value = SelectState.notSelected;
          tiles[index].selected.value = SelectState.notSelected;
          resetting = false;
          selectedTileIndex = -1;
        });
      }
      updateGameState!(newPoints, newTries); // Execute if not null
    }
  }
}
