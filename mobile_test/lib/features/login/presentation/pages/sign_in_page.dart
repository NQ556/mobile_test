import 'package:flutter/material.dart';
import 'package:mobile_test/core/common/widget/rounded_button.dart';
import 'package:mobile_test/core/utils/asset_manager.dart';
import 'package:mobile_test/core/utils/color_manager.dart';
import 'package:mobile_test/core/utils/string_manager.dart';
import 'package:mobile_test/features/login/presentation/widgets/auth_input.dart';
import 'package:mobile_test/features/login/presentation/widgets/character_column.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: CharacterColumn(
                        text: StringManager.japaneseName,
                        textStyle: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                  ),

                  //
                  Image.asset(
                    AssetManager.sushi,
                    width: 266,
                    height: 266,
                  ),
                ],
              ),

              //
              SizedBox(
                height: 30,
              ),

              //
              Text(
                StringManager.appName,
                style: Theme.of(context).textTheme.headlineLarge,
              ),

              //
              Text(
                StringManager.slogan,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: ColorManager.primary),
              ),

              //
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      //
                      AuthInput(
                        hintText: StringManager.email,
                        textEditingController: emailController,
                      ),

                      //
                      SizedBox(
                        height: 20,
                      ),

                      //
                      AuthInput(
                        hintText: StringManager.password,
                        textEditingController: passwordController,
                        isObscure: true,
                      ),
                    ],
                  ),
                ),
              ),

              //
              SizedBox(
                height: 30,
              ),

              //
              RoundedButton(
                buttonText: StringManager.signIn,
                backgroundColor: ColorManager.primary,
                textColor: Colors.white,
              )
            ],
          ),
        ),
      ),
      backgroundColor: ColorManager.background,
    );
  }
}
