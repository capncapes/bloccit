require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:my_question) { Question.create!(title: RandomData.random_question, body: RandomData.random_paragraph + RandomData.random_question, resolved: RandomData.random_bool) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "PUT update" do
    it "updates question with expected attributes" do
      new_question = RandomData.random_question
      new_question_body = RandomData.random_paragraph
      new_resolved = RandomData.random_bool
      
      put :update, params: { id: my_question.id, question: { title: new_question, body: new_question_body, resolved: new_resolved } }
      
      updated_question = assigns(:question)
      expect(updated_question.id).to eq(my_question.id)
      expect(updated_question.title).to eq(new_question)
      expect(updated_question.body).to eq(new_question_body)
      expect(updated_question.resolved).to eq(new_resolved)
    end
    
    it "redirects to the updated question" do
      new_question = RandomData.random_question
      new_question_body = RandomData.random_paragraph
      new_resolved = RandomData.random_bool
      
      put :update, params: { id: my_question.id, question: { title: new_question, body: new_question_body, resolved: new_resolved } }
      expect(response).to redirect_to(my_question)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE destroy" do
    it "deletes the question" do
      delete :destroy, params: { id: my_question.id }
      count = Question.where({ id: my_question.id }).size
      expect(count).to eq(0)
    end
    
    it "redirects to questions index" do
      delete :destroy, params: { id: my_question.id }
      expect(response).to redirect_to(questions_path)
    end
  end
end
