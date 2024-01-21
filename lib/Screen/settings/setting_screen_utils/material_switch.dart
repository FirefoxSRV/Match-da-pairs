// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../constants.dart';
// import '../../themes/theme_provider.dart';
//
//
// class MaterialSwitch extends StatefulWidget {
//   final bool value;
//   final Function onChanged;
//   const MaterialSwitch({super.key,required this.value,required this.onChanged});
//
//   @override
//   State<MaterialSwitch> createState() => _MaterialSwitchState(value,onChanged);
// }
//
// class _MaterialSwitchState extends State<MaterialSwitch> {
//   late bool value;
//   Function onChanged;
//   _MaterialSwitchState(this.value, this.onChanged);
//
//
//
//
//   Future<void> onSwitchPress() async {
//     try {
//       var themeProvider = Provider.of<ThemeProvider>(context, listen: false);
//       // print(themeProvider.themeMode);
//       var newThemeMode = themeProvider.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
//       themeProvider.themeMode = newThemeMode;
//       await onChanged(!value);
//       setState(() {

//         value = !value;
//       });
//     } catch (e) {
//       return Future.error(e);
//     }
//   }
//
//   @override
//   void initState() {
//
//     var themeProvider = Provider.of<ThemeProvider>(context, listen: false);
//     var newThemeMode = ThemeMode.system == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
//
//     if(newThemeMode == ThemeMode.dark){
//       setOff();
//     }else{
//       setOn();
//     }
//     super.initState();
//   }
//
//
//
//
//   void setOn(){
//     setState(() {
//       value = true;
//     });
//   }
//
//   void setOff(){
//     setState(() {
//       value=false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(28),
//       onTap: onSwitchPress,
//       child: Stack(
//         children: [
//           AnimatedContainer(
//             height: 28,
//             width: 58,
//             duration: const Duration(milliseconds: 100),
//             decoration: BoxDecoration(
//                 color: value?Theme.of(context).hoverColor:Theme.of(context).indicatorColor,
//                 borderRadius: BorderRadius.circular(100)
//             ),
//           ),
//           AnimatedPositioned(
//             duration: const Duration(milliseconds: 250),
//             right: value?2:28,
//             left: value?28:2,
//             bottom: 2,
//             child: Container(
//               height: 24,
//               width: 24,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: value?Theme.of(context).canvasColor:Theme.of(context).dividerColor,
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
