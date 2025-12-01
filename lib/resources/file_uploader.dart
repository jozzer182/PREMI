import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;
import 'env_config.dart';

class FileUploadToDrive {
  static Future<String> uploadAndGetUrl({
    required PlatformFile file,
    String? carpeta,
  }) async {
    Uri url = EnvConfig.apiPremiUri;
    var bytes = file.bytes!;
    var s = base64.encode(bytes);
    final mimeType = lookupMimeType('.${file.extension!}');
    var dataSend = {
      'info': {
        'folder': carpeta??"Adjuntos",
        'data': s,
        'name': file.name,
        'type': mimeType,
      },
      'fname': "upload"
    };
    // print(jsonEncode(dataSend));
    var response = await http.post(url, body: jsonEncode(dataSend));
    // print(response.body);
    var data = jsonDecode(response.body) ?? 'Error';
    // print(data['url']);
    return data.toString();
  }
}
