import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import 'join_request_service.dart';

/// Who may call: anyone. Rate limited per IP.
class JoinRequestEndpoint extends Endpoint {
  static final _joins = JoinRequestService();

  Future<JoinRequest> submit(
    Session session,
    String hospitalName,
    String contactName,
    String phone,
    String area, {
    String? message,
  }) {
    return _joins.submit(
      session,
      hospitalName: hospitalName,
      contactName: contactName,
      phone: phone,
      area: area,
      message: message,
    );
  }
}
