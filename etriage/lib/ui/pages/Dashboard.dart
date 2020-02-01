import 'package:etriage/ui/widgets/PatientProfileData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';

import '../../blocs/auth/authentication_bloc.dart';
import '../../blocs/auth/authentication_event.dart';
import '../../defaults.dart';
import '../../models/filestore.dart';
import '../../services/services.dart';
import '../../style.dart';
import '../widgets/DashboardTag.dart';
import 'MapPage.dart';
import 'HealthId.dart';
import 'WellBeing.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String _qrCodeString = "";
  String userName = '';
  var token = '';

  _getResponder() async {
    var authToken = await getStoredCredential();
    var responderUserName = await getResponderProfile(API, authToken);
    setState(() {
      userName = responderUserName.username;
      token = authToken;
    });
  }

  @override
  void initState() {
    super.initState();
    _getResponder();
  }

  @override
  Widget build(BuildContext context) {
    final drawerHeader = UserAccountsDrawerHeader(
      accountName: Text(userName),
      currentAccountPicture: CircleAvatar(
        child: Image.asset(
          'assets/app_logo_design.png',
          height: 42.0,
        ),
        backgroundColor: white,
      ),
    );

    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          title: Text(
            'Map',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          onTap: () => Navigator.of(context)
              .push(new MaterialPageRoute(builder: (context) => MapPage())),
        ),
        ListTile(
          title: Text(
            'Well-being',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          onTap: () => Navigator.of(context)
              .push(new MaterialPageRoute(builder: (context) => WellBeing())),
        ),
        Divider(
          height: 10.0,
        ),
        ListTile(
          title: Text(
            'Health Id',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          onTap: () => Navigator.of(context)
              .push(new MaterialPageRoute(builder: (context) => HealthID())),
        ),
      ],
    );

    Future<void> scanQRCode() async {
      String qrCodeScanRes;
      try {
//        qrCodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//            "#ff6666", "Cancel", true, ScanMode.QR);
        print(qrCodeScanRes);
      } on PlatformException {
        qrCodeScanRes = 'Failed to get platform version.';
      }
      if (mounted && qrCodeScanRes != "") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PatientProfileData(
              qrToken: qrCodeScanRes,
              authToken: token,
            ),
          ),
        );
      }
      setState(() {
        _qrCodeString = qrCodeScanRes;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              GroovinMaterialIcons.logout,
              color: white,
            ),
            color: white,
            splashColor: pink,
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text(
                'Incident Summary',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              child: Text(
                'Incident Call Types',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                  color: grey,
                ),
              ),
              padding: EdgeInsets.only(
                left: 18.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Card(
                      color: off_cyan,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'PHY INJURY',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            CircleAvatar(
                              child: Text(
                                '2',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              backgroundColor: green,
                            ),
                          ],
                        ),
                      ),
                    ),
                    flex: 3,
                  ),
                  Expanded(
                    child: Card(
                      color: off_cyan,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'ADULTS',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            CircleAvatar(
                              child: Text(
                                '1',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              backgroundColor: green,
                            ),
                          ],
                        ),
                      ),
                    ),
                    flex: 3,
                  ),
                ],
              ),
              padding: EdgeInsets.only(
                left: 18.0,
              ),
            ),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Card(
                      color: off_cyan,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'CHILDREN',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            CircleAvatar(
                              child: Text(
                                '0',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              backgroundColor: green,
                            ),
                          ],
                        ),
                      ),
                    ),
                    flex: 3,
                  ),
                  Expanded(
                    child: Card(
                      color: off_cyan,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'BLOOD NEED',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  'O+',
                                  style: TextStyle(
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.w700,
                                    color: red,
                                  ),
                                ),
                                Text(
                                  'B+',
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w700,
                                    color: red_light,
                                  ),
                                ),
                                Text(
                                  'A-',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                    color: pink,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    flex: 3,
                  ),
                ],
              ),
              padding: EdgeInsets.only(
                left: 18.0,
              ),
            ),
            ListTile(
              title: Text(
                'Triage Overview',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            DashboardTag(
              url: API + '/getT4Patients',
              initColor: black,
              expandColor: charcoal_light,
              leadingText: 'T4',
              description: 'Expectant',
            ),
            DashboardTag(
              url: API + '/getT1Patients',
              initColor: red,
              expandColor: red_light,
              leadingText: 'T1',
              description: 'Immediate',
            ),
            DashboardTag(
              url: API + '/getT2Patients',
              initColor: yellow,
              expandColor: yellow_light,
              leadingText: 'T2',
              description: 'Delayed',
            ),
            DashboardTag(
              url: API + '/getT3Patients',
              initColor: green,
              expandColor: green_light,
              leadingText: 'T3',
              description: 'Minimal',
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: drawerItems,
      ),
      floatingActionButton: isMobile(context)
          ? FloatingActionButton.extended(
              onPressed: () => scanQRCode(),
              label: Text(
                "Scan QR",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15.0,
                ),
              ),
              elevation: 2.0,
              splashColor: white,
              isExtended: true,
              backgroundColor: Theme.of(context).accentColor,
              icon: Icon(
                GroovinMaterialIcons.qrcode_scan,
              ),
            )
          : Container(),
    );
  }
}
