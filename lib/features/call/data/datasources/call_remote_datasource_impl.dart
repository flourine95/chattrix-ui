import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/errors/exceptions.dart';
import 'package:chattrix_ui/features/call/data/models/call_connection_model.dart';
import 'package:chattrix_ui/features/call/data/models/call_info_model.dart';
import 'package:chattrix_ui/features/call/domain/datasources/call_remote_datasource.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_end_reason.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_reject_reason.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';
import 'package:dio/dio.dart';

class CallRemoteDataSourceImpl implements CallRemoteDataSource {
  final Dio dio;

  CallRemoteDataSourceImpl({required this.dio});

  @override
  Future<CallConnectionModel> initiateCall({required int calleeId, required CallType callType}) async {
    try {
      final response = await dio.post(
        ApiConstants.initiateCall,
        data: {'calleeId': calleeId, 'callType': callType.name.toUpperCase()},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return CallConnectionModel.fromJson(response.data['data']);
      } else {
        throw ServerException(message: response.data['message'] ?? 'Failed to initiate call');
      }
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Network error occurred');
    }
  }

  @override
  Future<CallConnectionModel> acceptCall({required String callId}) async {
    try {
      final response = await dio.post(ApiConstants.acceptCall(callId));

      if (response.statusCode == 200) {
        return CallConnectionModel.fromJson(response.data['data']);
      } else {
        throw ServerException(message: response.data['message'] ?? 'Failed to accept call');
      }
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Network error occurred');
    }
  }

  @override
  Future<CallInfoModel> rejectCall({required String callId, required CallRejectReason reason}) async {
    try {
      final response = await dio.post(ApiConstants.rejectCall(callId), data: {'reason': reason.name});

      if (response.statusCode == 200) {
        return CallInfoModel.fromJson(response.data['data']);
      } else {
        throw ServerException(message: response.data['message'] ?? 'Failed to reject call');
      }
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Network error occurred');
    }
  }

  @override
  Future<CallInfoModel> endCall({required String callId, required CallEndReason reason}) async {
    try {
      final response = await dio.post(ApiConstants.endCall(callId), data: {'reason': reason.name});

      if (response.statusCode == 200) {
        return CallInfoModel.fromJson(response.data['data']);
      } else {
        throw ServerException(message: response.data['message'] ?? 'Failed to end call');
      }
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Network error occurred');
    }
  }
}
