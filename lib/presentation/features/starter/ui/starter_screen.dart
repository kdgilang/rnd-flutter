import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:purala/dependencies.dart';
import 'package:purala/presentation/core/consts/color_constants.dart';
import 'package:purala/models/merchant_model.dart';
import 'package:purala/presentation/features/merchant/bloc/merchant_bloc.dart';
import 'package:purala/presentation/features/merchant/bloc/merchant_event.dart';
import 'package:purala/presentation/features/merchant/bloc/merchant_state.dart';
import 'package:purala/presentation/features/starter/ui/shared/buttons_widget.dart';
import 'package:purala/repositories/merchant_repository.dart';
import 'package:purala/presentation/core/components/image_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class StarterScreen extends StatelessWidget {
  const StarterScreen({super.key});

  static const String routeName = "/starter";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MerchantBloc>(
      create: (context) => sl<MerchantBloc>(),
      child: Scaffold(
        body: BlocBuilder<MerchantBloc, MerchantState>(
          builder: (context, state) {
            return _buildBody(context);
          },
        )
      )
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
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
  );

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0.0, -1.5),
    end: const Offset(0.0, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.linearToEaseOut,
  ));

  @override
  void initState() {
    super.initState();
    context.read<MerchantBloc>().add(FetchData(id: dotenv.get('MERCHANT_ID')));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void initAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _controller.forward()
    .whenComplete(() {
      setState(() {
        isButtonsVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<MerchantBloc, MerchantState>(
      builder: (context, state) {
        if (state is StarterLoading) {
          return Stack(
            alignment: Alignment.center,
            children: [
            SizedBox(
              height: 50,
              width: 50,
              child: LoadingAnimationWidget.fourRotatingDots(
                size: 50,
                color: ColorConstants.secondary,
              )
            )
          ]);
        } else if (state is StarterError) {
          return Text(state.error.toString());
        } else {
          initAnimation();
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlideTransition(
                position: _offsetAnimation,
                child: ImageWidget(
                  height: 100,
                  width: 100,
                  url: state.data?.image?.url
                ),
              ),
              const SizedBox(height: 30,),
              ButtonsWidget(isVisible: isButtonsVisible)
            ],
          );
        }
      },
    );
  }
}