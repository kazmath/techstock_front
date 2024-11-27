import '../tools/constants.dart';
import '../tools/exceptions.dart';
import '../tools/utils.dart';

class DashboardService {
  Future<Map<String, dynamic>?> get() async {
    var response = await apiRequest(
      "${Constants.apiURL}/dashboard",
      method: 'get',
    );

    Map<String, dynamic>? responseBody;
    List<String> responseErrors;

    (responseBody, responseErrors) =
        destructureResponse<Map<String, dynamic>>(response);

    if (responseErrors.isNotEmpty) {
      throw ServiceException(responseErrors.join(","));
    }

    var items = responseBody;

    return items;
  }
}
