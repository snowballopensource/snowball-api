defmodule Snowball.ConnCase do
  use ExUnit.CaseTemplate
  import Plug.Conn

  using do
    quote do
      use Snowball.TestCase

      import Plug.Conn
      import Snowball.ConnCase

      @endpoint Snowball.Endpoint
    end
  end

  setup tags do
    Snowball.TestCase.setup(tags)

    {:ok, conn: Phoenix.ConnTest.build_conn}
  end

  def generic_uuid do
    "696c7ceb-c8ec-4f2b-a16a-21c822c9e984"
  end

  def authenticate(conn, auth_token) do
    header_content = "Basic " <> Base.encode64("#{auth_token}:")
    conn |> put_req_header("authorization", header_content)
  end

  def clip_response(clip, opts \\ []) do
    %{
      "id" => clip.id,
      "user" => user_response(clip.user, opts[:user] || []),
      "thumbnail_url" => nil,
      "video_url" => nil,
      "created_at" => clip.created_at |> Ecto.DateTime.to_iso8601
    }
  end

  def user_response(user, opts \\ []) do
    opts
    |> Snowball.Enum.keyword_keys_to_strings
    |> Enum.into(
      %{"id" => user.id,
      "username" => user.username,
      "avatar_url" => nil,
      "email" => user.email,
      "following" => user.following}
    )
  end

  def error_changeset_response(field, message) do
    %{"message" => "Validation failed", "errors" => [%{"message" => message, "field" => Atom.to_string(field)}]}
  end

  def error_bad_request_response do
    %{"message" => "Bad request"}
  end

  def error_not_found_response do
    %{"message" => "Not found"}
  end

  def error_unauthorized_response do
    %{"message" => "Unauthorized"}
  end

  defmacro test_authentication_required_for(method, path_name, action, options \\ []) do
    quote do
      test "#{unquote(action)}/2 requires authentication", %{conn: conn} do
        # conn = make_request(conn, @endpoint, unquote(method), unquote(path_name), unquote(action), unquote(options))
        # assert conn |> json_response(401)
        assert false
      end
    end
  end

  # def make_request(conn, endpoint, method, path_name, action, options) do
  #   path = apply(Snowball.Router.Helpers, path_name, [conn, action, options])
  #   dispatch(conn, endpoint, method, path)
  # end
end
