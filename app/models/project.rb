class Project < ApplicationRecord

  enum status: {
    active:    0,
    blocked:   1,
    completed: 2,
    inactive:  3,
    off_track: 4,
    on_hold:   5,
    on_track:  6

  }, _default: :active

  # Associations
  #
  has_many :comments, dependent: :destroy
  has_many :status_changes, class_name: 'Change', dependent: :destroy

  # Validations
  #
  validates_uniqueness_of :name

  # Scopes
  #
  default_scope { order(created_at: :desc) }

  # Callbacks
  #
  after_touch do
    broadcast_replace_to(:projects, partial: 'projects/project', locals: { project: self }, target: self)
  end

  def latest_comment
    comments.order(created_at: :desc).first
  end

  def activities
    (comments + status_changes).sort_by(&:created_at).reverse
  end
end
