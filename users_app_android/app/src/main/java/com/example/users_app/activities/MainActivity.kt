package com.example.users_app.activities

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.lifecycleScope
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.users_app.R
import com.example.users_app.adapters.UserAdapter
import com.example.users_app.view_models.UserViewModel
import com.google.android.material.floatingactionbutton.FloatingActionButton
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class MainActivity : AppCompatActivity() {
  private val viewModel: UserViewModel by viewModels()

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_main)

    val userRecyclerView: RecyclerView = findViewById(R.id.userRecyclerView)
    val userAdapter = UserAdapter()
    val btnRefresh: FloatingActionButton = findViewById(R.id.btnRefresh)
    val btnNavigateCompose: Button = findViewById(R.id.btnNavigateCompose)

    btnRefresh.setOnClickListener {
      refreshUsers()
    }

    btnNavigateCompose.setOnClickListener {
      val intent = Intent(this, ComposeActivity::class.java)
      // start your next activity
      startActivity(intent)
    }

    userRecyclerView.layoutManager = LinearLayoutManager(this)
    userRecyclerView.adapter = userAdapter

    lifecycleScope.launchWhenStarted {
      viewModel.users.collect { users ->
        userAdapter.submitList(users)
      }
    }

    refreshUsers()
  }

  private fun refreshUsers() {
    CoroutineScope(Dispatchers.Main).launch {
      viewModel.fetchUsers()
    }
  }
}