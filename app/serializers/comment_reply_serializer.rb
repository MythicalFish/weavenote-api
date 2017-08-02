class CommentReplySerializer < ActiveModel::Serializer
  attributes :id, :text, :created_at, :is_reply
  belongs_to :user, serializer: CollaboratorSerializer
  has_many :images, serializer: ImageSerializer
end
