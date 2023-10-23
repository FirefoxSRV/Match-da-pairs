import 'structure.dart';
int points = 0;
bool loadSelect = false;
String selectedImagePath = "";
late int selectedTileIndex;


List<TileModel> itemDuos = [];
List<TileModel> hiddenDuos = [];
List<TileModel> getPairs(){
  List<TileModel> pairs = [];
  TileModel tileModel1 = TileModel(pathToImage: "assets/images/a.png", selected: false);
  pairs.add(tileModel1);
  pairs.add(tileModel1);
  TileModel tileModel2 = TileModel(pathToImage: "assets/images/b.png", selected: false);
  pairs.add(tileModel2);
  pairs.add(tileModel2);
  TileModel tileModel3 = TileModel(pathToImage: "assets/images/c.png", selected: false);
  pairs.add(tileModel3);
  pairs.add(tileModel3);
  TileModel tileModel4 = TileModel(pathToImage: "assets/images/d.png", selected: false);
  pairs.add(tileModel4);
  pairs.add(tileModel4);
  TileModel tileModel5 = TileModel(pathToImage: "assets/images/e.png", selected: false);
  pairs.add(tileModel5);
  pairs.add(tileModel5);
  TileModel tileModel6 = TileModel(pathToImage: "assets/images/f.png", selected: false);
  pairs.add(tileModel6);
  pairs.add(tileModel6);
  TileModel tileModel7 = TileModel(pathToImage: "assets/images/g.png", selected: false);
  pairs.add(tileModel7);
  pairs.add(tileModel7);
  TileModel tileModel8 = TileModel(pathToImage: "assets/images/h.png", selected: false);
  pairs.add(tileModel8);
  pairs.add(tileModel8);


  return pairs;

}


List<TileModel> getQuestions(){

  List<TileModel> pairs = [];
  TileModel tileModel1 = TileModel(pathToImage: "assets/images/black.jpg", selected: false);
  pairs.add(tileModel1);
  pairs.add(tileModel1);
  TileModel tileModel2 = TileModel(pathToImage: "assets/images/black.jpg", selected: false);
  pairs.add(tileModel2);
  pairs.add(tileModel2);
  TileModel tileModel3 = TileModel(pathToImage: "assets/images/black.jpg", selected: false);
  pairs.add(tileModel3);
  pairs.add(tileModel3);
  TileModel tileModel4 = TileModel(pathToImage: "assets/images/black.jpg", selected: false);
  pairs.add(tileModel4);
  pairs.add(tileModel4);
  TileModel tileModel5 = TileModel(pathToImage: "assets/images/black.jpg", selected: false);
  pairs.add(tileModel5);
  pairs.add(tileModel5);
  TileModel tileModel6 = TileModel(pathToImage: "assets/images/black.jpg", selected: false);
  pairs.add(tileModel6);
  pairs.add(tileModel6);
  TileModel tileModel7 = TileModel(pathToImage: "assets/images/black.jpg", selected: false);
  pairs.add(tileModel7);
  pairs.add(tileModel7);
  TileModel tileModel8 = TileModel(pathToImage: "assets/images/black.jpg", selected: false);
  pairs.add(tileModel8);
  pairs.add(tileModel8);


  return pairs;

}
