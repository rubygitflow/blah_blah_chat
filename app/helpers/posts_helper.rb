# frozen_string_literal: true

module PostsHelper
  def highlighted(post)
    if post.highlight.present?
      render partial: 'posts/highlight_warn', locals: { post: }
    else
      render partial: 'posts/unhighlight', locals: { post: }
    end
  end

  def highlight_link(post)
    highlight_chat_post_path(post.chat, post)
  end

  def highlight_id(post)
    "post_highlight_#{post.id}"
  end
end
