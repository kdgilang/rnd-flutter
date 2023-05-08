// import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:purala/pos/widgets/scanner_error_widget.dart';

// class BarcodeScannerWithController extends StatefulWidget {
//   const BarcodeScannerWithController({Key? key}) : super(key: key);

//   @override
//   BarcodeScannerWithControllerState createState() =>
//       BarcodeScannerWithControllerState();
// }

// class BarcodeScannerWithControllerState
//     extends State<BarcodeScannerWithController>
//     with SingleTickerProviderStateMixin {
//   BarcodeCapture? barcode;

//   final MobileScannerController controller = MobileScannerController(
//     torchEnabled: true,
//     formats: [BarcodeFormat.codebar, BarcodeFormat.qrCode],
//     // facing: CameraFacing.front,
//     // detectionSpeed: DetectionSpeed.noDuplicates,
//     detectionTimeoutMs: 1000,
//     // returnImage: false,
//   );

//   bool isStarted = true;

//   void _startOrStop() {
//     try {
//       if (isStarted) {
//         controller.stop();
//       } else {
//         controller.start();
//       }
//       setState(() {
//         isStarted = !isStarted;
//       });
//     } on Exception catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Something went wrong! $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Builder(
//         builder: (context) {
//           return Stack(
//             children: [
//               Expanded(
//                 child: MobileScanner(
//                 controller: controller,
//                 errorBuilder: (context, error, child) {
//                   return ScannerErrorWidget(error: error);
//                 },
//                 fit: BoxFit.contain,
//                 onDetect: (capture) {
//                   setState(() {
//                     this.barcode = capture;
//                   });
//                   final List<Barcode> barcodes = capture.barcodes;
//                   for (final bar in barcodes) {
//                     debugPrint('Barcode found! ${bar.rawValue}');
//                   }
//                 },
//               ),
//               ),
//               Expanded(
//                 child:               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Container(
//                   alignment: Alignment.bottomCenter,
//                   height: 100,
//                   width: double.infinity,
//                   color: Colors.black.withOpacity(0.4),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Expanded(
//                         child:                       ValueListenableBuilder(
//                         valueListenable: controller.hasTorchState,
//                         builder: (context, state, child) {
//                           if (state != true) {
//                             return const SizedBox.shrink();
//                           }
//                           return IconButton(
//                             color: Colors.white,
//                             icon: ValueListenableBuilder(
//                               valueListenable: controller.torchState,
//                               builder: (context, state, child) {
//                                 switch (state) {
//                                   case TorchState.off:
//                                     return const Icon(
//                                       Icons.flash_off,
//                                       color: Colors.grey,
//                                     );
//                                   case TorchState.on:
//                                     return const Icon(
//                                       Icons.flash_on,
//                                       color: Colors.yellow,
//                                     );
//                                 }
//                               },
//                             ),
//                             iconSize: 32.0,
//                             onPressed: () => controller.toggleTorch(),
//                           );
//                         },
//                       ),
//                       ),
//                       Expanded(
//                         child:                       IconButton(
//                         color: Colors.white,
//                         icon: isStarted
//                             ? const Icon(Icons.stop)
//                             : const Icon(Icons.play_arrow),
//                         iconSize: 32.0,
//                         onPressed: _startOrStop,
//                       ),
//                       ),
//                       Expanded(
//                         child:                       Center(
//                         child: SizedBox(
//                           width: MediaQuery.of(context).size.width - 200,
//                           height: 50,
//                           child: FittedBox(
//                             child: Text(
//                               barcode?.barcodes.first.rawValue ??
//                                   'Scan something!',
//                               overflow: TextOverflow.fade,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .headlineMedium!
//                                   .copyWith(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ),
//                       ),
//                       Expanded(
//                         child:                       IconButton(
//                         color: Colors.white,
//                         icon: ValueListenableBuilder(
//                           valueListenable: controller.cameraFacingState,
//                           builder: (context, state, child) {
//                             switch (state) {
//                               case CameraFacing.front:
//                                 return const Icon(Icons.camera_front);
//                               case CameraFacing.back:
//                                 return const Icon(Icons.camera_rear);
//                             }
//                           },
//                         ),
//                         iconSize: 32.0,
//                         onPressed: () => controller.switchCamera(),
//                       ),
//                       ),

//                       // IconButton(
//                       //   color: Colors.white,
//                       //   icon: const Icon(Icons.image),
//                       //   iconSize: 32.0,
//                       //   onPressed: () async {
//                       //     final ImagePicker picker = ImagePicker();
//                       //     // Pick an image
//                       //     final XFile? image = await picker.pickImage(
//                       //       source: ImageSource.gallery,
//                       //     );
//                       //     if (image != null) {
//                       //       if (await controller.analyzeImage(image.path)) {
//                       //         if (!mounted) return;
//                       //         ScaffoldMessenger.of(context).showSnackBar(
//                       //           const SnackBar(
//                       //             content: Text('Barcode found!'),
//                       //             backgroundColor: Colors.green,
//                       //           ),
//                       //         );
//                       //       } else {
//                       //         if (!mounted) return;
//                       //         ScaffoldMessenger.of(context).showSnackBar(
//                       //           const SnackBar(
//                       //             content: Text('No barcode found!'),
//                       //             backgroundColor: Colors.red,
//                       //           ),
//                       //         );
//                       //       }
//                       //     }
//                       //   },
//                       // ),
//                     ],
//                   ),
//                 ),
//               ),
//               )
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';



class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text(
                        'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  else
                    const Text('Scan a code'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return Text('Flash: ${snapshot.data}');
                              },
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Text(
                                      'Camera facing ${describeEnum(snapshot.data!)}');
                                } else {
                                  return const Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.pauseCamera();
                          },
                          child: const Text('pause',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          child: const Text('resume',
                              style: TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.green,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}