require "crystal/system/user"

# Represents a user on the host system.
#
# Users can be retrieved by either username or their user ID:
#
# ```
# System::User.find_by name: "root"
# System::User.find_by id: "1000"
# ```
class System::User
  # Raised on user lookup failure.
  class NotFoundError < Exception
  end

  extend Crystal::System::User

  # The user's username.
  getter username : String

  # The user's identifier.
  getter id : String

  # The user's primary group identifier.
  getter group_id : String

  # The user's real or full name.
  getter name : String

  # The user's home directory.
  getter home_directory : String

  # The user's login shell.
  getter shell : String

  def_equals_and_hash @id

  private def initialize(@username, @id, @group_id, @name, @home_directory, @shell)
  end

  # Returns the user associated with the given username.
  #
  # Raises `NotFoundError` if no such user exists.
  def self.find_by(*, name : String)
    find_by?(name: name) || raise NotFoundError.new("No such user: #{name}")
  end

  # Returns the user associated with the given username.
  #
  # Returns `nil` if no such user exists.
  def self.find_by?(*, name : String)
    from_username?(name)
  end

  # Returns the user associated with the given ID.
  #
  # Raises `NotFoundError` if no such user exists.
  def self.find_by(*, id : String)
    find_by?(id: id) || raise NotFoundError.new("No such user: #{id}")
  end

  # Returns the user associated with the given ID.
  #
  # Returns `nil` if no such user exists.
  def self.find_by?(*, id : String)
    from_id?(id)
  end

  def to_s(io)
    io << username << " (" << id << ")"
  end
end
