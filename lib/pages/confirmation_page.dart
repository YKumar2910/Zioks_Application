import 'package:flutter/material.dart';
import 'package:zioks_application/image_mapper.dart';

// ignore: must_be_immutable
class ConfirmationPage extends StatefulWidget {
  late List<String> lines;
  final String text;

  ConfirmationPage({super.key,required this.text}) {
    lines=text.split(RegExp(r'\r?\n'));
  }

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              "Confirmation",
              style: TextStyle(
                fontSize: 30,
                color: Colors.teal.shade400,
              ),
            ),
            const Spacer(),
            SizedBox(
              height:200,
              child: ListView.builder(
                itemCount: widget.lines.length,
                itemBuilder: (context,index){

                  return Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      index==0?"Hi ${widget.lines[index]}":widget.lines[index],
                      style: TextStyle(
                        fontSize: index==0?40:25,
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              ),
            ),
            
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300,width:4)
              ),
              child: Image(
                height: 400,
                width: 350,
                image: AssetImage(
                  imageMapper['personsImage'] as String
                ),
              ),
            ),
            const Spacer(),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.teal.shade400,
                fixedSize: const Size(300,75 ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7.5))
                )

              ),
              onPressed: (){}, 
              child: Text(
                widget.lines.length==1?"Confirm Check in":"Confirm Check out",
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white
                ),
              )
            ),
            const Spacer(flex:2),
          ],
          
        ),
      ),

    );
  }
}

/* */