import 'provider.dart';
import 'package:provider/provider.dart';

class Utils {
  static ProviderModel provider(context, {bool listen = true}) =>
      Provider.of<ProviderModel>(context, listen: listen);
}
