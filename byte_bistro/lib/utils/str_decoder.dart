import 'dart:convert';

class BaseSixtyFour {
  static String b64decode(String encoded) {
    for (int i = 0; i < (encoded.length % 4); i++) {
      encoded += '=';
    }
    return utf8.decode(base64.decode(encoded));
  }
}

void main() {
  print(BaseSixtyFour.b64decode(
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyN2ZiZmExZDQ2NGZmYmViODBiOTg1YiIsInVzZXJuYW1lIjoic2FuamliIiwiaWF0IjoxNjU1NjMzODk0LCJleHAiOjE2NTU4MDY2OTR9.3gz8d3VrjD5l61OiM7bbNY0_Eu0uOMqx8Ain7FaaNJY'));
}
