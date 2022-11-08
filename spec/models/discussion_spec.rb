describe Discussion do
  describe "Add new discussion" do
    context "root discussion" do
      post_title = "Root Discussion"
      post_body = "Root discussion body"
      post_author = "Admin"
      discussion = Discussion.create!(title: post_title, body: post_body, author: post_author, root_discussion_id: 0)
      expect(Discussion.get_root_posts).to include? discussion
      expect(Discussion.get_root_post(discussion.id)).to eql? discussion
    end
    context "reply to discussion" do
      root_post_title = "Root Discussion"
      root_post_body = "Root discussion body"
      root_post_author = "Admin"
      root_discussion = Discussion.create!(title: root_post_title, body: root_post_body, author: root_post_author, root_discussion_id: 0)
      reply_post_title = "Root Discussion"
      reply_post_body = "Root discussion body"
      reply_post_author = "Admin"
      reply_discussion = Discussion.create!(title: reply_post_title, body: reply_post_body, author: reply_post_author, root_discussion_id: root_discussion.id)
      expect(Discussion.get_post_replies(root_discussion.id)).to include? reply_discussion
    end
  end
  describe "Edit existing discussion" do
    context "root discussion" do

    end
    context "reply to discussion" do

    end
  end
  describe "delete discussion" do
    context "root discussion" do
      post_title = "Root Discussion"
      post_body = "Root discussion body"
      post_author = "Admin"
      discussion = Discussion.create!(title: post_title, body: post_body, author: post_author, root_discussion_id: 0)
      expect(Discussion.get_root_posts).to include? discussion
      discussion.destroy
      expect(Discussion.get_root_posts).to exclude? discussion
    end
    context "reply to discussion" do
      root_post_title = "Root Discussion"
      root_post_body = "Root discussion body"
      root_post_author = "Admin"
      root_discussion = Discussion.create!(title: root_post_title, body: root_post_body, author: root_post_author, root_discussion_id: 0)
      reply_post_title = "Root Discussion"
      reply_post_body = "Root discussion body"
      reply_post_author = "Admin"
      reply_discussion = Discussion.create!(title: reply_post_title, body: reply_post_body, author: reply_post_author, root_discussion_id: root_discussion.id)
      expect(Discussion.get_post_replies(root_discussion.id)).to include? reply_discussion
      reply_discussion.destroy
      expect(Discussion.get_post_replies(root_discussion.id)).to exclude? reply_discussion
      expect(Discussion.get_root_posts).to include? root_discussion
    end
  end
end
