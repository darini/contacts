import 'package:contacts/android/services/ilocal-auth.service.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthenticationService extends ILocalAuthService {
  final _localAuthentication = LocalAuthentication();

  @override
  Future<bool> checkBiometrics() async {
    //return await _localAuthentication.canCheckBiometrics;
    return await _localAuthentication.isDeviceSupported();
  }

  @override
  Future<bool> authenticate() async {
    if (await checkBiometrics()) {
      await availableBiometrics();
      return await authenticateWithBiometrics();
    }
    return false;
  }

  @override
  Future<bool> authenticateWithBiometrics() async {
    return await _localAuthentication.authenticate(
      localizedReason: 'Autentique-se para continuar',
    );
  }

  @override
  Future availableBiometrics() async {
    await _localAuthentication.getAvailableBiometrics();
  }

  @override
  Future<bool> stopAuthenticate() async {
    return await _localAuthentication.stopAuthentication();
  }
}
