import 'package:app2021/app/modules/home/views/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final count = 0.obs;

  @override
  void onInit() {}

  @override
  void onReady() {}

  @override
  void onClose() {}

  // bool _checking = true;
  UserCredential user;
  GoogleSignIn userGoogle;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']); //.signIn();
  setuserGoogle(GoogleSignIn value) => userGoogle = value;

  GoogleSignIn get getuserGoogle => userGoogle;

  UserCredential userFace;

  setUser(UserCredential value) => user = value;

  Future loginWithGoogle() async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;

      // final GoogleSignInAuthentication googleAuth =
      await _googleSignIn.signIn();
      //    googleUser.authentication;
      final GoogleAuthCredential googleAuthCredential =
          GoogleAuthProvider.credential(
              //   accessToken: _googleSignIn.,
              // idToken: googleAuth.idToken,
              );
      var userCredential =
          await _auth.signInWithCredential(googleAuthCredential);
      if (userCredential?.user != null) {
        user = userCredential;
      } else {
        user = null;
      }
    } catch (e) {
      print(e);
    }
  }

  Future loginWithFacebook() async {
    userFace = await signInWithFacebook();
    // _authrepository.getFacebookLogin();
  }

  Future<UserCredential> signInWithFacebook() async {
    // // Trigger the sign-in flow
    // AccessToken result;
    // await FacebookAuth.instance.login().then(
    //       (value) => result = value.accessToken,
    //     );

    // // Create a credential from the access token
    // final FacebookAuthCredential facebookAuthCredential =
    //     FacebookAuthProvider.credential(result.token);

    // // Once signed in, return the UserCredential
    // var ret;
    // try {
    //   ret = await FirebaseAuth.instance
    //       .signInWithCredential(facebookAuthCredential);
    // } catch (e) {
    //   print(e);
    // }
    // return ret;
  }

  // Future<void> _checkIfIsLogged() async {
  //   final AccessToken accessToken = await FacebookAuth.instance.isLogged;
  //   //   setState(() {
  //   _checking = false;
  //   //   });
  //   if (accessToken != null) {
  //     //  print("is Logged:::: ${prettyPrint(accessToken.toJson())}");
  //     // now you can call to  FacebookAuth.instance.getUserData();
  //  //   final userData = await FacebookAuth.instance.getUserData();
  //     // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
  //  //   _accessToken = accessToken;
  //     //   setState(() {
  //   //  _userData = userData;
  //     //   });
  //   }
  // }

  GoogleSignIn googleSignIn =
      GoogleSignIn(scopes: ['email']); //initialization with scope as Email
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future google_signIn() async {
    print('VAI LOGAR --');
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    print(3);
    print(GoogleSignInAccount);
    print(
      'passou',
    ); //calling signIn method // this will open a dialog pop where user can select his email id to signin to the app
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, //create a login credential
        accessToken: googleAuth.accessToken);
    user = null;
    user = await _auth.signInWithCredential(credential);
    // UserCredential u = (await _auth.signInWithCredential(credential).then(
    //       (value) => return value, //googleUser = user;
    //     ));
    //print(        user); //if credential success, then using _auth signed in user data will be stored
  }
}
