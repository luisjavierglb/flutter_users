package com.example.users_app.view_models

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.users_app.models.User
import com.example.users_app.repositories.UserRepository
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class UserViewModel : ViewModel() {

  private val _users = MutableStateFlow<List<User>>(
    emptyList()
  )
  val users: StateFlow<List<User>> = _users.asStateFlow()

  private val usersRepo = UserRepository()

  suspend fun fetchUsers() {
    try {
      viewModelScope.launch(Dispatchers.IO) {
        val userList = usersRepo.fetchUsers()
        withContext(Dispatchers.Main) {
          _users.value = userList
        }
      }
    } catch (e: Exception) {
      print(e)
    }
  }

}