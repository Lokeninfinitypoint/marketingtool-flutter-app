import 'package:appwrite/appwrite.dart';
import 'package:appwrite/enums.dart';
import 'package:appwrite/models.dart' as models;
import '../config/appwrite_config.dart';

class AuthService {
  static final Client client = Client()
      .setEndpoint(AppwriteConfig.endpoint)
      .setProject(AppwriteConfig.projectId)
      .setSelfSigned(status: true);

  static final Account account = Account(client);

  // Check if user is logged in
  static Future<models.User?> getCurrentUser() async {
    try {
      return await account.get();
    } catch (e) {
      return null;
    }
  }

  // Email/Password Sign Up
  static Future<models.User> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    return await account.create(
      userId: ID.unique(),
      email: email,
      password: password,
      name: name,
    );
  }

  // Email/Password Sign In
  static Future<models.Session> signIn({
    required String email,
    required String password,
  }) async {
    return await account.createEmailPasswordSession(
      email: email,
      password: password,
    );
  }

  // Google OAuth
  static Future<void> signInWithGoogle() async {
    await account.createOAuth2Session(
      provider: OAuthProvider.google,
      success: AppwriteConfig.successUrl,
      failure: AppwriteConfig.failureUrl,
    );
  }

  // Facebook OAuth
  static Future<void> signInWithFacebook() async {
    await account.createOAuth2Session(
      provider: OAuthProvider.facebook,
      success: AppwriteConfig.successUrl,
      failure: AppwriteConfig.failureUrl,
    );
  }

  // Apple OAuth
  static Future<void> signInWithApple() async {
    await account.createOAuth2Session(
      provider: OAuthProvider.apple,
      success: AppwriteConfig.successUrl,
      failure: AppwriteConfig.failureUrl,
    );
  }

  // Sign Out
  static Future<void> signOut() async {
    await account.deleteSession(sessionId: 'current');
  }
}
