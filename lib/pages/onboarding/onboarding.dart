import 'package:flutter/material.dart';

import '../bottom_navigation.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 14, bottom: 14),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Consigue las mejores",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 26, height: 1.8),
                      ),
                      TextSpan(
                        text: "\ncompras ",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 26,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                      TextSpan(
                        text: "aquí",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 26),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                "Obtiene increibles precios\nexclusivos! en nuestra plataforma",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: 60,
                margin: const EdgeInsets.symmetric(horizontal: 35),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CustomBottomNavigation(),
                      ),
                    );
                  },
                  child: Text(
                    "Comenzar a comprar",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
