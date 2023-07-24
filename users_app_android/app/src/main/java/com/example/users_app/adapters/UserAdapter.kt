package com.example.users_app.adapters

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.CenterInside
import com.bumptech.glide.load.resource.bitmap.RoundedCorners
import com.example.users_app.R
import com.example.users_app.models.User

class UserAdapter() : ListAdapter<User, UserAdapter.UserViewHolder>(UserDiffCallback()) {

  override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): UserViewHolder {
    val view = LayoutInflater.from(parent.context).inflate(R.layout.user_list_item, parent, false)
    return UserViewHolder(view)
  }

  override fun onBindViewHolder(holder: UserViewHolder, position: Int) {
    val user = getItem(position)
    holder.bind(user)
  }

  class UserViewHolder(
    itemView: View,
  ) : RecyclerView.ViewHolder(itemView) {
    private val userImage: ImageView = itemView.findViewById(R.id.user_image)
    private val userName: TextView = itemView.findViewById(R.id.user_name)
    private val userEmail: TextView = itemView.findViewById(R.id.user_email)

    fun bind(user: User) {
      userName.text = user.name.fullName
      userEmail.text = user.email

      Glide
        .with(itemView)
        .load(user.picture.medium)
        .centerCrop()
        .transform(CenterInside(), RoundedCorners(24))
        .into(userImage)
    }
  }

  class UserDiffCallback : DiffUtil.ItemCallback<User>() {
    override fun areItemsTheSame(oldItem: User, newItem: User) =
      oldItem.email == newItem.email

    override fun areContentsTheSame(oldItem: User, newItem: User) = oldItem == newItem
  }
}
