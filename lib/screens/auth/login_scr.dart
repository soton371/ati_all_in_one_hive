import 'package:ati_all_in_one_hive/blocs/auth/auth_bloc.dart';
import 'package:ati_all_in_one_hive/configs/my_colors.dart';
import 'package:ati_all_in_one_hive/screens/auth/components/my_painter.dart';
import 'package:ati_all_in_one_hive/screens/dashboard/dashboard_scr.dart';
import 'package:ati_all_in_one_hive/widgets/my_alert_dialog.dart';
import 'package:ati_all_in_one_hive/widgets/my_button.dart';
import 'package:ati_all_in_one_hive/widgets/my_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  double getSmallDiameter(BuildContext context) => MediaQuery.of(context).size.width * 2 / 3;
  double getBigDiameter(BuildContext context) => MediaQuery.of(context).size.width * 7 / 8;
  final TextEditingController emailCon = TextEditingController();
  final TextEditingController passwordCon = TextEditingController();
  bool remember = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: MyColors.scaffoldBg,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if(state is AuthLoadingState){
            myLoader(context, "Please wait..");
          }else if(state is AuthSuccessState){
            Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_)=> const DashboardScreen()));
          }else if(state is AuthFailedState){
            Navigator.pop(context);
            myAlertDialog(context, state.msgT, state.msgC,actions: [
              CupertinoDialogAction(child: const Text('OK'),onPressed:()=> Navigator.pop(context),)
            ]);
          }
        },
        child: Stack(
          children: <Widget>[
            Positioned(
              right: -getSmallDiameter(context) / 3,
              top: -getSmallDiameter(context) / 3,
              child: MyPainter(height: getSmallDiameter(context), width: getSmallDiameter(context)),
            ),
            Positioned(
              left: -getBigDiameter(context) / 4,
              top: -getBigDiameter(context) / 4,
              child: MyPainter(height: getBigDiameter(context), width: getBigDiameter(context)),
            ),
            Positioned(
              right: -getBigDiameter(context) / 2,
              bottom: -getBigDiameter(context) / 2,
              child: Container(
                width: getSmallDiameter(context),
                height: getSmallDiameter(context),
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.deepPurpleAccent),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "\nAti All in One",
                style: TextStyle(fontFamily: "Pacifico", fontSize: 38, color: Colors.white),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ListView(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.fromLTRB(20, 300, 20, 10),
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: emailCon,
                          decoration: InputDecoration(
                              icon: const Icon(
                                CupertinoIcons.mail,
                                color: Colors.grey,
                              ),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade100)),
                              labelText: "Email",
                              enabledBorder: InputBorder.none,
                              labelStyle: const TextStyle(color: Colors.grey)),
                        ),
                        TextField(
                          obscureText: true,
                          controller: passwordCon,
                          decoration: InputDecoration(
                              icon: const Icon(
                                CupertinoIcons.lock,
                                color: Colors.grey,
                              ),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade100)),
                              labelText: "Password",
                              enabledBorder: InputBorder.none,
                              labelStyle: const TextStyle(color: Colors.grey)),
                        )
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                          child: const Text(
                            "FORGOT PASSWORD?",
                            style: TextStyle(color: Colors.deepPurple, fontSize: 11),
                          ))),

                  //for check box remember me
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Checkbox(
                                value:remember,
                                onChanged: (v){
                                  remember = v ?? false;
                                  setState(() {

                                  });
                                }),
                            const Text(
                              'Remember me',
                              style: TextStyle(color: Colors.grey,),
                            )
                          ],
                        ),
                      ),
                  //end check box remember me
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                    child: MyButton(
                        text: "SIGN IN",
                        onPressed: () {
                          context.read<AuthBloc>().add(DoLoginEvent(email: emailCon.text.trim(), password: passwordCon.text.trim(),isRemember: remember));
                        }),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "DON'T HAVE AN ACCOUNT ? ",
                        style: TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        " SIGN UP",
                        style: TextStyle(fontSize: 11, color: Colors.deepPurple, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  const SizedBox(height: 10,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
