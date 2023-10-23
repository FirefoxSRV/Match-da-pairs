import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import '../../Material_components/material_switch.dart';
import '../../constants.dart';



class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    bool but = true;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: LayoutBuilder(builder: (context, constraints) {
        late double containerHeight = constraints.maxHeight;
        late double containerWidth = constraints.maxWidth;
        return CustomScrollView(
          slivers: [
            SliverAppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back,color: Theme.of(context).colorScheme.tertiary,),
                ),
                backgroundColor: Theme.of(context).colorScheme.background,
                bottom: PreferredSize(
                    preferredSize: const Size(0, 40),
                    child: Text(
                      "Settings ",
                      style: GoogleFonts.quicksand(fontSize: 40.0,fontWeight: FontWeight.w500,color: Theme.of(context).colorScheme.tertiary),
                    ))),
            SliverToBoxAdapter(
                child:SizedBox(
                  height: containerHeight/28.6,
                )),

            SliverToBoxAdapter(
                child: Divider(
                  endIndent: 10,
                  indent: 10,
                  color: Theme.of(context).colorScheme.outline,
                )),
            SliverToBoxAdapter(child: SizedBox(height: containerHeight/50,),),
            SliverToBoxAdapter(
                child: MaterialButton(
                  onPressed:(){

                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: containerWidth/6.1),
                        child: Text("Store your data locally !",
                            style: GoogleFonts.quicksand(
                                fontSize: 20.0, fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.tertiary)),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: containerHeight/42.264,left: containerWidth/20.57),
                            child: Icon(Icons.home,color: Theme.of(context).colorScheme.tertiary,),
                          ),
                          SizedBox(width: containerWidth/16.45,),
                          Expanded(
                            child: Text(
                              "The data of your cards are stored locally and secured using your fingerprint .",

                              style: GoogleFonts.quicksand(fontSize: 16.0,color: Theme.of(context).colorScheme.tertiary),),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            SliverToBoxAdapter(child: SizedBox(height: containerHeight/30.26,),),
            SliverToBoxAdapter(
                child: MaterialButton(
                  onPressed: (){

                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:EdgeInsets.only(left: containerWidth/6.1),
                        child: Text("Restore your data",
                            style: GoogleFonts.quicksand(
                                fontSize: 20.0, fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.tertiary)),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [Padding(
                          padding: EdgeInsets.only(bottom: containerHeight/42.264,left: containerWidth/20.57),
                          child: Icon(Icons.home,color: Theme.of(context).colorScheme.tertiary,),
                        ),
                          SizedBox(width: containerWidth/16.45,),
                          Expanded(
                            child: Text(
                                "If you have already used this app and stored the data , you can restore your cards in a click of a button  ",

                                style: GoogleFonts.quicksand(fontSize: 16.0,color: Theme.of(context).colorScheme.tertiary)),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            SliverToBoxAdapter(
              child: Center(
                child: MaterialSwitch(value:but,onChanged: (but){

                }),
              ),
            )
          ],
        );
      }),
    );
  }
}
