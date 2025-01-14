import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'leaderboard_screen_utils/player_container_tile.dart';


class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({super.key});

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

final databaseReference = FirebaseDatabase.instance.ref("Leaderboard");

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {

  Query dbRef  = FirebaseDatabase.instance.ref().child('Leaderboard').orderByChild("points");

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




  @override
    Widget build(BuildContext context) {
      return LayoutBuilder(
        builder: (context,constraints) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor:Theme.of(context).scaffoldBackgroundColor ,
              title: Text("Leaderboard",style: GoogleFonts.quicksand(fontWeight: FontWeight.bold,fontSize: 32,color: Theme.of(context).colorScheme.tertiary),),
            ),
            body: _isLoading?const Center(child: CircularProgressIndicator(),):Column(
              children: [
                const SizedBox(height: 10,),
                Flexible(
                  child: ListView.builder(
                    itemCount: players.length,
                    itemBuilder: (BuildContext context, int index) {
                      return playerContainer(player: players[index], rank: index + 1,context: context);
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


