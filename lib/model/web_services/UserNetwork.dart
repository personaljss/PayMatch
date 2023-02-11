import 'dart:convert';
import '../../constants/network_constants.dart';
import 'package:http/http.dart' as http;

class UserNetwork{
  static Future<Map<String,List<String>>> fetchGroupData(int usercode) async {
      Uri url=Uri.parse(ApiAdress.server+ApiAdress.lists);
      final response = await http.post(url, body: {
        "usercode": usercode,
      });

      final responseData = jsonDecode(response.body);
      Map<String,List<String>> lists = {};
      List data = responseData["groupdata"];
      data.forEach((element) {
        String groupname = element["groupname"];
        String symbol = element["symbol"];
        lists.putIfAbsent(groupname, () => []).add(symbol);
      });
      return lists;
  }

}
