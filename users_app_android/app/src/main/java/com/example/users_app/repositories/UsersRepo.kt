package com.example.users_app.repositories

import com.example.users_app.models.User
import com.example.users_app.models.UserResponse
import com.google.android.gms.common.api.ApiException
import com.google.android.gms.common.api.Status
import retrofit2.Response
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import retrofit2.http.GET

interface UsersRepo {
  @GET("/api/?results=15")
  suspend fun getUsers(): Response<UserResponse>
}

class UserRepository {
  suspend fun fetchUsers(): List<User> {
    val retrofit = Retrofit.Builder()
      .baseUrl("https://randomuser.me")
      .addConverterFactory(GsonConverterFactory.create())
      .build()

    val userService = retrofit.create(UsersRepo::class.java)
    val response = userService.getUsers()

    if (response.isSuccessful) {
      val body = response.body()
      val result = body?.results

      return result ?: emptyList()
    } else {
      throw ApiException(
        Status(response.code(), response.message())
      )
    }
  }
}
