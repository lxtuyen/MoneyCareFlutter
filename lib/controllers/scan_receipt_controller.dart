import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_care/services/scan_receipt_service.dart';
import '../models/response/scan_response.dart';

class ScanReceiptController extends GetxController {
  final ScanReceiptService service;

  ScanReceiptController({required this.service});

  final isScanning = false.obs;
  final errorMessage = ''.obs;

  final scanResult = Rxn<ScanResponse>();

  final ImagePicker picker = ImagePicker();

  Future<ScanResponse?> scan(ImageSource source) async {
    if (isScanning.value) return null;

    isScanning.value = true;
    errorMessage.value = '';

    try {
      final image = await picker.pickImage(source: source, imageQuality: 80);

      if (image == null) return null;

      final res = await service.scanReceipt(image);

      scanResult.value = res;

      return res;
    } catch (e) {
      errorMessage.value = e.toString();
      scanResult.value = null;
      return null;
    } finally {
      isScanning.value = false;
    }
  }
}
