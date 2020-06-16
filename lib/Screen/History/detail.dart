import 'package:flutter/material.dart';
import 'package:flutter_taxi_app_driver/Components/ink_well_custom.dart';
import 'package:flutter_taxi_app_driver/theme/style.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HistoryDetail extends StatefulWidget {
  final String id;

  HistoryDetail({this.id});

  @override
  _HistoryDetailState createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  String yourReview;
  double ratingScore;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History',
          style: TextStyle(color: blackColor),
        ),
        backgroundColor: whiteColor,
        elevation: 2.0,
        iconTheme: IconThemeData(color: blackColor),
      ),
      bottomNavigationBar: ButtonTheme(
        minWidth: screenSize.width,
        height: 45.0,
        child: RaisedButton(
          elevation: 0.0,
          color: primaryColor,
          child: Text('Submit',style: headingWhite,
          ),
          onPressed: (){
            Navigator.of(context).pushReplacementNamed('/history');
            //and
            Navigator.popAndPushNamed(context, '/history');
          },
        ),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: InkWellCustom(
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
            child: Container(
              color: greyColor,
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
                          flex: 5,
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
                    color: whiteColor,
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
                          Divider(),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("note".toUpperCase(),style: textGreyBold,),
                                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry",style: textStyle,),
                              ],
                            ),
                          ),
                        ],
                      )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.0,bottom: 5.0),
                    padding: EdgeInsets.all(10),
                    color: whiteColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Bill Details (Cash Payment)".toUpperCase(), style: textGreyBold,),
                        Container(
                          padding: EdgeInsets.only(top: 8.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Text("Ride Fare", style: textStyle,),
                              new Text("\$10.99", style: textBoldBlack,),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 8.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Text("Taxes", style: textStyle,),
                              new Text("\$1.99", style: textBoldBlack,),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 8.0,bottom: 8.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Text("Discount", style: textStyle,),
                              new Text("- \$5.99", style: textBoldBlack,),
                            ],
                          ),
                        ),
                        Container(
                          width: screenSize.width - 50.0,
                          height: 1.0,
                          color: Colors.grey.withOpacity(0.4),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 8.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Text("Total Bill", style: heading18Black,),
                              new Text("\$7.49", style: heading18Black,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Container(
                      //margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(10.0),
                      color: whiteColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RatingBar(
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemSize: 20.0,
                            itemCount: 5,
                            glowColor: Colors.white,
                            onRatingUpdate: (rating) {
                              ratingScore = rating;
                              print(rating);
                            },
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10.0),
                            child: SizedBox(
                              height: 100.0,
                              child: TextField(
                                style: textStyle,
                                decoration: InputDecoration(
                                  hintText: "Write your review",
//                                hintStyle: TextStyle(
//                                  color: Colors.black38,
//                                  fontFamily: 'Akrobat-Bold',
//                                  fontSize: 16.0,
//                                ),
                                  border: OutlineInputBorder(
                                      borderRadius:BorderRadius.circular(5.0)),
                                ),
                                maxLines: 2,
                                keyboardType: TextInputType.multiline,
                                onChanged: (String value) { setState(() => yourReview = value );},
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
