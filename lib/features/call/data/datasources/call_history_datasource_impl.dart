import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/features/call/data/datasources/call_history_datasource.dart';
import 'package:chattrix_ui/features/call/data/models/call_history_model.dart';

class CallHistoryDataSourceImpl implements CallHistoryDataSource {
  final Dio dio;

  CallHistoryDataSourceImpl(this.dio);

  @override
  Future<List<CallHistoryModel>> getCallHistory({String? filter}) async {
    final url = filter != null
        ? ApiConstants.callHistoryWithFilter(filter)
        : ApiConstants.callHistory;

    debugPrint('📞 Fetching call history from: $url');
    final response = await dio.get(url);
    
    debugPrint('📞 Call history response: ${response.data}');
    
    final data = response.data['data'] as List;
    debugPrint('📞 Call history data list length: ${data.length}');
    
    if (data.isNotEmpty) {
      debugPrint('📞 First call history item: ${data.first}');
    }
    
    return data.map((json) => CallHistoryModel.fromJson(json as Map<String, dynamic>)).toList();
  }
}
