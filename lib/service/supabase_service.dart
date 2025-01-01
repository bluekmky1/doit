import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Supabase 클라이언트 Provider
final Provider<SupabaseClient> supabaseServiceProvider =
    Provider<SupabaseClient>(
        (Ref<SupabaseClient> ref) => Supabase.instance.client);

// Supabase 초기화를 위한 클래스
class SupabaseService {
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL'] ?? '',
      anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
    );
  }

  // 현재 인증된 사용자 가져오기
  static User? get currentUser => Supabase.instance.client.auth.currentUser;

  // 현재 세션 가져오기
  static Session? get currentSession =>
      Supabase.instance.client.auth.currentSession;

  // 로그아웃
  static Future<void> signOut() async {
    await Supabase.instance.client.auth.signOut();
  }
}
