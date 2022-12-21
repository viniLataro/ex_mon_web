defmodule ExMonWeb.Controllers.TrainersControllerTest do
  use ExMonWeb.ConnCase

  alias ExMon.Trainer

  describe "create/2" do
    test "when all params are valid, creates a trainer", %{conn: conn} do
      params = %{name: "vinicius", password: "123456"}

      response =
        conn
        |> post(Routes.trainers_path(conn, :create, params))
        |> json_response(:created)

      assert %{"message" => "Trainer created", "trainer" => %{"id" => _id, "inserted_at" => _inserted_at, "name" => "vinicius"}} = response
    end

    test "when there is an error, returns the error", %{conn: conn} do
      params = %{name: "vinicius", password: "123"}

      response =
        conn
        |> post(Routes.trainers_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{"message" => %{"password" => ["should be at least 6 character(s)"]}}

      assert response == expected_response
    end
  end

  describe "show/2" do
    test "when there is a trainer with the given id, returns the trainer", %{conn: conn} do
      params = %{name: "vinicius", password: "123456"}

      {:ok, %Trainer{id: id}} = ExMon.create_trainer(params)

      response = 
        conn
        |> get(Routes.trainers_path(conn, :show, id))
        |> json_response(:ok)

        assert %{"name" => "vinicius", "id" => _id, "inserted_at" => _inserted_at} = response
    end

    test "when there is an error, returns the error", %{conn: conn} do
      response = 
        conn
        |> get(Routes.trainers_path(conn, :show, "invalid_id"))
        |> json_response(:bad_request)

        expected_response = %{"message" => "Invalid ID format"}

        assert response == expected_response
    end  
  end
end