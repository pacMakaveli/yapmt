class Comment < ApplicationRecord

  enum comment_type: [:journal, :change], _default: :journal

  # Associations
  #
  belongs_to :project, counter_cache: true, touch: true
  belongs_to :user

  has_one :change, dependent: :destroy

  # Scopes
  #
  default_scope { order(created_at: :desc) }

  # Validations
  #
  validates_presence_of :body

  # Callbacks
  #
  after_create_commit do
    broadcast_prepend_to :comments, partial: 'comments/comment', locals: { comment: self }, target: :comments
  end
end
