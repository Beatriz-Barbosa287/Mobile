import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        appBar: AppBar(title: Text("Exemplo Widgets de Exibição"),),
        body: Center(
          child: Column(
            children: [
              Text("Texto de exemplo",
              style: TextStyle(
                fontSize: 20,
                color: const Color.fromARGB(255, 91, 0, 114),
                      )
                    ),
                  Text("Flutter é incrivel",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 80, 1, 47),
                    letterSpacing: 2
                  ),
                  textAlign: TextAlign.right,),
                  Image.network( 'https://storage.googleapis.com/cms-storage-bucket/9abb63d8732b978c7ea1.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,),
                  Image.asset("assets/img/einstein.jpg",
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,),
                  Icon(Icons.star, 
                    size: 36,
                    color: Colors.amber,)
            ],
          ))
    ));
  }
}