import 'package:flutter/material.dart';
import 'package:menfashionnepal/ProviderFile/Provider_Data.dart';
import 'package:provider/provider.dart';

class Continuewith extends StatefulWidget {
  @override
  State<Continuewith> createState() => _ContinuewithState();
}

class _ContinuewithState extends State<Continuewith> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MultiProvider(
            providers: [
          ChangeNotifierProvider<Calculation>(
            create: (BuildContext context) => Calculation(),
          ),
        ],
            builder: (context, con) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Consumer<Calculation>(builder: (context, to, child) {
                      context.read<Calculation>().GetProfileData();
                      context.read<Calculation>().CartIteamNumber();
                      return Padding(
                        padding:
                        const EdgeInsets.only(top: 20, bottom: 20),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Container(
                                height: MediaQuery.of(context).size.height * 0.13,
                                width: MediaQuery.of(context).size.width * 0.25,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(width: 2,color: Colors.white),
                                  image: DecorationImage(
                                    image:((to.photourl == null)
                                        ? AssetImage('Assets/profile.png')
                                        : NetworkImage(to.photourl!)) as ImageProvider<Object>,),
                                  ),
                                ),

                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(to.name.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                              ),

                              Text(to.email.toString(),style: TextStyle(color: Colors.black),),



                              (to.email!=null)?
                              GestureDetector(
                                onTap: () {
                                 context.read<Calculation>().ClearPreferences();
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 15),
                                  height: 50,
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Log Out',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )

                              :GestureDetector(
                                onTap: () {
                                  context.read<Calculation>().loadingbool = "True";
                                  context.read<Calculation>().controlSignIN();
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 15),
                                  height: 50,
                                  width: MediaQuery.of(context).size.width * 0.7,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Sign in with Google',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      );
                    }),




                    Consumer<Calculation>(builder: (context, to, child) {
                      context.read<Calculation>().CartIteamNumber();
                      return (to.loadingbool == "True")
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: LinearProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Colors.blue),
                                    backgroundColor: Colors.deepOrangeAccent,
                                  ),
                                ),
                              ),
                            )
                          : Text("");
                    })
                  ],
                ),
              );
            }));
  }
}
