import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.9),
      body: Center(
        child: Column(
          children: [
            Card(),
          ],
        ),
      ),
    );
  }

  Widget Card() {
    return Container(
      width: getWidth(context, 95),
      margin: EdgeInsets.symmetric(
          vertical: getHeight(context, 2), horizontal: getWidth(context, 1)),
      padding: EdgeInsets.symmetric(
          vertical: getHeight(context, 1), horizontal: getWidth(context, 1)),
      decoration: BoxDecoration(
        color: const Color(0xff212025),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.5),
            // color: Colors.deepPurple.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          SfCircularChart(
            series: <RadialBarSeries<RadialData, String>>[
              RadialBarSeries<RadialData, String>(
                trackColor: Colors.grey[200]!,
                trackOpacity: 0.2,
                gap: "15%",
                radius: "100%",
                innerRadius: "50%",
                maximumValue: 100,
                dataSource: <RadialData>[
                  RadialData(100 * 100 / 1000, 'Calories', Colors.red[400]!),
                  RadialData(
                      1.7 * 100 / 10, 'Total Kms', const Color(0xff01ddb1)),
                  RadialData(
                      2000 * 100 / 10000, 'Steps', const Color(0xff679cf7)),
                ],
                xValueMapper: (RadialData data, _) => data.xData,
                yValueMapper: (RadialData data, _) => data.yData,
                pointColorMapper: (RadialData data, _) => data.color,
                useSeriesColor: true,
                cornerStyle: CornerStyle.bothCurve,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.gripfire, color: Colors.red[400]),
                  SizedBox(width: getWidth(context, 1.5)),
                  const Text("Cal", style: TextStyle(color: Color(0xfff4f4f6)))
                ],
              ),
              SizedBox(width: getWidth(context, 5)),
              Row(
                children: [
                  const Icon(
                    Icons.directions_walk,
                    color: Color(0xff01ddb1),
                  ),
                  SizedBox(width: getWidth(context, 1.5)),
                  const Text("Km", style: TextStyle(color: Color(0xfff4f4f6)))
                ],
              ),
              SizedBox(width: getWidth(context, 5)),
              Row(
                children: [
                  const FaIcon(FontAwesomeIcons.shoePrints,
                      color: Color(0xff679cf7)),
                  SizedBox(width: getWidth(context, 1.5)),
                  const Text("Steps",
                      style: TextStyle(color: Color(0xfff4f4f6)))
                ],
              ),
            ],
          ),
          SizedBox(height: getHeight(context, 5)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text("100",
                      style: TextStyle(
                          color: Colors.red[400], fontWeight: FontWeight.w500)),
                  SizedBox(width: getWidth(context, 1.5)),
                  const Text("Kcal", style: TextStyle(color: Color(0xfff4f4f6)))
                ],
              ),
              Column(
                children: [
                  const Text("1.7",
                      style: TextStyle(
                          color: Color(0xff01ddb1),
                          fontWeight: FontWeight.w500)),
                  SizedBox(width: getWidth(context, 1.5)),
                  const Text("Kms", style: TextStyle(color: Color(0xfff4f4f6)))
                ],
              ),
              Column(
                children: [
                  const Text("2000",
                      style: TextStyle(
                          color: Color(0xff679cf7),
                          fontWeight: FontWeight.w500)),
                  SizedBox(width: getWidth(context, 1.5)),
                  const Text("Steps",
                      style: TextStyle(color: Color(0xfff4f4f6)))
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  double getWidth(BuildContext context, double percentage) {
    return MediaQuery.sizeOf(context).width * percentage / 100;
  }

  double getHeight(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * percentage / 100;
  }
}

class RadialData {
  final num yData;
  final String xData;
  final Color color;

  RadialData(this.yData, this.xData, [this.color = Colors.blue]);
}