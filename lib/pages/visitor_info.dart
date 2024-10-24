import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zioks_application/endpoint_caller.dart';
import 'package:zioks_application/pages/confirmation_page.dart';
import 'package:zioks_application/token_provider.dart';
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
  
  late List<String> visitReasons;
  late String token;
  late Future<Map<String,dynamic>> reasons;
  
  @override
  void initState() {
    super.initState();
    companytextcontroller = TextEditingController();
    visitingtextcontroller = TextEditingController();
    token=Provider.of<TokenProvider>(context,listen: false).getaccessToken();
    _intializeReasons();
  }
  void _intializeReasons(){
    reasons=EndpointCaller.getCallEndpoint(endpoint:  'visit-purposes',token:  token);
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
          return ConfirmationPage(text: "");
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
          
              double fontSizeTitle = screenWidth < 600 ? 20 : 35;
              double fontSizeTextSmall = screenWidth < 600 ? 15 : 20;
              double chipSize = screenHeight * 0.1;
              double buttonWidth = screenWidth < 600 ? screenWidth * 0.5 : 300;
              double buttonHeight = screenWidth < 600 ? 25 : 35;
              
              return FutureBuilder(
                future: reasons,
                builder: (context,snapshot) {
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  else if(snapshot.hasError){
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [Text(
                          
                          "OOPS Something went wrong",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: fontSizeTitle,
                            color: const Color.fromRGBO(0, 176, 147, 1)
                          ),
                        ),
                        const SizedBox(height:25),
                        const Icon(
                          Icons.error_outline,
                          size: 25,
                          color: Color.fromRGBO(0, 176, 147, 1),
                        ),
                        const SizedBox(height:25),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(0, 176, 147, 1),
                            fixedSize: Size(buttonWidth, buttonHeight),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(7.5))
                            )
                          ),
                          onPressed: (){setState(()=>_intializeReasons());}, 
                          child: Text("Retry",style: TextStyle(fontSize: fontSizeTextSmall,color: Colors.white),))
                        ]
                      ),
                    );
                  }
                  final response=snapshot.data!;
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
                          reasons: response["data"],
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
                              backgroundColor: const Color.fromRGBO(0, 176, 147, 1),
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
              );
            }
          ),
        )
      );
  }
}
