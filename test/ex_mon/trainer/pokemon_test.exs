defmodule ExMon.Trainer.PokemonTest do
  use ExMon.DataCase

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do

      trainer_params = %{name: "vinicius", password: "123456"}
      {:ok, %ExMon.Trainer{id: trainer_id}} = ExMon.create_trainer(trainer_params)

      params = %{name: "pikachu", nickname: "pika", weight: 60, types: ["electric"], trainer_id: trainer_id}

      response = ExMon.Trainer.Pokemon.changeset(params)

      assert %Ecto.Changeset{
        changes: %{
          name: "pikachu",
          nickname: "pika",
          weight: 60,
          types: ["electric"],
          trainer_id: ^trainer_id
        },
        errors: [],
        data: %ExMon.Trainer.Pokemon{},
        valid?: true
      } = response
    end

    test "when there are invalid params, returns an invalid changeset" do
      
      params = %{name: "pikachu", nickname: "pika", weight: 60, types: ["electric"], trainer_id: "invalid_id"}

      response = ExMon.Trainer.Pokemon.changeset(params)

      assert %Ecto.Changeset{
        changes: %{
          name: "pikachu",
          nickname: "pika",
          weight: 60,
          types: ["electric"]
        },
        data: %ExMon.Trainer.Pokemon{},
        valid?: false
      } = response

      assert errors_on(response) == %{trainer_id: ["is invalid"]}
    end
  end

  describe "build/1" do
    test "when all params are valid, returns a pokemon struct" do

      trainer_params = %{name: "vinicius", password: "123456"}
      {:ok, %ExMon.Trainer{id: trainer_id}} = ExMon.create_trainer(trainer_params)

      params = %{name: "pikachu", nickname: "pika", weight: 60, types: ["electric"], trainer_id: trainer_id}

      response = ExMon.Trainer.Pokemon.build(params)

      assert {:ok, %ExMon.Trainer.Pokemon{
        name: "pikachu",
        nickname: "pika",
        weight: 60,
        types: ["electric"],
        trainer_id: ^trainer_id
        }
      } = response     
    end

    test "when there are invalid params, returns a changeset with error message" do

      params = %{name: "pikachu", nickname: "pika", weight: 60, types: ["electric"], trainer_id: "invalid_id"}

      {:error, response} = ExMon.Trainer.Pokemon.build(params)

      assert %Ecto.Changeset{valid?: false} = response

      assert errors_on(response) == %{trainer_id: ["is invalid"]}
    end
  end
end