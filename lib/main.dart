import 'package:flutter/material.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:fl_chart/fl_chart.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
          theme: 
          ThemeData(primaryColor: Colors.orange, accentColor: Colors.yellowAccent),
          debugShowCheckedModeBanner: false,
          home: SplashScreen(
            //il percorso del mio file flare
                      'assets/splash.flr',
                      Screen(),
                      startAnimation: 'intro',
                      //perchè lo sfondo è nero?
                      backgroundColor: Color(0xff900),
                ),
              );
  }
}

class Screen extends StatefulWidget {
  @override
  _Screen createState() => _Screen();
}
class _Screen extends State<Screen> with SingleTickerProviderStateMixin {
  int touchedIndex;
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  Duration duration=const Duration(milliseconds: 200);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuscaleAnimation;
  Animation<Offset> _slideAnimation;
  final titles=[
    'Plastica',
    'Carta',
    'Vetro'
  ];
  final color=[
    Colors.yellow,
    Colors.blue,
    Colors.green,
  ];
  @override
  void initState(){
    super.initState();
    _controller= AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuscaleAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1,0) , end: Offset(0,0)).animate(_controller);
  }
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size; //ci permette di adattare la finestra
    screenHeight= size.height;
    screenWidth= size.width;
    return Scaffold( 
      body:Stack(
        children: <Widget>[
          menu(context),
          dashboard(context),
        ],
      )
    );
  }
  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.yellow,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.blue,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color:  Colors.green,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
  Widget menu( BuildContext context){
    return SlideTransition(
      position: _slideAnimation,
      child:ScaleTransition(
        scale:_menuscaleAnimation,
        child:Padding(
          padding: const EdgeInsets.only(right:16.0),
          child:Align(
            alignment: Alignment.center,
            child:Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment:MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,  
              children: <Widget>[
                Text(
                  "Chi siamo?", style: TextStyle(fontSize:20),
                ),
                SizedBox(height: 10),
                Text(
                  "Goal?", style: TextStyle(fontSize:20),
                )
              ],
            ),
          ),
        ),
      ) 
        
    );
  }
  
   Widget dashboard(BuildContext context){
      return AnimatedPositioned (
        duration: duration,
        top: 0,
        bottom: 0,
        left: isCollapsed ? 0 :0.6 * screenWidth,
        right: isCollapsed ? 0 :-0.4 * screenWidth,
        child:ScaleTransition(
          scale:_scaleAnimation,
          child:Material(
          animationDuration:duration,
          //borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation:8,
          color: Colors.white,
              child:Column(
                    children: <Widget>[
                      ClipPath(
                        //clipper: MyClipper(),
                        child:Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                        gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xFF3383CD),
                          Color(0xFF11249F),
                          ],
                          ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height:30.0),
                              Align(
                                alignment: Alignment.topLeft,
                                child:InkWell(
                                      child:Icon(Icons.call_received),
                                      onTap:(){
                                        setState((){
                                          if (isCollapsed)
                                            _controller.forward();
                                            else
                                            _controller.reverse();
                                          isCollapsed = !isCollapsed;
                                        }
                                        );
                                      }
                                    ),
                              ),
                              Center(
                                    child: Positioned(
                                      child: Text("Ecobox",
                                      style: TextStyle(fontSize: 20, color: Colors.black)
                                        ),
                                      ),
                              ),
                            ], 
                          )
                      ),
                  ),
                      
                  SizedBox(height: 10),
                  Container(
                    height:500,
                    child:PageView(
                      controller: PageController(viewportFraction: 0.8),
                      scrollDirection: Axis.horizontal,
                      pageSnapping:true,
                      children: <Widget>[
                        //questo è il contenitore del resoconto giornaliero
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal:8),
                          child:
                            Material(
                                  color:Colors.orange,
                                  elevation:12.0,
                                  shadowColor: Color(0x802196F3) ,
                                  borderRadius: BorderRadius.circular(10.0),
                                  child:
                                  Column(
                                    children:<Widget>[
                                       Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children:[
                                            Container(
                                              padding: const EdgeInsets.only(top:12),
                                              child:Text("Resoconto Giornaliero",
                                              style:TextStyle(
                                                  fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xffffffff)
                                                  ),
                                                )
                                            ),
                                          ],
                                       ),
                                      AspectRatio(
                                            aspectRatio: 1,
                                            child: PieChart(
                                              PieChartData(
                                                //tutto questo gestisce il tocco su ogni parte
                                                  pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                                                    setState(() {
                                                      if (pieTouchResponse.touchInput is FlLongPressEnd ||
                                                          pieTouchResponse.touchInput is FlPanEnd) {
                                                        touchedIndex = -1;
                                                        //inserire la visualizzazione di una determinata sezione di pagina
                                                      } else {
                                                        touchedIndex = pieTouchResponse.touchedSectionIndex;
                                                      }
                                                    });
                                                  }),
                                                  borderData: FlBorderData(
                                                    show: false,
                                                  ),
                                                  sectionsSpace: 1,//spazio tra le partti del cerchio
                                                  centerSpaceRadius: 60, //larghezza del centro
                                                  sections: showingSections()),
                                            ),
                                          ),
                                          /*
                                          ListView.separated(
                                            shrinkWrap: true,
                                            itemBuilder: (context, index){
                                              return ListTile(
                                                leading: CircleAvatar(backgroundColor: color[index],
                                               ),
                                                title: Text(titles[index]),
                                                );
                                                },
                                               separatorBuilder: (context,index){
                                                 return Divider(height: 0);
                                                 },
                                                 itemCount:3)*/
                                    ]
                                   )  
                              ),
                        ),
                        //questo è il contenitore del resoconto mensile
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal:8),
                          child:
                            Material(
                                  color:Colors.orange,
                                  elevation:12.0,
                                  shadowColor: Color(0x802196F3) ,
                                  borderRadius: BorderRadius.circular(10.0),
                                  child:
                                  Column(
                                    children:<Widget>[
                                       Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children:[
                                            Container(
                                              padding: const EdgeInsets.only(top:12),
                                              child:Text("Resoconto Giornaliero",
                                              style:TextStyle(
                                                  fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xffffffff)
                                                  ),
                                                )
                                            ),
                                          ],
                                       ),
                                      AspectRatio(
                                            aspectRatio: 1,
                                            child: PieChart(
                                              PieChartData(
                                                //tutto questo gestisce il tocco su ogni parte
                                                  pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                                                    setState(() {
                                                      if (pieTouchResponse.touchInput is FlLongPressEnd ||
                                                          pieTouchResponse.touchInput is FlPanEnd) {
                                                        touchedIndex = -1;
                                                        //inserire la visualizzazione di una determinata sezione di pagina
                                                      } else {
                                                        touchedIndex = pieTouchResponse.touchedSectionIndex;
                                                      }
                                                    });
                                                  }),
                                                  borderData: FlBorderData(
                                                    show: false,
                                                  ),
                                                  sectionsSpace: 1,//spazio tra le partti del cerchio
                                                  centerSpaceRadius: 60, //larghezza del centro
                                                  sections: showingSections()),
                                            ),
                                          ),
                                          /*
                                          ListView.separated(
                                            shrinkWrap: true,
                                            itemBuilder: (context, index){
                                              return ListTile(
                                                leading: CircleAvatar(backgroundColor: color[index],
                                               ),
                                                title: Text(titles[index]),
                                                );
                                                },
                                               separatorBuilder: (context,index){
                                                 return Divider(height: 0);
                                                 },
                                                 itemCount:3)*/
                                    ]
                                   )  
                              ),
                        ),
                      ],
                      ),
                  ),
                ],
             ),
          ),
        ),
    );
  }
}
class MyClipper extends CustomClipper<Path>{
  @override 
  Path getClip(Size size){
    var path= Path();
    path.lineTo(0,size.height-80);
    path.quadraticBezierTo(size.width/2, size.height,size.width, size.height-80);
    path.lineTo(size.width,0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    throw UnimplementedError();
  }
}