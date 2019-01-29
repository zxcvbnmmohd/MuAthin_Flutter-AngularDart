import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:muathin_common/src/apis/apis.dart';
import 'package:muathin_common/src/services/crud.dart';

class Auth {
  FirebaseAuth auth = FirebaseAuth.instance;

  login({String email, String password, Function onSuccess, Function onFailure(String e)}) {
    this.auth.signInWithEmailAndPassword(email: email, password: password).then((user) {
      onSuccess();
    }, onError: (e) {
      onFailure(e.toString());
      return;
    });
  }

  Future verifyPhoneNumber({String phone, Function onSuccess(String s), Function onFailure(String e)}) async {
    String verificationID;
    await this.auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 5),
        verificationCompleted: (user) {
          onSuccess(verificationID);
        },
        verificationFailed: (error) {
          onFailure(error.toString());
          return;
        },
        codeSent: (String verificationId, [int forceResendingToken]) async {
          verificationID = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationID = verificationId;
        });
  }

  loginWithPhoneNumber({String phone, String smsCode, Function onSuccess(), Function onFailure(String e)}) async {
    this.verifyPhoneNumber(phone: phone, onSuccess: (verificationID) {
      final AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationID, smsCode: smsCode);
      this.auth.signInWithCredential(credential).then((user) {
        onSuccess();
      });
    }, onFailure: (e) {
      onFailure(e);
      return;
    });
  }

  loginWithFacebook({Function onLogin, Function onRegister(FirebaseUser u), Function onFailure(String e)}) async {
    FacebookLogin facebookLogin = FacebookLogin();
    FacebookLoginResult result = await facebookLogin.logInWithReadPermissions(['email', 'public_profile']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: result.accessToken.token);
        this.auth.signInWithCredential(credential).then((user) {
          CRUD().read(
              ref: APIs().users.usersCollection.document(user.uid),
              onSuccess: (ds) {
                if (ds.exists) {
                  print('USER EXISTS IN FIRESTORE');
                  onLogin();
                } else {
                  print('CREATING USER IN FIRESTORE');
                  Map<String, dynamic> v = {
                    'createdAt': DateTime.now(),
                    'email': user.email,
                    'imageURL': user.photoUrl,
                    'name': user.displayName,
                    'phone': user.phoneNumber,
                    'role': 'customer'
                  };
                  CRUD().create(
                      ref: APIs().users.usersCollection.document(user.uid),
                      map: v,
                      onSuccess: () {
                        onRegister(user);
                      },
                      onFailure: (e) {
                        onFailure(e);
                        return;
                      });
                }
              },
              onFailure: (e) {
                print(e);
              });
        }, onError: (e) {
          onFailure(e.toString());
          return;
        });
        break;
      case FacebookLoginStatus.cancelledByUser:
        onFailure('Cancelled By User');
        break;
      case FacebookLoginStatus.error:
        onFailure('Failed');
        break;
    }
  }

  register({Map<String, dynamic> m, String password, Function onSuccess(FirebaseUser u), Function onFailure(String e)}) {
    this.auth.createUserWithEmailAndPassword(email: m['email'], password: password).then((user) async {
//      StorageReference storeRef = FirebaseStorage.instance.ref().child('users/' + user.uid + '/profile/profile.png');
//      StorageUploadTask task = storeRef.putFile(image, StorageMetadata(contentType: 'image/png'));
//      StorageTaskSnapshot snapshot = await task.onComplete;
//      String imageURL = await snapshot.ref.getDownloadURL();
//      v['imageURL'] = imageURL;

      CRUD().create(
          ref: APIs().users.usersCollection.document(user.uid),
          map: m,
          onSuccess: () {
            onSuccess(user);
          },
          onFailure: (e) {
            onFailure(e);
            return;
          });
    }, onError: (e) {
      onFailure(e.toString());
      return;
    });
  }

  logout({Function onSuccess, Function onFailure(String e)}) async {
    await this.auth.signOut();
//    await FacebookLogin().logOut();

    this.isLoggedIn(onSuccess: (u) {
      onFailure(u.uid);
    }, onFailure: () {
      onSuccess();
    });
  }

  Future isLoggedIn({Function onSuccess(FirebaseUser user), Function onFailure}) async {
    FirebaseUser u = await this.auth.currentUser();
    if (u != null) {
      onSuccess(u);
    } else {
      onFailure();
    }
  }

  Future<String> currentUserID() async {
    FirebaseUser u = await this.auth.currentUser();
    return u.uid;
  }

  isEmailVerified({Function onSuccess, Function onFailure}) {
    this.auth.currentUser().then((user) {
      if (user.isEmailVerified) {
        onSuccess();
      } else {
        onFailure();
      }
    });
  }

  resetPassword({String email, Function onSuccess, Function onFailure(String e)}) {
    this.auth.sendPasswordResetEmail(email: email).then((v) {
      onSuccess();
    }, onError: (e) {
      onFailure(e.toString());
      return;
    });
  }
}
