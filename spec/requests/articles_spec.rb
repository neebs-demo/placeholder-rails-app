require 'rails_helper'

RSpec.describe "Articles", type: :request do
  describe "GET /articles" do
    it "returns http success" do
      get articles_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /articles/:id" do
    it "returns http success" do
      article = Article.create!(title: "Test Article", content: "Test Content")
      get article_path(article)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /articles/new" do
    it "returns http success" do
      get new_article_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /articles" do
    context "with valid parameters" do
      let(:valid_params) do
        {
          article: {
            title: "Test Title",
            content: "Test Content"
          }
        }
      end

      it "creates a new article" do
        expect {
          post articles_path, params: valid_params
        }.to change(Article, :count).by(1)
      end

      it "redirects to the created article" do
        post articles_path, params: valid_params
        expect(response).to redirect_to(article_path(Article.last))
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        {
          article: {
            title: "",
            content: ""
          }
        }
      end

      it "does not create a new article" do
        expect {
          post articles_path, params: invalid_params
        }.not_to change(Article, :count)
      end

      it "returns unprocessable entity status" do
        post articles_path, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
