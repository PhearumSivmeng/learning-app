import 'dart:convert';

import 'package:demo/core/auth.dart';
import 'package:demo/core/domain.dart';
import 'package:demo/data/api/api.dart';
import 'package:demo/data/api/api_response.dart';
import 'package:demo/data/models/category_model.dart';
import 'package:demo/data/models/chat_model.dart';
import 'package:demo/data/models/page_detail_model.dart';
import 'package:demo/data/models/partner_model.dart';
import 'package:demo/data/models/question_model.dart';
import 'package:demo/data/models/slide_model.dart';
import 'package:demo/data/models/technology_model.dart';
import 'package:demo/data/models/user_active_model.dart';
import 'package:demo/data/models/user_model.dart';
import 'package:demo/data/models/video_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient implements Api {
  final http.Client client;

  ApiClient({required this.client});

  Future<String> getParams({Map? params}) async {
    try {
      final auth = await Auth.instance.user;
      final sharePref = await SharedPreferences.getInstance();
      final langCode = sharePref.getString('langCode') ?? "en";
      var tranlate = "";

      if (langCode == 'zh') {
        tranlate = 'ch';
      } else if (langCode == 'km') {
        tranlate = 'kh';
      } else {
        tranlate = 'en';
      }

      final Map param = {
        "token": auth?.token ?? "",
        "locale": tranlate,
      };

      var body = param;
      if (params != null) {
        body = {...param, ...params};
      }
      return json.encode(body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onLogin({Map? arg}) async {
    try {
      final response = await client.post(
        Uri.parse("$kUrl/login"),
        headers: {"Content-Type": "application/json"},
        body: await getParams(params: arg),
      );

      if (response.statusCode != 200) {
        throw Exception();
      }

      final body = json.decode(response.body);

      return ApiResponse<UserModel>(
        status: body["status"] ?? "failed",
        records: body["records"] ?? body["user"] != null
            ? UserModel.fromJson(body["user"])
            : body['user'] ?? [],
        msg: body["msg"] ?? "",
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onRequestOTP({Map? arg}) async {
    try {
      final response = await client.post(
        Uri.parse("$kUrl/request-email-otp"),
        headers: {"Content-Type": "application/json"},
        body: await getParams(params: arg),
      );

      if (response.statusCode != 200) {
        throw Exception();
      }

      final body = json.decode(response.body);

      return ApiResponse(
        status: body["status"] ?? "failed",
        records: body["records"] ?? body["user"] != null
            ? UserModel.fromJson(body["user"])
            : body['user'] ?? [],
        msg: body["msg"] ?? "",
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onVerifyOTP({Map? arg}) async {
    try {
      final response = await client.post(
        Uri.parse("$kUrl/verifycation-otp"),
        headers: {"Content-Type": "application/json"},
        body: await getParams(params: arg),
      );

      if (response.statusCode != 200) {
        throw Exception();
      }

      final body = json.decode(response.body);

      return ApiResponse(
        status: body["status"] ?? "failed",
        records: body["records"] ?? body["user"] != null
            ? UserModel.fromJson(body["user"])
            : body['user'] ?? [],
        msg: body["msg"] ?? "",
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onRegister({Map? arg}) async {
    try {
      final response = await client.post(
        Uri.parse("$kUrl/register"),
        headers: {"Content-Type": "application/json"},
        body: await getParams(params: arg),
      );

      if (response.statusCode != 200) {
        throw Exception();
      }

      final body = json.decode(response.body);

      return ApiResponse(
        status: body["status"] ?? "failed",
        records: body["records"] ?? body["user"] != null
            ? UserModel.fromJson(body["user"])
            : body['user'] ?? [],
        msg: body["msg"] ?? "",
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<List<PartnerModel>>> onGetMessagers({Map? arg}) async {
    try {
      final response = await client.post(
        Uri.parse("$kUrl/get-conversations"),
        headers: {"Content-Type": "application/json"},
        body: await getParams(params: arg),
      );

      if (response.statusCode != 200) {
        throw Exception();
      }

      final body = json.decode(response.body);
      final List<dynamic> records = body["records"] ?? [];
      final List<PartnerModel> partnerModels =
          records.map((record) => PartnerModel.fromJson(record)).toList();

      return ApiResponse<List<PartnerModel>>(
        status: body["status"] ?? "failed",
        records: partnerModels,
        msg: body["msg"] ?? "",
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<List<UserActiveModel>>> onGetUsersActive(
      {Map? arg}) async {
    try {
      final response = await client.post(
        Uri.parse("$kUrl/get-users"),
        headers: {"Content-Type": "application/json"},
        body: await getParams(params: arg),
      );

      if (response.statusCode != 200) {
        throw Exception();
      }

      final body = json.decode(response.body);
      final List<dynamic> records = body["records"] ?? [];
      final List<UserActiveModel> usersActive =
          records.map((record) => UserActiveModel.fromJson(record)).toList();

      return ApiResponse<List<UserActiveModel>>(
        status: body["status"] ?? "failed",
        records: usersActive,
        msg: body["msg"] ?? "",
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<ChatModel>> onGetMessager({Map? arg}) async {
    try {
      final response = await client.post(
        Uri.parse("$kUrl/get-conversation"),
        headers: {"Content-Type": "application/json"},
        body: await getParams(params: arg),
      );

      if (response.statusCode != 200) {
        throw Exception();
      }
      final body = json.decode(response.body);
      if (body["records"] == null) {
        throw Exception("Invalid response data");
      }

      final ChatModel chatData = ChatModel.fromJson(body["records"]);

      return ApiResponse<ChatModel>(
        status: body["status"] ?? "failed",
        records: chatData,
        msg: body["msg"] ?? "",
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> onSendMessager({Map? arg}) async {
    try {
      final response = await client.post(
        Uri.parse("$kUrl/send-conversation"),
        headers: {"Content-Type": "application/json"},
        body: await getParams(params: arg),
      );

      if (response.statusCode != 200) {
        throw Exception();
      }
      final body = json.decode(response.body);

      return ApiResponse(
        status: body["status"] ?? "failed",
        msg: body["msg"] ?? "",
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<List<SlideModel>>> onGetCarousel({Map? arg}) async {
    try {
      final response = await client.post(
        Uri.parse("$kUrl/get-slide-show"),
        headers: {"Content-Type": "application/json"},
        body: null,
      );

      if (response.statusCode != 200) {
        throw Exception();
      }

      final body = json.decode(response.body);
      final List<dynamic> records = body["records"] ?? [];
      final List<SlideModel> slideModels =
          records.map((record) => SlideModel.fromJson(record)).toList();

      return ApiResponse<List<SlideModel>>(
        status: body["status"] ?? "failed",
        records: slideModels,
        msg: body["msg"] ?? "",
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<List<CategoryModel>>> onGetCategory({Map? arg}) async {
    try {
      final response = await client.post(
        Uri.parse("$kUrl/get-category"),
        headers: {"Content-Type": "application/json"},
        body: null,
      );

      if (response.statusCode != 200) {
        throw Exception();
      }

      final body = json.decode(response.body);
      final List<dynamic> records = body["records"] ?? [];
      final List<CategoryModel> slideModels =
          records.map((record) => CategoryModel.fromJson(record)).toList();

      return ApiResponse<List<CategoryModel>>(
        status: body["status"] ?? "failed",
        records: slideModels,
        msg: body["msg"] ?? "",
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<List<AritcleModel>>> onGetArticle({Map? arg}) async {
    try {
      final response = await client.post(
        Uri.parse("$kUrl/get-article"),
        headers: {"Content-Type": "application/json"},
        body: await getParams(params: arg),
      );

      if (response.statusCode != 200) {
        throw Exception();
      }

      final body = json.decode(response.body);
      final List<dynamic> records = body["records"] ?? [];
      final List<AritcleModel> slideModels =
          records.map((record) => AritcleModel.fromJson(record)).toList();

      return ApiResponse<List<AritcleModel>>(
        status: body["status"] ?? "failed",
        records: slideModels,
        msg: body["msg"] ?? "",
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<PageDetailModel>> onGetPageDetail({Map? arg}) async {
    try {
      final response = await client.post(
        Uri.parse("$kUrl/get-page-info"),
        headers: {"Content-Type": "application/json"},
        body: null,
      );

      if (response.statusCode != 200) {
        throw Exception();
      }

      final body = json.decode(response.body);
      if (body["record"] == null) {
        throw Exception("Invalid response data");
      }
      final PageDetailModel chatData = PageDetailModel.fromJson(body["record"]);

      return ApiResponse<PageDetailModel>(
        status: body["status"] ?? "failed",
        records: chatData,
        msg: body["msg"] ?? "",
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<List<QuestionModel>>> onGetQuestions({Map? arg}) async {
    try {
      final response = await client.post(
        Uri.parse("$kUrl/get-questions"),
        headers: {"Content-Type": "application/json"},
        body: await getParams(params: arg),
      );

      if (response.statusCode != 200) {
        throw Exception();
      }

      final body = json.decode(response.body);
      final List<dynamic> records = body["records"] ?? [];
      final List<QuestionModel> slideModels =
          records.map((record) => QuestionModel.fromJson(record)).toList();

      return ApiResponse<List<QuestionModel>>(
        status: body["status"] ?? "failed",
        records: slideModels,
        msg: body["msg"] ?? "",
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<List<VideoModel>>> onGetCourseVideo({Map? arg}) async {
    try {
      final response = await client.post(
        Uri.parse("$kUrl/get-all-videos"),
        headers: {"Content-Type": "application/json"},
        body: await getParams(params: arg),
      );

      if (response.statusCode != 200) {
        throw Exception();
      }

      final body = json.decode(response.body);
      final List<dynamic> records = body["records"] ?? [];
      final List<VideoModel> slideModels =
          records.map((record) => VideoModel.fromJson(record)).toList();

      return ApiResponse<List<VideoModel>>(
        status: body["status"] ?? "failed",
        records: slideModels,
        msg: body["msg"] ?? "",
      );
    } catch (e) {
      rethrow;
    }
  }
}
