import 'package:flutter/material.dart';
import 'package:zioks_application/widgets/custom_widget.dart';

class VisitorInfo extends StatefulWidget {
  const VisitorInfo({super.key});

  @override
  State<VisitorInfo> createState() => _VisitorInfoState();
}

class _VisitorInfoState extends State<VisitorInfo> {
  late final TextEditingController textcontroller;
  static const List<String> visitReasons=["Meeting","Interview","Vendor","Others"];
  static String reasonSelected="";
  @override
  void initState() {
    super.initState();
    textcontroller=TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (context,constraints) {
          double screenWidth=constraints.maxWidth;
          double screenHeight = constraints.maxHeight;

          double fontSizeTitle = screenWidth < 600 ? 20:25;
          double fontSizeTextSmall = screenWidth < 600 ? 15 : 20;
          double chipSize=screenHeight*0.1;

          return Container(
            margin: const EdgeInsets.all(8),
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Center(
                  child: TextWidget(
                    message: "Please fill the following information",
                    fontsize: fontSizeTitle
                  )
                ),
                const Spacer(),
                TextWidget(message: "Company Name.",fontsize: fontSizeTextSmall),

                TextFieldWidget(cont: textcontroller, message:"Enter your company name"),

                const SizedBox(height:16),

                TextWidget(message: "Purpose of visit.",fontsize: fontSizeTextSmall),

                const SizedBox(height:16),

                TextWidget(message: "Who do you wish to meet?",fontsize: fontSizeTextSmall),

                TextFieldWidget(
                  cont: textcontroller, 
                  message:"Enter the name of the Employee you wish to visit"
                ),
                const Spacer(),
              ],
            
            ),
          );
        }
      )
    );
  }
}