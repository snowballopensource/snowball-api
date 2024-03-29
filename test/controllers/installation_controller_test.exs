defmodule Snowball.InstallationControllerTest do
  use Snowball.ConnCase, async: true

  test_authentication_required_for(:put, :installation_path, :create)

  test "create/2 creates a installation for the current user", %{conn: conn} do
    user = insert(:user)
    token = "740f4707bebcf74f9b7c25d48e3358945f6aa01da5ddb387462c7eaf61bb78ad"
    conn = conn
    |> authenticate(user.auth_token)
    |> put(installation_path(conn, :create), token: token)
    assert json_response(conn, 201) == user_response(user, current_user: user)
  end

  test "create/2 does not create a duplicate installation", %{conn: conn} do
    user = insert(:user)
    insert(:installation, arn: "arn:aws:sns:us-west-2:235811926729:endpoint/APNS/snowball-ios-production/514e2e2a-0990-36e7-bc0c-04548bf13572")
    token = "740f4707bebcf74f9b7c25d48e3358945f6aa01da5ddb387462c7eaf61bb78ad"
    conn = conn
    |> authenticate(user.auth_token)
    |> put(installation_path(conn, :create), token: token)
    assert json_response(conn, 201) == user_response(user, current_user: user)
    assert Repo.one(from d in Installation, select: count(d.id)) == 1
  end

  test "create/2 with invalid params does not create a installation and returns an error", %{conn: conn} do
    user = insert(:user)
    conn = conn
    |> authenticate(user.auth_token)
    |> put(installation_path(conn, :create), token: "")
    assert json_response(conn, 422) == %{"message" => "An error occured while registering the token."}
  end
end
