abstract class ILocalAuthService {
  Future<bool> checkBiometrics();
  Future availableBiometrics();
  Future<bool> authenticateWithBiometrics();
  Future<bool> authenticate();
}
