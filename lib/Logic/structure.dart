class TileModel{
  String pathToImage;
  bool selected;

  TileModel({required this.pathToImage,required this.selected});

  void setImagePath(String imageAssetPath){
    pathToImage = imageAssetPath;
  }

  void setIsSelected(bool isSelected){
    selected = isSelected;
  }

  String getImagePath(){
    return pathToImage;
  }

  bool getSelected(){
    return selected;
  }
}