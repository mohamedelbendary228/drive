import 'package:flutter/material.dart';
import 'package:flutter_taxi_app_driver/theme/style.dart';
import 'package:flutter_taxi_app_driver/Screen/Menu/Menu.dart';
import 'requestDetail.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RequestScreen extends StatefulWidget {
  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final String screenName = "REQUEST";

  navigateToDetail() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => RequestDetail()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Request',
          style: TextStyle(color: blackColor),
        ),
        backgroundColor: whiteColor,
        elevation: 2.0,
        iconTheme: IconThemeData(color: blackColor),
      ),
      drawer: new MenuScreens(activeScreenName: screenName),
      body: Container(
        child: Scrollbar(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  print('$index');
                  navigateToDetail();
                },
                child: historyItem()
              );
            }
          ),
        )
      )
    );
  }

  Widget historyItem() {
    final screenSize = MediaQuery.of(context).size;
    return Card(
        margin: EdgeInsets.all(10.0),
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: CachedNetworkImage(
                          imageUrl: 'https://source.unsplash.com/1600x900/?portrait',
                          fit: BoxFit.cover,
                          width: 40.0,
                          height: 40.0,
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Olivia Nastya',style: textBoldBlack,),
                          Text("08 Jan 2019 at 12:00 PM", style: textGrey,),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 25.0,
                                  padding: EdgeInsets.all(5.0),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: primaryColor
                                  ),
                                  child: Text('ApplePay',style: textBoldWhite,),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  height: 25.0,
                                  padding: EdgeInsets.all(5.0),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: primaryColor
                                  ),
                                  child: Text('Discount',style: textBoldWhite,),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text("\$ 250.0",style: textBoldBlack,),
                          Text("2.2 Km",style: textGrey,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("PICK UP".toUpperCase(),style: textGreyBold,),
                          Text("2536 Flying Taxicabs",style: textStyle,),

                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("DROP OFF".toUpperCase(),style: textGreyBold,),
                          Text("2536 Flying Taxicabs",style: textStyle,),

                        ],
                      ),
                    ),
                  ],
                )
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: ButtonTheme(
                  minWidth: screenSize.width ,
                  height: 45.0,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                    elevation: 0.0,
                    color: primaryColor,
                    child: Text('Accept',style: headingWhite,
                    ),
                    onPressed: (){
//                      Navigator.of(context).pushReplacementNamed('/history');
                      navigateToDetail();
                    },
                  ),
                ),
              ),

            ],
          ),
        ),
      );
  }
}
