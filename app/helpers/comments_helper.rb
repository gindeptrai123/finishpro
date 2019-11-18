module CommentsHelper
  def comments_child id
    @comments.comment_children.comment_id id
  end
end
