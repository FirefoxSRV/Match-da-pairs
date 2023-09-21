import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Logic/functions_objects.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    loadSelect = true;
    itemDuos = getPairs();
    itemDuos.shuffle();
    hiddenDuos = itemDuos;
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        hiddenDuos = getQuestions();
        loadSelect = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              "$points/8",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            Text("Points"),
            SizedBox(
              height: 20,
            ),
            points != 8
                ? GridView(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(mainAxisSpacing: 0.0, maxCrossAxisExtent: 100),
              children: List.generate(hiddenDuos.length, (index) {
                return ItemContainers(
                  state: this,
                  pathToImage: hiddenDuos[index].getImagePath(),
                  tileIndex: index,
                );
              }),
            )
                : Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12,horizontal: 24),
                decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(25)),
                child: Text(
                  "Replay",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}





class ItemContainers extends StatefulWidget {
  late String pathToImage;
  late int tileIndex;
  _GameScreenState state;

  ItemContainers({super.key, required this.pathToImage, required this.tileIndex, required this.state});

  @override
  State<ItemContainers> createState() => _ItemContainersState();
}

class _ItemContainersState extends State<ItemContainers> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!loadSelect) {
          if (selectedImagePath != "") {
            if (selectedImagePath == itemDuos[widget.tileIndex].getImagePath()) {
              print("Correct");
              loadSelect = true;
              Future.delayed(Duration(seconds: 2), () {
                points = points + 1;
                setState(() {});
                loadSelect = false;
                widget.state.setState(() {
                  itemDuos[selectedTileIndex].setImagePath("");
                  itemDuos[widget.tileIndex].setImagePath("");
                });
                selectedImagePath = "";
              });
            } else {
              loadSelect = true;
              Future.delayed(Duration(seconds: 2), () {
                loadSelect = false;
                widget.state.setState(() {
                  itemDuos[widget.tileIndex].setIsSelected(false);
                  itemDuos[selectedTileIndex].setIsSelected(false);
                });

                selectedImagePath = "";
              });
            }
          } else {
            selectedTileIndex = widget.tileIndex;
            selectedImagePath = itemDuos[widget.tileIndex].getImagePath();
          }
          setState(() {
            itemDuos[widget.tileIndex].setIsSelected(true);
          });
        }
      },
      child: Container(
        margin: EdgeInsets.all(15),
        child: itemDuos[widget.tileIndex].getImagePath() != ""
            ? Image.asset(itemDuos[widget.tileIndex].getSelected() ? itemDuos[widget.tileIndex].getImagePath() : widget.pathToImage)
            : Image.asset("assets/images/white.png"),
      ),
    );
  }
}
