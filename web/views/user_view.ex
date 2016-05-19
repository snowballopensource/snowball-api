defmodule Snowball.UserView do
  use Snowball.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, Snowball.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, Snowball.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      email: user.email}
  end
end