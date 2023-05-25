import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:purala/constants/color_constants.dart';
import 'package:purala/models/merchant_model.dart';
import 'package:purala/repositories/merchant_repository.dart';
import 'package:purala/signin/signin_screen.dart';
import 'package:purala/widgets/image_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class StarterScreen extends StatelessWidget {
  const StarterScreen({super.key});

  static const String routeName = "/starter";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
              flex: 9,
              child: StarterWidget()
            ),
            Expanded(
              flex: 1,
              child: Flex(
                mainAxisAlignment: MainAxisAlignment.center,
                direction: Axis.horizontal,
                children: [
                  const Text("powered by"),
                  TextButton(
                    onPressed: _launchUrl,
                    child: const Text(
                      "Purala",
                      style: TextStyle(color: ColorConstants.secondary),
                    )
                  )
                ]
              ),
            )
          ],
        )
      ),
    );
  }

  Future<void> _launchUrl() async {
    final Uri uri = Uri.parse('https://github.com/kdgilang');
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }
}

class StarterWidget extends StatefulWidget {
  const StarterWidget({super.key});

  @override
  State<StarterWidget> createState() => _StarterWidgetState();
}

class _StarterWidgetState extends State<StarterWidget> with SingleTickerProviderStateMixin {

  bool isButtonsVisible = false;

  final merchantRepository = MerchantRepository();
  late Future<MerchantModel?> futureMerchant;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  )..forward()
    .whenComplete(() {
      setState(() {
        isButtonsVisible = true;
      });
    });

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, -1.5),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.linearToEaseOut,
  ));

  @override
  void initState() {
    super.initState();
    futureMerchant = merchantRepository.getOne(int.parse(dotenv.env['MERCHANT_ID'] ?? ""));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<MerchantModel?>(
      future: futureMerchant,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // context.read<MerchantProvider>().set(snapshot.data);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlideTransition(
                position: _offsetAnimation,
                child: ImageWidget(url: snapshot.data?.media?.url ?? ""),
              ),
              ButtonsWidget(isVisible: isButtonsVisible)
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class ButtonsWidget extends StatelessWidget {
  const ButtonsWidget({ super.key, required this.isVisible });

  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.secondary,
              foregroundColor: ColorConstants.primary,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
              minimumSize: const Size(280, 0),
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              )
            ),
            onPressed: () {
              Navigator.pushNamed(context, SigninScreen.routeName);
            },
            child: const Text('Sign in'),
          ),
          const SizedBox(height: 20,),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white, width: 1),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
              minimumSize: const Size(280, 0),
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              )
            ),
            onPressed: () {},
            child: const Text('Add User'),
          ),
        ],
      ),
    );
  }
}