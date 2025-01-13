import 'package:flutter/material.dart';

enum SelectState {notSelected, selected, paired}
enum Selected { easy, medium, hard }

class TileModel{
  int tileIndex;
  String pathToImage;
  ValueNotifier<SelectState> selected = ValueNotifier(SelectState.notSelected);

  TileModel({required this.tileIndex, required this.pathToImage});

  void setImagePath(String imageAssetPath){
    pathToImage = imageAssetPath;
  }

  void setIsSelected(SelectState selectState){
    selected.value = selectState;
  }

  String getImagePath(){
    return pathToImage;
  }

  SelectState getSelected(){
    return selected.value;
  }
}