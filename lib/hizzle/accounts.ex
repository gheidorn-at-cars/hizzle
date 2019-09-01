defmodule Hizzle.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false

  alias Ecto.UUID
  alias Hizzle.Accounts.User
  # alias Engine.Pagination
  # alias Engine.Repo

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  # def list_users(%Pagination{} = pagination \\ %Pagination{}) do
  #   User
  #   |> Repo.paginate(pagination)
  # end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Gets a single user and their associated preloads if given.

  Returns nil if the user does not exist.
  """

  def get_user(id, preloads \\ []) do
    User
    |> Repo.get(id)
    |> Repo.preload(preloads)
  end

  @doc """
  Gets a single user using the auth0_id

  Returns nil when no user is found

  ## Examples

      iex> get_user_by_auth0_id("989d8dfkjdf")
      %Engine.Accounts.User{}

      iex> get_user_by_auth0_id("989d8dfkjdf")
      nil

      iex> get_user_by_auth0_id(nil)
      nil

  """
  def get_user_by_auth0_id(nil), do: nil

  def get_user_by_auth0_id(auth0_id) do
    Repo.get_by(User, auth0_id: auth0_id)
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a User or updates an existing one with a matching auth0_id. On conflict,
  the fields provided in `on_conflic_fields` will be updated.
  """
  def upsert_user(attrs, on_conflict_fields) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert(
      on_conflict: {:replace, on_conflict_fields},
      conflict_target: :auth0_id,
      returning: true
    )
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  # def get_admin(id, preloads \\ []) do
  #   Admin
  #   |> Repo.get(id)
  #   |> Repo.preload(preloads)
  # end

  @doc """
  Get Admin that matches the given email.
  """
  # @spec get_admin_by_email(String.t() | nil) :: Admin.t() | nil
  # def get_admin_by_email(nil), do: nil

  # def get_admin_by_email(email) do
  #   Repo.get_by(Admin, email: email)
  # end

  # def create_admin(attrs \\ %{}) do
  #   %Admin{}
  #   |> Admin.changeset(attrs)
  #   |> Repo.insert()
  # end

  # def update_admin(%Admin{} = admin, attrs) do
  #   admin
  #   |> Admin.changeset(attrs)
  #   |> Repo.update()
  # end

  @doc """
  Creates an Admin or updates an existing one with a matching email. On conflict,
  the fields provided in `on_conflic_fields` will be updated.
  """
  # def upsert_admin(attrs, on_conflict_fields) do
  #   %Admin{}
  #   |> Admin.changeset(attrs)
  #   |> Repo.insert(
  #     on_conflict: {:replace, on_conflict_fields},
  #     conflict_target: :email,
  #     returning: true
  #   )
  # end

  @doc """
  Returns a list of admins that belong to any of the given ADFS group ids.
  """
  # @spec list_admins_by_adfs_group_ids([UUID.t()], Pagination.t()) :: Scrivener.Page.t()
  # def list_admins_by_adfs_group_ids(adfs_group_ids, %Pagination{} = pagination \\ %Pagination{}) do
  #   query =
  #     from admin in Admin,
  #       join: adfs_group in assoc(admin, :adfs_groups),
  #       where: adfs_group.remote_adfs_group_id in ^adfs_group_ids,
  #       distinct: true,
  #       select: admin

  #   Repo.paginate(query, pagination)
  # end

  def list_admins_by_emails(emails) do
    query =
      from(admin in Admin,
        where: admin.email in ^emails,
        select: admin
      )

    Repo.all(query)
  end
end
