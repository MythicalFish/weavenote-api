class CommentSerializer < ActiveModel::Serializer
  attributes :id, :text, :created_at, :identifier, :is_reply, :archived
  belongs_to :user, serializer: CollaboratorSerializer
  has_many :replies, serializer: CommentReplySerializer
  has_many :images, serializer: ImageSerializer
  has_one :annotation, serializer: AnnotationSerializer
end
