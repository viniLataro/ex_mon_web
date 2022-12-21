defmodule ExMon.Trainer.GetTest do
  use ExMon.DataCase

  describe "call/1" do
    test "when all params are valid, returns a treiner" do
      
      trainer_params = %{name: "vinicius", password: "123456"}
      {:ok, %ExMon.Trainer{id: trainer_id}} = ExMon.create_trainer(trainer_params)

      response = ExMon.Trainer.Get.call(trainer_id)

      assert {:ok, %ExMon.Trainer{
          id: ^trainer_id,
          name: "vinicius",
          password: nil,
          pokemon: []
          }
        } = response
    end

    test "when there are invalid params, returns the error" do

      response = ExMon.Trainer.Get.call("invalid_id")

      assert {:error, "Invalid ID format"} == response
    end
  end
end