import 'package:get/get.dart';
import 'network_binding.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    NetworkBinding().dependencies();
  }
}