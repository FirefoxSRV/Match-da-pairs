import '../model/tile_model.dart';
int points = 800;
bool loadSelect = false;
String selectedImagePath = "";
late int selectedTileIndex;


List<TileModel> pairs = [];
List<TileModel> visiblePairs = [];
List<TileModel> getPairs(){

  List<TileModel> pairs = [];
  TileModel tileModel1 = TileModel(pathToImage: "assets/images/1.png", selected: false);
  pairs.add(tileModel1);
  pairs.add(tileModel1);
  TileModel tileModel2 = TileModel(pathToImage: "assets/images/2.png", selected: false);
  pairs.add(tileModel2);
  pairs.add(tileModel2);
  TileModel tileModel3 = TileModel(pathToImage: "assets/images/3.png", selected: false);
  pairs.add(tileModel3);
  pairs.add(tileModel3);
  TileModel tileModel4 = TileModel(pathToImage: "assets/images/4.png", selected: false);
  pairs.add(tileModel4);
  pairs.add(tileModel4);
  TileModel tileModel5 = TileModel(pathToImage: "assets/images/5.png", selected: false);
  pairs.add(tileModel5);
  pairs.add(tileModel5);
  TileModel tileModel6 = TileModel(pathToImage: "assets/images/6.png", selected: false);
  pairs.add(tileModel6);
  pairs.add(tileModel6);
  TileModel tileModel7 = TileModel(pathToImage: "assets/images/7.png", selected: false);
  pairs.add(tileModel7);
  pairs.add(tileModel7);
  TileModel tileModel8 = TileModel(pathToImage: "assets/images/8.png", selected: false);
  pairs.add(tileModel8);
  pairs.add(tileModel8);


  return pairs;

}


List<TileModel> getQuestions(){

  List<TileModel> pairs = [];
  TileModel tileModel1 = TileModel(pathToImage: "assets/images/black.png", selected: false);
  pairs.add(tileModel1);
  pairs.add(tileModel1);
  TileModel tileModel2 = TileModel(pathToImage: "assets/images/black.png", selected: false);
  pairs.add(tileModel2);
  pairs.add(tileModel2);
  TileModel tileModel3 = TileModel(pathToImage: "assets/images/black.png", selected: false);
  pairs.add(tileModel3);
  pairs.add(tileModel3);
  TileModel tileModel4 = TileModel(pathToImage: "assets/images/black.png", selected: false);
  pairs.add(tileModel4);
  pairs.add(tileModel4);
  TileModel tileModel5 = TileModel(pathToImage: "assets/images/black.png", selected: false);
  pairs.add(tileModel5);
  pairs.add(tileModel5);
  TileModel tileModel6 = TileModel(pathToImage: "assets/images/black.png", selected: false);
  pairs.add(tileModel6);
  pairs.add(tileModel6);
  TileModel tileModel7 = TileModel(pathToImage: "assets/images/black.png", selected: false);
  pairs.add(tileModel7);
  pairs.add(tileModel7);
  TileModel tileModel8 = TileModel(pathToImage: "assets/images/black.png", selected: false);
  pairs.add(tileModel8);
  pairs.add(tileModel8);


  return pairs;

}
