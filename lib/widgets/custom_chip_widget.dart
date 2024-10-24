import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChipWidget extends StatefulWidget {
  final Map<String,dynamic> reasons;
  
  final double fontsize;
  
  final double chipSize;
  List<String> selectedReason;
  ChipWidget(
    this.selectedReason,
    {
    super.key,
    required this.reasons,
    required this.fontsize, 
    required this.chipSize,
  });

  @override
  State<ChipWidget> createState() => _ChipWidgetState();
}

class _ChipWidgetState extends State<ChipWidget> {
  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:  widget.reasons.length,
        itemBuilder: (context,index){
          String purposeId = widget.reasons.keys.elementAt(index); 
          String purposeName = widget.reasons[purposeId][0]!;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: GestureDetector(
              onTap: (){
                setState(() {
                  widget.selectedReason[0]=purposeId;
                });
              },
              child: Chip(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                shape: const RoundedRectangleBorder(
                  side: BorderSide(width: 1, ),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                backgroundColor: purposeId==widget.selectedReason[0]?
                Colors.grey:Colors.white,
                label: Text(
                  purposeName,
                  style: TextStyle(
                    color: purposeId==widget.selectedReason[0]?
                    Colors.white:Colors.black,
                    fontSize: widget.fontsize
                  )
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}