import 'package:hooks_riverpod/hooks_riverpod.dart';

export 'providers.dart';

class ProviderService {
  static final ProviderService instance = ProviderService._privateConstructor();

  ProviderContainer container = ProviderContainer();

  ProviderService._privateConstructor() {
    print("Starting Settings Service");
  }
}
