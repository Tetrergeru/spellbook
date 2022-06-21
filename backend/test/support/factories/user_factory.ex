defmodule Backend.Factories.UserFactory do
  defmacro __using__(_opts) do
    quote do
      alias Backend.Users.Entities.User
      alias Faker.{Internet, Lorem, Person}

      def user_factory(attrs) do
        password = Map.get(attrs, :password, "#{Lorem.sentence(8..16)}1")
        nickname = Map.get(attrs, :mickname, "#{Person.first_name()}_#{Person.last_name()}")
        email = Map.get(attrs, :email, Internet.email())

        %Ecto.Changeset{valid?: true, changes: changes} = User.create_changeset(%User{}, %{
          password: password,
          nickname: nickname,
          email: sequence(:email, &"#{&1}_#{email}")
        })

        struct(%User{}, changes)
      end
    end
  end
end
