import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import 'first_aid_service.dart';

/// Who may call: anyone.
class FirstAidEndpoint extends Endpoint {
  Future<List<FirstAidCard>> cards(Session session) async =>
      FirstAidService.cards();
}
