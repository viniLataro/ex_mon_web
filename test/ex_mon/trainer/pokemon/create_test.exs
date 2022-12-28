defmodule ExMon.Trainer.Pokemon.CreateTest do
  use ExMon.DataCase

  import Tesla.Mock

  @base_url "https://pokeapi.co/api/v2/pokemon/"

  describe "call/1" do
    test "when all params are valid, creates a pokemon" do
      body = %{"name" => "pikachu", "weight" => 60, "types" => [%{"name" => "electric"}]}

      mock(fn %{method: :get, url: @base_url <> "pikachu"} ->
        %Tesla.Env{status: 200, body: body}
      end)

      trainer_params = %{name: "trainer", password: "123456"}

      {:ok, %ExMon.Trainer{id: trainer_id}} = ExMon.create_trainer(trainer_params)

      pokemon_params = %{"name" => "pikachu", "nickname" => "pika", "trainer_id" => trainer_id}

      response = ExMon.Trainer.Pokemon.Create.call(pokemon_params)

      assert {:ok, %ExMon.Trainer.Pokemon{name: "pikachu", nickname: "pika"}} = response
    end

    test "when there are invalid params, returns the error" do

      mock(fn %{method: :get, url: @base_url <> "invalid_name"} ->
        %Tesla.Env{status: 404}
      end)

      params = %{"name" => "invalid_name", "nickname" => "pika", "trainer_id" => "invalid_id"}

      response = ExMon.Trainer.Pokemon.Create.call(params)

      assert {:error, "Pokemon not found!"} == response
    end
  end
end
