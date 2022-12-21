defmodule ExMon.Trainer.UpdateTest do
  use ExMon.DataCase

  describe "call/1" do
    test "when all params are valid, updates trainer params" do

      params = %{name: "name", password: "123456"}
      {:ok, %ExMon.Trainer{id: trainer_id}} = ExMon.create_trainer(params)

      response = ExMon.Trainer.Update.call(%{"id" => trainer_id, "name" => "other_name", "password" => "654321"})

      assert {:ok, %ExMon.Trainer{name: "other_name", password: "654321"}} = response
    end

    test "when there are invalid params, returns the error" do

      response = ExMon.Trainer.Update.call(%{"id" => "invalid_id", "name" => "name", "password" => "654321"})

      assert {:error, "Invalid ID format!"} == response
    end
  end
end