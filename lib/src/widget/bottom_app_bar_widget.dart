import 'package:flutter/material.dart';

class BottomAppBarWidget extends StatelessWidget {
  const BottomAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildTabItem(
            index: 0,
            icon: const Icon(Icons.star_border),
          ),
          buildTabItem(
            index: 1,
            icon: const Icon(Icons.two_wheeler)
          ),
          buildTabItem(
            index: 2,
            icon: const Icon(Icons.more_horiz)
          ),
        ],
      ),
    );
  }
  
  Widget buildTabItem({
    required int index,
    required Icon icon,
  }){
    return IconButton(
      icon: icon,
      onPressed: (){}
    );
  }
}