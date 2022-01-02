import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ProviderFile/Provider_Data.dart';

class AddToCart extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:MultiProvider(
        providers: [
        ChangeNotifierProvider<Calculation>(
        create: (_) => Calculation(),
    ),
    ],
    builder: (context, con) {
    return SafeArea(
      child: Container(
        color: Colors.red,
            child: Consumer<Calculation>(builder: (context,todo,child){
              return Column(
                children: [
                  Container(child: Text(todo.list.length.toString()),),
                  Container(
                    height: MediaQuery.of(context).size.height*0.5,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        itemCount:todo.list.length,
                        itemBuilder: (context,index){
                          return todo.list[index];
                        }),

                  ),
                ],
              );
            },
            ),
          ),
    );
        }
    ),
    );
  }
}
