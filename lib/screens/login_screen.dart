import 'package:dr_app/blocs/auth/auth_bloc.dart';
import 'package:dr_app/blocs/content_state_status.dart';
import 'package:dr_app/components/buttons/solid_button.dart';
import 'package:dr_app/components/input_field.dart';
import 'package:dr_app/components/top_bar.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/screens/signup_screen.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:dr_app/utils/dialogs.dart';
import 'package:dr_app/utils/images.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

/// The LoginScreen displays an input form which
/// allows users to authenticate using their account credentials.
class LoginScreen extends StatefulWidget {
  static const id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const headerHeightFactor = 0.28;
  static const footerHeightFactor = 0.28;
  static const shapeBorderRadius = Radius.elliptical(720, 360);

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<State<LoginScreen>> _keyLoader =
      new GlobalKey<State<LoginScreen>>();

  AuthBloc _authBloc;
  Map<String, String> formData;

  void onLogInButtonPressed() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _authBloc.add(LogInRequested(formData['email'], formData['password']));
      Dialogs.showLoadingDialog(context, _keyLoader);
    }
  }

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
    formData = {
      'email': null,
      'password': null,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: LUTheme.of(context).backgroundColor,
        child: Stack(
          children: <Widget>[
            _LoginBackgroundShape(
                shapeBorderRadius: shapeBorderRadius,
                context: context,
                headerHeightFactor: headerHeightFactor),
            Align(
              alignment: Alignment.bottomCenter,
              child: _LoginBackgroundShape(
                  invert: true,
                  shapeBorderRadius: shapeBorderRadius,
                  context: context,
                  headerHeightFactor: footerHeightFactor),
            ),
            SafeArea(
                child: LUTopBar(
              icon: Icons.close,
              onNavigationButtonPressed: () => Navigator.of(context).pop(),
            )),
            buildLoginBody(),
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Don't have an account?",
                        style: Styles.loginFooterText,
                      ),
                      FlatButton(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 4.0),
                        onPressed: () =>
                            Navigator.of(context).pushNamed(SignUpScreen.id),
                        child: Text(
                          'Sign Up',
                          style: Styles.loginFooterText
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildLoginBody() {
    final bodySize = (1 - headerHeightFactor - footerHeightFactor);

    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        height: MediaQuery.of(context).size.height * bodySize,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Login',
              style: Styles.topBarTitle
                  .copyWith(color: LUTheme.of(context).primaryColor),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    LUInputField(
                        fieldTitle: 'Email',
                        hintText: 'amanda@email.com',
                        validator: (value) {
                          if (!isEmail(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          formData['email'] = value;
                        },
                        keyboardType: TextInputType.emailAddress),
                    LUInputField(
                        obscureText: true,
                        fieldTitle: 'Password',
                        hintText: '123456',
                        onSaved: (String value) {
                          formData['password'] = value;
                        },
                        keyboardType: TextInputType.text),
                  ],
                ),
              ),
            ),
            Center(
              child: Column(
                children: <Widget>[
                  BlocConsumer<AuthBloc, AuthenticationState>(
                    listenWhen: (previous, current) =>
                        previous.operationStatus != current.operationStatus,
                    listener: (context, state) {
                      if (state.operationStatus ==
                              ContentStateStatus.loadSuccess &&
                          state.status == AuthenticationStatus.authenticated) {
                        Navigator.of(_keyLoader.currentContext,
                                rootNavigator: true)
                            .pop();
                        Navigator.of(context).pop();
                      }
                    },
                    builder: (context, state) => LUSolidButton(
                      title: 'Login',
                      onPressed: () => onLogInButtonPressed(),
                    ),
                  ),
                  // FlatButton(
                  //   onPressed: () => Navigator.of(context)
                  //       .pushNamed(PasswordRecoveryScreen.id),
                  //   child:
                  //       Text('Forgot password?', style: Styles.loginFooterText),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginBackgroundShape extends StatelessWidget {
  final Radius shapeBorderRadius;
  final BuildContext context;
  final double headerHeightFactor;
  final bool invert;

  const _LoginBackgroundShape({
    Key key,
    @required this.shapeBorderRadius,
    @required this.context,
    @required this.headerHeightFactor,
    this.invert = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = invert
        ? BorderRadius.only(topLeft: shapeBorderRadius)
        : BorderRadius.only(bottomRight: shapeBorderRadius);

    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, invert ? -2 : 2), // changes position of shadow
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          height: MediaQuery.of(context).size.height * headerHeightFactor,
          color: LUColors.yellow,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                  child: Image.asset(Images.homeHeaderBackground,
                      fit: BoxFit.cover)),
            ],
          ),
        ),
      ),
    );
  }
}
