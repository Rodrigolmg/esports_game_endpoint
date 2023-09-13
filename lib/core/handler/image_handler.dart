part of core;

class ImageHandler {
  static Uint8List convertBase64(String base64String)
    => base64Decode(base64String);
}