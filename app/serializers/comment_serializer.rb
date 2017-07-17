class CommentSerializer < ActiveModel::Serializer
  attributes :id, :text, :created_at, :updated_at
  belongs_to :user, serializer: CollaboratorSerializer
end
