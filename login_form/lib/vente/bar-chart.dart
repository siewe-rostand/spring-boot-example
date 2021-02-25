import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:login_form/model/vente-model.dart';
import 'package:login_form/product/save-product.dart';
import 'package:login_form/vente/vente-services.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:syncfusion_flutter_charts/charts.dart';

import '../login-data.dart';

class BarChartPage extends StatefulWidget {
  final OrderedProducts orderedProducts;
  BarChartPage({this.orderedProducts});
  @override
  _BarChartPageState createState() => _BarChartPageState();
}

class _BarChartPageState extends State<BarChartPage> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 7;

  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex;

  List<OrderedProducts> detail = [];
  List<OrderedProducts> _barChartList;
  getUserDetails(
      int storeId, String createdDateFrom, String createdDateTo) async {
    String url =
        "$server_ip/api/ventes-by-product/$storeId/?createdDateFrom=$createdDateFrom&createdDateTo=$createdDateTo";
    Response result = await get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'authorization': 'Bearer $token'
      },
    );
    var responseJson = json.decode(result.body);

    setState(() {
      for (Map i in responseJson) {
        detail.add(OrderedProducts.fromJson(i)); // Deserialization step 3
      }
    });
  }

  @override
  void initState() {
    final DateTime now = DateTime.now();
    final lastMidnight = new DateTime.utc(now.year, now.month, 1);
    final DateFormat formatter = DateFormat('dd/MM/yyyy - HH:mm');
    final DateFormat formatter1 = DateFormat('yyyy-MM-dd').add_Hm();
    final String formatted = formatter.format(lastMidnight);
    final String formatted1 = formatter1.format(lastMidnight);

    final newDate = new DateTime.utc(
      now.year,
      now.month + 1,
    ).subtract(Duration(days: 1));
    final String newFormatted = formatter.format(newDate);
    final String newFormatted1 = formatter1.format(newDate);
    var items = getUserDetails(2, formatted1, newFormatted1);
    print(items);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final lastMidnight = new DateTime.utc(now.year, now.month, 1);
    final DateFormat formatter = DateFormat('dd/MM/yyyy - HH:mm');
    final DateFormat formatter1 = DateFormat('yyyy-MM-dd').add_Hm();
    final String formatted = formatter.format(lastMidnight);
    final String formatted1 = formatter1.format(lastMidnight);

    final newDate = new DateTime.utc(
      now.year,
      now.month + 1,
    ).subtract(Duration(days: 1));
    final String newFormatted = formatter.format(newDate);
    final String newFormatted1 = formatter1.format(newDate);
    return Scaffold(
      appBar: AppBar(),
      body: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          // Chart title
          title: ChartTitle(text: 'Sale\'s benefit !'),
          // Enable legend
          legend: Legend(
            isVisible: true,
          ),
          // Enable tooltip
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <ChartSeries<OrderedProducts, dynamic>>[
            ColumnSeries<OrderedProducts, dynamic>(
              dataSource: detail, // Deserialized Json data list.
              xValueMapper: (OrderedProducts sales, _) => sales.productName,
              yValueMapper: (OrderedProducts sales, _) =>
                  sales.totalVentes.ceil(),
              selectionBehavior: SelectionBehavior(
                  // Enables the selection
                  enable: true),
              // Enable data label
              dataLabelSettings: DataLabelSettings(isVisible: true),
            ),
            ColumnSeries<OrderedProducts, dynamic>(
                dataSource: detail, // Deserialized Json data list.
                xValueMapper: (OrderedProducts sales, _) => sales.productName,
                yValueMapper: (OrderedProducts sales, _) =>
                    sales.benefice.ceil(),
                // Enable data label
                dataLabelSettings: DataLabelSettings(isVisible: true)),
          ]),
    );
  }

  Widget _buildFinancialList(series) {
    return _barChartList != null
        ? ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => Divider(
              color: Colors.white,
              height: 5,
            ),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: _barChartList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: MediaQuery.of(context).size.height / 2.3,
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_barChartList[index].totalVentes.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Expanded(child: charts.BarChart(series, animate: true)),
                  ],
                ),
              );
            },
          )
        : SizedBox();
  }
}
