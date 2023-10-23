import 'package:flutter/material.dart';
import 'package:mem_game/constants.dart';

class MaterialSwitch extends StatefulWidget {
  final bool value;
  final Function onChanged;
  const MaterialSwitch({super.key,required this.value,required this.onChanged});

  @override
  State<MaterialSwitch> createState() => _MaterialSwitchState(value,onChanged);
}

class _MaterialSwitchState extends State<MaterialSwitch> {
  bool value;
  Function onChanged;
  _MaterialSwitchState(this.value, this.onChanged);

  Future<void> onSwitchPress() async{
    try{
      await onChanged(!value);
      if(value){
        setOff();
      }else{
        setOn();
      }
    }catch(e){
      return Future.error(e);
    }
  }


  void setOn(){
    setState(() {
      print("Dark mode on");
      value=true;
    });
  }

  void setOff(){
    setState(() {
      print("Dark mode off");
      value=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(28),
      onTap: onSwitchPress,
      child: Stack(
        children: [
          AnimatedContainer(
            height: 28,
            width: 58,
            duration: Duration(milliseconds: 100),
            decoration: BoxDecoration(
                color: value?Theme.of(context).hoverColor:Theme.of(context).indicatorColor,
                borderRadius: BorderRadius.circular(100)
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            right: value?2:28,
            left: value?28:2,
            bottom: 2,
            child: Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: value?Theme.of(context).canvasColor:Theme.of(context).dividerColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
