import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChipWidget extends StatefulWidget {
  final List<String> reasons;
  
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
          
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: GestureDetector(
              onTap: (){
                setState(() {
                  widget.selectedReason[0]=widget.reasons[index];
                });
              },
              child: Chip(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                shape: const RoundedRectangleBorder(
                  side: BorderSide(width: 1, ),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                backgroundColor: widget.reasons[index]==widget.selectedReason[0]?
                Colors.grey:Colors.white,
                label: Text(
                  widget.reasons[index],
                  style: TextStyle(
                    color: widget.reasons[index]==widget.selectedReason[0]?
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