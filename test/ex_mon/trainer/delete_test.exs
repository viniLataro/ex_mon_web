defmodule ExMon.Trainer.DeleteTest do
  use ExMon.DataCase

  describe "call/1" do
    test "when all params are valid, deletes a trainer" do

      params = %{name: "vinicius", password: "123456"}
      {:ok, %ExMon.Trainer{id: trainer_id}} = ExMon.create_trainer(params)

      count_before = ExMon.Repo.aggregate(ExMon.Trainer, :count)

      response = ExMon.Trainer.Delete.call(trainer_id)

      count_after = ExMon.Repo.aggregate(ExMon.Trainer, :count)

      assert {:ok, %ExMon.Trainer{name: "vinicius"}} = response
      assert count_before > count_after
    end

    test "when there are invalid params, returns the error" do

      params = "invalid_id"

      response = ExMon.Trainer.Delete.call(params)

      assert {:error, "Invalid ID format"} == response
    end
  end
end