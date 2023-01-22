import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_diet_app_onboarding/Screens/about_you.dart';

enum Auth{
 login,
 signup
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {

   double height = 100;
   double width = 100;

  late TextEditingController mailEditingController;
  late TextEditingController passwordEditingController;
  late AnimationController signupAnimationController;
  late AnimationController loginAnimationController;
  late Animation signupAnimation;
  late Animation loginAnimation;

  initializeLogin(){
    loginAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
        vsync: this
    );

    loginAnimation = CurvedAnimation(
        parent: loginAnimationController,
        curve: Curves.easeInOut,
    );
  }

  initializeSignup(){
    signupAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this
    );

    signupAnimation = CurvedAnimation(
        parent: signupAnimationController,
        curve: Curves.easeInOut
    );
  }

  @override
  void initState(){
    super.initState();

    mailEditingController = TextEditingController();
    passwordEditingController = TextEditingController();
  }


   Auth auth = Auth.signup;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Text('Welcome!', style: GoogleFonts.rubik(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 80,),
          Container(
            width: size.width,
            height: size.height * .28,
            child: Stack(
              children: [

                AuthAnimationItem(
                  top: auth == Auth.login ? 0.0 : 25,
                  left: 70,
                  text: 'LOGIN',
                  textColor: auth == Auth.login ? Colors.white : Colors.black,
                  backgroundColor: auth == Auth.login ? Colors.blue : Colors.white,
                  onPressed: () {
                    setState(() {
                      auth = Auth.login;
                    });
                  },
                ),

                Positioned(
                  top: auth == Auth.login ? 36 : 70,
                    left: 90,
                    child: Visibility(
                      visible: auth == Auth.login ? true : false,
                        child: Image.asset('images/up-man.png'))
                ),
                Positioned(
                    top: auth == Auth.signup ? 36 : 70,
                    left: 290,
                    child: Visibility(
                        visible: auth == Auth.signup ? true : false,
                        child: Image.asset('images/up-man.png'))
                ),

                AuthAnimationItem(
                  top: auth == Auth.signup ? 0.0 : 25,
                  left: 270,
                  text: 'SIGNUP',
                  textColor: auth == Auth.signup ? Colors.white : Colors.black,
                  backgroundColor: auth == Auth.signup ? Colors.blue : Colors.white,
                  onPressed: () {
                    setState(() {
                      auth = Auth.signup;
                    });
                  },
                ),

                Positioned(
                  top: 80,
                  left: 20,
                  child: Container(
                    height: size.height * .18,
                    width: size.width * .9,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.2),
                      borderRadius: BorderRadius.circular(30)
                    ),
                  ),
                ),

                Positioned(
                  top: 94,
                    left: 30,
                    child: Container(
                      height: size.height * .14,
                      width: size.width * .85,
                      decoration: BoxDecoration(
                        color : Colors.white,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 7),
                            InputWidget(mailEditingController: mailEditingController),
                            Row(
                              children: [
                                InputWidget(mailEditingController: passwordEditingController),
                                const SizedBox(width: 10,),
                                Text('Forget?',style: GoogleFonts.rubik(color: Colors.green ,fontSize: 15),),
                                const SizedBox(width: 10,)
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                )
              ],
            ),
          ),
          const SizedBox(height: 20,),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutYou()));
            },
            child: Container(
              height: 100,
              width: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey.withOpacity(.1)
              ),
              child: Center(
                  child: Container(
                    height: 70,
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white
                    ),
                    child: const Center(
                        child: Icon(Icons.arrow_forward, size: 30, color: Colors.black,)
                    ),
                  )
              ),
            ),
          ),
          SizedBox(height: size.height * .2,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .11),
            child: Column(
              children: [
                Container(
                  height: 20,
                  width: size.width * .8,
                  child: Row(
                    children: [
                      Container(
                        height: 2,
                        width: size.width * .2,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 15,),
                     Text('SOCIAL LOGIN', style: GoogleFonts.rubik(fontWeight: FontWeight.bold, fontSize: 16),),
                      const SizedBox(width: 20,),
                      Container(
                        height: 2,
                        width: size.width * .2,
                        color: Colors.black,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 15,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .334),
            child: Row(
              children:  [
                Image.asset('images/google.png'),
                const SizedBox(width: 30,),
                Image.asset('images/facebook.png'),
              ],
            ),
          ),
          const SizedBox(height: 15,)
        ],
      ),
    );
  }
}

class InputWidget extends StatelessWidget {
  const InputWidget({
    Key? key,
    required this.mailEditingController,
  }) : super(key: key);

  final TextEditingController mailEditingController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .65,
      child: TextField(
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
        ),
        controller: mailEditingController,
      ),
    );
  }
}

class AuthAnimationItem extends StatelessWidget {
  final double top;
  final double left;
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const AuthAnimationItem({super.key, required this.top, required this.left, required this.text, required this.textColor, required this.backgroundColor, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: top,
        left: left,
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
              height: 35,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: backgroundColor
              ),
              child: Center(child: Text(text,style: GoogleFonts.rubik(
                  fontWeight: FontWeight.w500,
                  color: textColor,
                  fontSize: 15),))
          ),
        )
    );
  }
}


class WeightBackground extends StatelessWidget {
  final Widget child;

  const WeightBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(244, 244, 244, 1.0),
            borderRadius:
            BorderRadius.circular(50),
          ),
          child: child,
        ),
      ],
    );
  }
}

