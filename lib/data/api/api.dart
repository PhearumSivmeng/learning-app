import 'package:demo/data/api/api_response.dart';
import 'package:demo/data/models/category_model.dart';
import 'package:demo/data/models/chat_model.dart';
import 'package:demo/data/models/page_detail_model.dart';
import 'package:demo/data/models/partner_model.dart';
import 'package:demo/data/models/question_model.dart';
import 'package:demo/data/models/slide_model.dart';
import 'package:demo/data/models/technology_model.dart';
import 'package:demo/data/models/user_active_model.dart';
import 'package:demo/data/models/video_model.dart';

abstract class Api {
  Future<ApiResponse> onLogin({Map? arg});
  Future<ApiResponse> onRequestOTP({Map? arg});
  Future<ApiResponse> onVerifyOTP({Map? arg});
  Future<ApiResponse> onRegister({Map? arg});
  Future<ApiResponse<List<PartnerModel>>> onGetMessagers({Map? arg});
  Future<ApiResponse<ChatModel>> onGetMessager({Map? arg});
  Future<ApiResponse> onSendMessager({Map? arg});
  Future<ApiResponse<List<UserActiveModel>>> onGetUsersActive({Map? arg});
  Future<ApiResponse<List<SlideModel>>> onGetCarousel({Map? arg});
  Future<ApiResponse<List<CategoryModel>>> onGetCategory({Map? arg});
  Future<ApiResponse<List<AritcleModel>>> onGetArticle({Map? arg});
  Future<ApiResponse<PageDetailModel>> onGetPageDetail({Map? arg});
  Future<ApiResponse<List<QuestionModel>>> onGetQuestions({Map? arg});
  Future<ApiResponse<List<VideoModel>>> onGetCourseVideo({Map? arg});
}
