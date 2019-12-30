defmodule Mix.Tasks.Wobbly.OpenApiSpec do
  @moduledoc """
  Mix task to generate our OpenAPI schema.
  """
  def run([output_file]) do
    # Required if using for OpenApiSpex.Server.from_endpoint/1
    # Wobbly.Application.start_link()
    Mix.Task.run("app.start")

    json =
      WobblyWeb.ApiSpec.spec()
      |> Jason.encode!(pretty: true)

    :ok = File.write!(output_file, json)
  end
end
