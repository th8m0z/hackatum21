import 'package:dio/dio.dart';

class DioUploadService {
  static Future<dynamic> uploadPhotos(String path) async {
    MultipartFile file = await MultipartFile.fromFile(path);

    var formData = FormData.fromMap({
      '': file,
    });

    var response = await Dio()
        .post('http://192.168.178.139:5000/upload_receipt', data: formData);
    print('\n\n');
    print('RESPONSE WITH DIO');
    print(response.data);
    print('\n\n');
    return response.data;
  }
}
