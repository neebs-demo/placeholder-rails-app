require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      article = Article.new(title: "Test Title", content: "Test Content")
      expect(article).to be_valid
    end

    it "is not valid without a title" do
      article = Article.new(content: "Test Content")
      expect(article).not_to be_valid
      expect(article.errors[:title]).to include("can't be blank")
    end

    it "is not valid without content" do
      article = Article.new(title: "Test Title")
      expect(article).not_to be_valid
      expect(article.errors[:content]).to include("can't be blank")
    end
  end

  describe "associations" do
    it "has many comments" do
      article = Article.create!(title: "Test Title", content: "Test Content")
      comment1 = article.comments.create!(content: "First comment")
      comment2 = article.comments.create!(content: "Second comment")

      expect(article.comments).to include(comment1, comment2)
    end

    it "destroys associated comments when deleted" do
      article = Article.create!(title: "Test Title", content: "Test Content")
      article.comments.create!(content: "Test comment")

      expect { article.destroy }.to change(Comment, :count).by(-1)
    end
  end
end
