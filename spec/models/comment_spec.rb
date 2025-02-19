require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:article) { Article.create!(title: "Test Article", content: "Test Content") }

  describe "validations" do
    it "is valid with valid attributes" do
      comment = Comment.new(content: "Test Comment", article: article)
      expect(comment).to be_valid
    end

    it "is not valid without content" do
      comment = Comment.new(article: article)
      expect(comment).not_to be_valid
      expect(comment.errors[:content]).to include("can't be blank")
    end

    it "is not valid without an article" do
      comment = Comment.new(content: "Test Comment")
      expect(comment).not_to be_valid
      expect(comment.errors[:article]).to include("must exist")
    end
  end

  describe "associations" do
    it "belongs to an article" do
      comment = article.comments.create!(content: "Test Comment")
      expect(comment.article).to eq(article)
    end
  end
end
