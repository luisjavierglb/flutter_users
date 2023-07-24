package com.example.users_app.models

data class UserResponse(
  val results: List<User>,
)

data class User(
  val name: Name,
  val email: String,
  val picture: Picture
)

data class Name(
  val title: String,
  val first: String,
  val last: String,
) {
  val fullName: String
    get() = "$title $first $last"
}

data class Picture(
  val medium: String,
)
