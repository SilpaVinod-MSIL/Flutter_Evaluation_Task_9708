import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../appconstants/constants.dart';
import '../logic/animation_event.dart';
import '../logic/animation_bloc.dart';
import '../logic/animation_state.dart';

class ItemDetails extends StatefulWidget {
  static const routeName = '/second';

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  AnimatedBloc animatedBloc = AnimatedBloc();

  @override
  void initState() {
    animatedBloc.add(InitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => animatedBloc,
      child: Scaffold(
          appBar: AppBar(
            title: Text(AppConstants.selectedItem),
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                )),
            actions: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                child: Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
              )
            ],
          ),
          body: BlocBuilder<AnimatedBloc, AnimatedState>(
            builder: (context, state) {
              if (state is InitialEvent) {
                return Text(AppConstants.msg);
              } else {
                return Card(
                  color: Colors.white,
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        boxWithImage(200, 200, Image.asset('assets/bag.jpg')),
                        boxSize(10),
                        textData(AppConstants.rateOfItem, 16, FontWeight.bold,
                            Colors.black),
                        boxSize(10),
                        textData(AppConstants.itemDetail, 14, FontWeight.normal,
                            Colors.black),
                        boxWithImage(
                          50,
                          100,
                          Image.asset('assets/rating.PNG'),
                        ),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                                child: Center(
                                    child: textData(AppConstants.ratingRate, 14,
                                        FontWeight.bold, Colors.orange)),
                                height: 25,
                                width: 100,
                                color: Colors.limeAccent)),

                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue)),
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: textData(AppConstants.buyNowButton, 14,
                                FontWeight.normal, Colors.black),
                          ),
                        ),
                        boxSize(10),
                        textData(AppConstants.addToCart, 14, FontWeight.bold,
                            Colors.blue)
                        //SizedBox
                      ],
                    ),
                  ), //Column
                  //SizedBox
                  //Card
                );
              }
            },
          )),
    );
  }

  boxSize(double height) {
    return SizedBox(
      height: height,
    );
  }

  boxWithImage(double height, double width, Image image) {
    return SizedBox(height: height, width: width, child: image);
  }
}

textData(String data, double size, FontWeight weight, Color col) {
  return Text(data,
      style: TextStyle(fontSize: size, fontWeight: weight, color: col));
}
