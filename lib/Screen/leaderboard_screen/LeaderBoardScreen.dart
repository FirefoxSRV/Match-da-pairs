import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({super.key});

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

final databaseReference = FirebaseDatabase.instance.ref("Players");

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {

  Query dbRef  = FirebaseDatabase.instance.ref().child('Players').orderByChild("points");

  List<Map> players = [];
  bool _isLoading = true;

  void fetchPlayers() {
    dbRef.once().then((DatabaseEvent event) {
      if (event.snapshot.exists) {
        Map<dynamic, dynamic> values = event.snapshot.value as Map<dynamic, dynamic>;
        players = values.entries.map((e) => {"key": e.key, ...e.value}).toList();
        setState(() {
          players.sort((a, b) => int.parse(b['points']).compareTo(int.parse(a['points'])));
          _isLoading = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchPlayers();
  }

  Widget playerContainer({required Map player, required int rank}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.primary,
            ),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Table(
              columnWidths: const {
                0: FixedColumnWidth(50),
                1: FixedColumnWidth(100),
                2: FlexColumnWidth(),
                3: FixedColumnWidth(100)
              },
              children: [
                TableRow(
                  children: [
                    Center(child: Text(rank.toString(), style: GoogleFonts.quicksand(color: Theme.of(context).colorScheme.secondary,fontSize: 25))),
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                        child: Image.network(
                          player['displayUrl'].toString(),

                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                            return Icon(Icons.account_circle);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(player['displayName'].toString(), style: GoogleFonts.quicksand(color: Theme.of(context).colorScheme.secondary,fontSize: 17)),
                    ),
                    Center(child: Text(player['points'].toString(), style: GoogleFonts.quicksand(color: Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.w700,fontSize: 20))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }


  @override
    Widget build(BuildContext context) {
      return LayoutBuilder(
        builder: (context,constraints) {
          double height = constraints.maxHeight;
          double width = constraints.maxWidth;
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor:Theme.of(context).scaffoldBackgroundColor ,
              title: Text("Leaderboard",style: GoogleFonts.quicksand(fontWeight: FontWeight.bold,fontSize: 32,color: Theme.of(context).colorScheme.tertiary),),
            ),
            body: _isLoading?Center(child: CircularProgressIndicator(),):Column(
              children: [
                SizedBox(height: 10,),
                Flexible(
                  child: ListView.builder(
                    itemCount: players.length,
                    itemBuilder: (BuildContext context, int index) {
                      return playerContainer(player: players[index], rank: index + 1);
                    },
                  ),
                )
              ],
            ),
          );
        }
      );
    }
  }


