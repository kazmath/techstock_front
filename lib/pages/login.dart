import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techstock_front/pages/dashboard.dart';
import 'package:techstock_front/pages/tickets_usuario_db.dart';

import '../service/usuario_service.dart';
import '../tools/constants.dart';
import '../tools/exceptions.dart';
import '../tools/utils.dart';
import 'widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String get routeName => "${Constants.baseHrefStripped}/";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  bool isCheckingLogin = true;

  var showPassword = false;

  @override
  void initState() {
    super.initState();
    UsuarioService.usuario.then((usuario) {
      if (usuario == null) {
        setState(() => isCheckingLogin = false);
        return;
      }
      loginSucess();
    });
  }

  void onSubmitDialog() async {
    showDialog(
      context: context,
      builder: (context) => FutureBuilder(
        future: onSubmit(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              var error = snapshot.error;
              if (error is ServiceException) {
                return AlertOkDialog(
                  title: const Text("Erro"),
                  content: Text(error.cause),
                );
              }
              return UnknownErrorDialog(
                exception: error!,
                stacktrace: snapshot.stackTrace!,
              );
            }

            if (snapshot.data ?? false) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                loginSucess();
              });
            } else {
              return const AlertOkDialog(
                title: Text("Erro"),
                content: Text("Falha no login"),
              );
            }
            return Container();
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<bool> onSubmit() async {
    var email = emailController.text;
    var senha = senhaController.text;

    var loginResult = false;
    loginResult = await UsuarioService().login(
      email: email,
      senha: senha,
    );

    return loginResult;
  }

  void loginSucess() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        var usuario = await UsuarioService.usuario;
        var permissions = usuario!.permissions;

        Navigator.pushNamedAndRemoveUntil(
          context,
          permissions!.contains("ROLE_ADMIN")
              ? Dashboard.routeName
              : TicketsUsuario.routeName,
          (_) => false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var fontSize = Theme.of(context).textTheme.bodyMedium!.fontSize!;
    getInputDecoration(String hint, IconData icon) => InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: getColorScheme(context).surface,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black26),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              height: 49,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
                color: getColorScheme(context).surfaceContainer,
              ),
              child: Icon(icon),
            ),
          ),
        );

    return Scaffold(
      backgroundColor: const Color(0xFF1E6297),
      body: Builder(
        builder: (context) {
          if (isCheckingLogin) {
            return const Stack(
              children: [
                ModalBarrier(),
                Center(child: CircularProgressIndicator()),
              ],
            );
          }

          return Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                "assets/images/fundo.png",
                opacity: const AlwaysStoppedAnimation(.2),
                fit: BoxFit.cover,
              ),
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * (2 / 5),
                  width: MediaQuery.of(context).size.height * (1 / 3),
                  constraints: BoxConstraints(
                    minHeight: fontSize * 42,
                    minWidth: fontSize * 40,
                  ),
                  color: getColorScheme(context).surface,
                  padding: const EdgeInsets.all(50.0),
                  child: Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset("assets/images/image.png"),
                        Center(
                          child: Text(
                            "LOGIN",
                            style: GoogleFonts.rubik(
                              color: getColorScheme(context).primary,
                              fontSize: 38,
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          decoration: getInputDecoration("Email", Icons.person),
                        ),
                        TextFormField(
                          controller: senhaController,
                          textInputAction: TextInputAction.send,
                          onFieldSubmitted: (_) => onSubmitDialog(),
                          obscureText: !showPassword,
                          decoration:
                              getInputDecoration("Senha", Icons.lock).copyWith(
                            suffixIcon: IconButton(
                              onPressed: () => setState(
                                () => showPassword = !showPassword,
                              ),
                              icon: showPassword
                                  ? Icon(Icons.visibility_off_outlined)
                                  : Icon(Icons.visibility_outlined),
                            ),
                          ),
                        ),
                        FilledButton(
                          onPressed: onSubmitDialog,
                          style: const ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "LOGIN",
                              style: GoogleFonts.rubik(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .fontSize!,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
