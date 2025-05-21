import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../auth/auth_cubit.dart';

class CartPage extends StatelessWidget {

  CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AppAuthState>(
        builder: (context, authState) {
          return Scaffold(
            body: Center(
                child: authState is AuthAuthenticated


                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("UserCart")

                  ],
                )


                    : Text(
              "Войдите или зарегистрируйтесь,\nчтобы совершать покупки",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
              ),
            )
            ),
          );
        }
    );
  }
}