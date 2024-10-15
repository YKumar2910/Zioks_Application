import 'package:zioks_application/pages/visitor_info.dart';
import 'package:zioks_application/widgets/tenant_widget_card.dart';
import 'package:zioks_application/widgets/type_ahead_form_widget.dart';
import 'package:flutter/material.dart';

class CompanySearch extends StatefulWidget {
  const CompanySearch({super.key});

  @override
  State<CompanySearch> createState() => _CompanySearchState();
}

class _CompanySearchState extends State<CompanySearch> {
  late final TextEditingController textcontroller;
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    textcontroller=TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Form(
        key: _formkey,
        child: LayoutBuilder(
          builder: (context,constraints){
            double screenWidth = constraints.maxWidth;
            double screenHeight = constraints.maxHeight;
        
            double fontSizeTitle = screenWidth < 600 ? 20 : 25;
            double fontSizeTextSmall = screenWidth < 600 ? 15 : 20;
            
            return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Spacer(),
                  Container(
                    
                    alignment: Alignment.center,
                    child: Text(
                      "Tenant",
                      style: TextStyle(
                        fontSize: fontSizeTitle,
                        color: Colors.teal.shade400,
                      )
                    ),
                  ),
                  const Spacer(),
                      
                  Container(
                    alignment: Alignment.center,
                    width: screenWidth,
                    padding: EdgeInsets.symmetric(horizontal: screenWidth<600?  screenWidth*0.05: screenWidth*0.10),
                    
                    child: AutoTextField(
                      message: "Search Company you wish to visit", 
                      cont: textcontroller, 
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      fontSize: screenWidth<600?fontSizeTextSmall:fontSizeTextSmall*0.80,
                      align: true
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "Search Organization you wish to visit...",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fontSizeTextSmall,
                        color: Colors.black,
                      )
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    alignment: Alignment.center,
                    width: screenWidth,
                    padding: EdgeInsets.symmetric(horizontal: screenWidth*0.10),
                    height: screenHeight/2,
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context,index){
                        return GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context){
                                  return const VisitorInfo();
                                }
                              )
                            );
                          },
                      
                          child: TenantWidgetCard(
                            height: screenHeight/15,
                            width: screenWidth*0.1, 
                            fontSize: fontSizeTextSmall
                          )
                        );
                      }
                    ),
                  ),
                  const Spacer(flex:3),
                ],
            );
          }
        )
      ),
    );
  }
}