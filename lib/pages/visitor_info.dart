import 'package:flutter/material.dart';
import 'package:zioks_application/pages/confirmation_page.dart';
import 'package:zioks_application/widgets/custom_chip_widget.dart';
import 'package:zioks_application/widgets/custom_widget.dart';

class VisitorInfo extends StatefulWidget {
  const VisitorInfo({super.key});

  @override
  State<VisitorInfo> createState() => _VisitorInfoState();
}

class _VisitorInfoState extends State<VisitorInfo> {
  late final TextEditingController companytextcontroller;
  late final TextEditingController visitingtextcontroller;
  final _formkey = GlobalKey<FormState>();
  bool reasonSelected=true;

  List<String> selectedReason=[""];
  
  static const List<String> visitReasons = ["Meeting", "Interview", "Vendor", "Others"];
  
  @override
  void initState() {
    super.initState();
    companytextcontroller = TextEditingController();
    visitingtextcontroller = TextEditingController();
  }

  Widget errorMessage(double screenWidth){
    double fontSizeTextSmall = screenWidth < 600 ? 12 : 13;

    return Padding(

      padding: const EdgeInsets.all(2.0),
      child:  Text(
        "This field is necessary",
        style: TextStyle(
          color: const Color.fromARGB(255, 170, 9, 1),
          fontSize: fontSizeTextSmall
        ),
      ),
    );
  }

  void onSubmit(){
    if (_formkey.currentState!.validate()) {
      if (selectedReason[0].isEmpty){
        setState(() {
          reasonSelected=false;
        });
      } else{
          reasonSelected=true;
          Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return ConfirmationPage(text: "Kshitij Jaiswal");
        }));
      }
    } else {
      setState(() {
        reasonSelected = selectedReason[0].isEmpty ? false : true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formkey,
        child: LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = constraints.maxWidth;
            double screenHeight = constraints.maxHeight;
        
            double fontSizeTitle = screenWidth < 600 ? 20 : 25;
            double fontSizeTextSmall = screenWidth < 600 ? 15 : 20;
            double chipSize = screenHeight * 0.1;
            double buttonWidth = screenWidth < 600 ? screenWidth * 0.5 : 300;
            double buttonHeight = screenWidth < 600 ? 25 : 50;
            
            return Container(
              margin: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Center(
                    child: HeaderWidget(
                      message: "Please fill the following information",
                      screenWidth: screenWidth,
                      fontSize: fontSizeTitle,
                    )
                  ),
                  const Spacer(),
                  TextWidget(message: "Company Name.", fontsize: fontSizeTextSmall),
        
                  TextFieldWidget(
                    cont: companytextcontroller, 
                    message: "Enter your company name",
                    emptyMessage: "This field is necessary",
                    fontsize: fontSizeTextSmall,
                  ),
        
                  const SizedBox(height: 16),
        
                  TextWidget(message: "Purpose of visit.  ", fontsize: fontSizeTextSmall),
        
                  
                  ChipWidget(
                    chipSize: chipSize,
                    reasons: visitReasons,
                    fontsize: fontSizeTextSmall
                    ,selectedReason
                  ),
                  if (reasonSelected==false)
                    errorMessage(screenWidth),
        
                  const SizedBox(height: 16),
        
                  TextWidget(message: "Who do you wish to meet? ", fontsize: fontSizeTextSmall),

                  TextFieldWidget(
                    cont: visitingtextcontroller, 
                    message: "Enter the name of the Employee you wish to visit.  ",
                    emptyMessage: "This field is necessary",
                    fontsize: fontSizeTextSmall,
                  ),
                  const Spacer(),
                  Center(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.teal.shade400,
                        fixedSize: Size(buttonWidth, buttonHeight),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7.5))
                        )
                      ),
                      onPressed: onSubmit, 
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Next",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSizeTextSmall
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          )
                        ],
                      )
                    ),
                  ),
                  const Spacer(flex: 3),
                ],
              ),
            );
          }
        ),
      )
    );
  }
}
