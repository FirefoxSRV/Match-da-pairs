import 'package:flutter/material.dart';
import 'package:mem_game/data/data.dart';

import 'model/tile_model.dart';

void main() {
  runApp(MaterialApp(home: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    loadSelect = true;
    pairs = getPairs();
    pairs.shuffle();
    visiblePairs = pairs;
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        visiblePairs = getQuestions();
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
              "$points/800",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            Text("Points"),
            SizedBox(
              height: 20,
            ),
            points != 800
                ? GridView(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(mainAxisSpacing: 0.0, maxCrossAxisExtent: 100),
                    children: List.generate(visiblePairs.length, (index) {
                      return ItemContainers(
                        state: this,
                        pathToImage: visiblePairs[index].getImagePath(),
                        tileIndex: index,
                      );
                    }),
                  )
                : Container(
                    padding: EdgeInsets.symmetric(vertical: 12,horizontal: 24),
                    decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(25)),
                    child: Text(
                      "Replay",
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black),
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
  _MyAppState state;

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
            if (selectedImagePath == pairs[widget.tileIndex].getImagePath()) {
              print("Correct");
              loadSelect = true;
              Future.delayed(Duration(seconds: 2), () {
                points = points + 100;
                setState(() {});
                loadSelect = false;
                widget.state.setState(() {
                  pairs[selectedTileIndex].setImagePath("");
                  pairs[widget.tileIndex].setImagePath("");
                });
                selectedImagePath = "";
              });
            } else {
              print("Wrong");
              loadSelect = true;
              Future.delayed(Duration(seconds: 2), () {
                loadSelect = false;
                widget.state.setState(() {
                  pairs[widget.tileIndex].setIsSelected(false);
                  pairs[selectedTileIndex].setIsSelected(false);
                });

                selectedImagePath = "";
              });
            }
          } else {
            selectedTileIndex = widget.tileIndex;
            selectedImagePath = pairs[widget.tileIndex].getImagePath();
          }
          setState(() {
            pairs[widget.tileIndex].setIsSelected(true);
          });
        }
      },
      child: Container(
        margin: EdgeInsets.all(15),
        child: pairs[widget.tileIndex].getImagePath() != ""
            ? Image.asset(pairs[widget.tileIndex].getSelected() ? pairs[widget.tileIndex].getImagePath() : widget.pathToImage)
            : Image.asset("assets/images/white.png"),
      ),
    );
  }
}
