import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mem_game/main.dart';

import '../../Logic/functions_objects.dart';


void playCorrectSound() async {
  final player = AudioPlayer();
  const soundPath = "audio/success.mp3";
  await player.play(AssetSource(soundPath),volume: 0.5);
}

void playWrongSound() async {
  final player = AudioPlayer();
  const soundPath = "audio/wrong.mp3";
  await player.play(AssetSource(soundPath));
}


class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool _isMounted = false;
  bool _showPoints = false;

  void _resetGameState() {
    _isMounted = true;
    loadSelect = true;
    itemDuos = getPairs();
    itemDuos.shuffle();
    hiddenDuos = itemDuos;
    selectedTileIndex = -1; // Reset selectedTileIndex to an invalid value
    selectedImagePath = ""; // Reset selectedImagePath
    points = 0;
    Future.delayed(const Duration(seconds: 5), () {
      _showPoints = true;
      if (!_isMounted) return;
      if(_isMounted){
        setState(() {
          hiddenDuos = getQuestions();
          loadSelect = false;
        });
      }
    });
  }

  @override
  void initState() {
    _resetGameState();
    super.initState();

  }

  @override
  void dispose() {
    _isMounted = false;
    loadSelect = false;
    super.dispose();
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
              _showPoints?"$points/8":"Memorize",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            if (_showPoints)...[
              Text("Points"),
            ] else ...[
              Text(" "),
            ],

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
                : GameCompleteScreen()
          ],
        ),
      ),
    );
  }
}




class GameCompleteScreen extends StatelessWidget {
  const GameCompleteScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    points = 0;
    return Center(
              child: Container(
    padding: EdgeInsets.symmetric(vertical: 12,horizontal: 24),
    decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(25)),
    child: MaterialButton(
      onPressed: (){
        Navigator.pop(context);
      },
      child: Text(
        "Go Home",
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black),
      ),
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

  bool _isClickable = true;

  void _onTileTap() async {
    if (!_isClickable || loadSelect ) return;
    // _isClickable = false;
    if (selectedTileIndex == widget.tileIndex) return;
    _isClickable = false;
    if (!loadSelect) {
      if (selectedImagePath != "") {
        if (selectedImagePath == itemDuos[widget.tileIndex].getImagePath()) {
          playCorrectSound();
          print("Correct");
          loadSelect = true;
          Future.delayed(Duration(seconds: 1), () {
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
          print("Ni");
          loadSelect = true;
          Future.delayed(Duration(seconds: 2), () {
            loadSelect = false;
            widget.state.setState(() {
              itemDuos[widget.tileIndex].setIsSelected(false);
              itemDuos[selectedTileIndex].setIsSelected(false);
            });

            selectedImagePath = "";
            selectedTileIndex = -1;
            _isClickable= true;

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

    await Future.delayed(Duration(seconds: 1));
    _isClickable = true;
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTileTap,
      child: Container(
        decoration: BoxDecoration(border:Border.all(color: Theme.of(context).colorScheme.tertiary),borderRadius: BorderRadius.circular(50)),
        margin: EdgeInsets.all(15),
        child: ClipOval(
          child: AnimatedSwitcher(
            duration: Duration(seconds: 1),
            child: itemDuos[widget.tileIndex].getImagePath() != ""
                ? Image.asset(itemDuos[widget.tileIndex].getSelected() ? itemDuos[widget.tileIndex].getImagePath() : widget.pathToImage)
                : Icon(Icons.check,color: Theme.of(context).colorScheme.tertiary,),
          ),
        ),
      ),
    );
  }
}
