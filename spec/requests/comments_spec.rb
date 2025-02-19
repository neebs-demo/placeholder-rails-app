require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:article) { Article.create!(title: "Test Article", content: "Test Content") }

  describe "POST /articles/:article_id/comments" do
    context "with valid parameters" do
      let(:valid_params) do
        {
          comment: {
            content: "Test Comment"
          }
        }
      end

      it "creates a new comment" do
        expect {
          post article_comments_path(article), params: valid_params
        }.to change(Comment, :count).by(1)
      end

      context "with HTML format" do
        it "redirects to the article" do
          post article_comments_path(article), params: valid_params
          expect(response).to redirect_to(article_path(article))
        end
      end

      context "with Turbo Stream format" do
        it "returns successful response" do
          post article_comments_path(article),
               params: valid_params,
               headers: { "Accept" => "text/vnd.turbo-stream.html" }
          expect(response).to be_successful
        end
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        {
          comment: {
            content: ""
          }
        }
      end

      it "does not create a new comment" do
        expect {
          post article_comments_path(article), params: invalid_params
        }.not_to change(Comment, :count)
      end

      it "redirects to the article with an alert" do
        post article_comments_path(article), params: invalid_params
        expect(response).to redirect_to(article_path(article))
        expect(flash[:alert]).to be_present
      end
    end
  end
end
