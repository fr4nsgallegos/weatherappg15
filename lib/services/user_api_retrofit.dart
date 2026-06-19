import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weatherappg15/models/user_model.dart';

part 'user_api_retrofit.g.dart';

@RestApi(baseUrl: "https://68cedf266dc3f35077803c79.mockapi.io/api/v1/")
abstract class UserApiRetrofit {
  factory UserApiRetrofit(Dio dio, {String baseUrl}) = _UserApiRetrofit;

  // get
  @GET("/users")
  Future<List<UserModel>> getUsers();

  // get por id
  @GET("users/{id}")
  Future<UserModel> getUserById(@Path("id") String id);

  // POST
  @POST("/users")
  Future<UserModel> createAuser(@Body() UserModel user);

  // PUT
  @PUT("/users/{id}")
  Future<UserModel> updateUser(@Path("id") String id, @Body() UserModel user);

  // DELETE
  @DELETE("users/{id}")
  Future<void> deleteUser(@Path("id") String id);
}
