defmodule Snowball.UserView do
  use Snowball.Web, :view

  def render("index.json", %{users: users}) do
    render_many(users, Snowball.UserView, "user.json")
  end

  def render("show.json", %{user: user}) do
    render_one(user, Snowball.UserView, "user.json")
  end

  def render("show-auth.json", %{user: user}) do
    render_one(user, Snowball.UserView, "user-auth.json")
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      avatar_url: nil,
      email: user.email,
      following: user.following}
  end

  def render("user-auth.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      email: user.email,
      avatar_url: nil,
      following: user.following,
      auth_token: user.auth_token}
  end
end