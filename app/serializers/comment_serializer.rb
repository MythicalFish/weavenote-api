class CommentSerializer < ActiveModel::Serializer
  attributes :id, :text, :created_at, :identifier, :is_reply
  belongs_to :user, serializer: CollaboratorSerializer
  has_many :replies, serializer: CommentReplySerializer
  has_many :images, serializer: ImageSerializer
end
