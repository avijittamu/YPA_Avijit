class User < ActiveRecord::Base
  attr_accessible :user_id, :first_name, :last_name, :password, :dob, :email, :phone, :organization, :donate, :volunteer,  :created_by, :updated_by, :deleted

  # we want to use user_id as the primary key and not the default generated id
  self.primary_key = "user_id"

  # the username, password fields must be present
  validates :email, :password, presence: true

  # Registering ActiveRecord Callbacks
  before_create do
    self.created_by = "SYSTEM"
  end

  before_update do
    self.updated_by = "SYSTEM"
  end

  # associate user with event through user_event table
  has_many :user_events
  has_many :events, through: :user_events

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |user|
        csv << user.attributes.values_at(*column_names)
      end
    end
  end
end
