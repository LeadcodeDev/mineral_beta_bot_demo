import 'package:hexagonal_bot_test/domain.dart';
import 'package:mineral/services.dart';

final class PlaceholderHttpClient extends HttpClient implements PlaceholderClientContract {
  PlaceholderHttpClient()
      : super(config: HttpClientConfigImpl(baseUrl: 'https://jsonplaceholder.typicode.com'));
}
