import 'package:image_picker/image_picker.dart';
import 'package:money_care/core/constants/api_routes.dart';
import 'package:money_care/models/response/scan_response.dart';
import 'api_service.dart';

class ScanReceiptService {
  final ApiService api;

  ScanReceiptService({required this.api});

  Future<ScanResponse> scanReceipt(XFile image) async {
    try {
      final res = await api.postMultipart<ScanResponse>(
        ApiRoutes.scanReceipt,
        file: image,
        fromJsonT: (json) => ScanResponse.fromJson(json),
      );

      if (!res.success || res.data == null) {
        throw Exception(res.message);
      }
      return res.data!;
    } catch (e) {
      throw Exception('Quét hoá đơn thất bại: $e');
    }
  }
}
