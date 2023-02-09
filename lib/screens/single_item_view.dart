import 'dart:async';

import 'package:flutter/material.dart';
import '../appconstants/constants.dart';
import '../logic/animation_event.dart';
import '../logic/animation_bloc.dart';
import '../logic/animation_state.dart';
import 'item_details_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleItemView extends StatefulWidget {
  @override
  State<SingleItemView> createState() => _SingleItemViewState();
}

class _SingleItemViewState extends State<SingleItemView>
    with TickerProviderStateMixin {
  AnimatedBloc animatedBloc = AnimatedBloc();
  late AnimationController _controller;
  bool isVisible = true;

  @override
  void initState() {
    animatedBloc.add(InitialEvent());
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => animatedBloc,
        child: Scaffold(
          backgroundColor: Colors.white70,
          appBar: AppBar(
            title: Text(AppConstants.cart),
            leading: const Icon(
              Icons.arrow_back,),
          ),
          body: Visibility(
            visible: isVisible,
            child: Column(
              children: [
                Container(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 22, left: 22),
                        child: InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(ItemDetails.routeName);
                            },
                            child: cardData()),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 22, left: 22),
                        child: InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(ItemDetails.routeName);
                            },
                            child: cardData()),
                      ),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                stepWiseStatusOrder(AppConstants.status.toUpperCase()),
                entireOrderStatus(AppConstants.orderPlaced),
                entireOrderStatus(AppConstants.payConfor),
                entireOrderStatus(AppConstants.processing),
                entireOrderStatus(AppConstants.onTheWay),
                entireOrderStatus(AppConstants.deliver),
              ],
            ),
          ),
        ));
  }

  statusTickIcon(IconData img, Color col) {
    return Padding(
      padding: const EdgeInsets.only(left: 22, top: 10, right: 10),
      child: Container(
        height: 30,
        width: 30,
        child: Icon(
          img,
          color: Colors.white,
        ),
        decoration: BoxDecoration(
          color: col,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  stepWiseStatusOrder(String orderStatus) {
    return Text(
      orderStatus,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  entireOrderStatus(String orderStatus) {
    IconData icon = Icons.done;
    Color col = Colors.blue;
    if (orderStatus == AppConstants.deliver) {
      icon = Icons.adjust;
      col = Colors.grey;
    }

    return BlocBuilder<AnimatedBloc, AnimatedState>(builder: (context, state) {
      if (state is InitialEvent) {
        return Center(child: Text(AppConstants.msg));
      } else {
        if (isVisible == true) {
          return Visibility(
            visible: true,
            child: Row(children: [
              Column(
                children: [
                  statusTickIcon(icon, col),
                  if (icon != Icons.adjust)
                    Visibility(
                      visible: true,
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (BuildContext _, child) {
                          return Transform.scale(
                            scale: _controller.value,
                            child: child,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            width: 3,
                            height: 40,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Column(
                children: [stepWiseStatusOrder(orderStatus)],
              )
            ]),
          );
        } else {
          return Center(
            child: Text(AppConstants.msg),
          );
        }
      }
    });
  }

  cardData() {
    return Container(
      width: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cardText(
                AppConstants.orderNoText + AppConstants().orderNo.toString(),
                15,
                FontWeight.bold),
            cardText(AppConstants.placedDate, 12, FontWeight.normal),
            cardText(AppConstants.paid, 15, FontWeight.bold),
            cardText(AppConstants.Status, 15, FontWeight.bold),
          ],
        ),
      ),
    );
  }

  cardText(String text, double size, FontWeight weight) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text(
        text,
        style: TextStyle(fontSize: size, fontWeight: weight),
      ),
    );
  }


}

//logic for getting one animation at a time
// for(int i=0;i<=4;i++){
// callthe method for tick;
// callthe method for animation;
// i++;
//
// }