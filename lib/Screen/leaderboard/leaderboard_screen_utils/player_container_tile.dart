import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget playerContainer({required Map player, required int rank,required BuildContext context}) {
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