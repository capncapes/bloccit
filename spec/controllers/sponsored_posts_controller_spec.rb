require 'rails_helper'
include RandomData
include SessionsHelper

RSpec.describe SponsoredPostsController, type: :controller do
  let(:my_topic) { create(:topic) }
  let(:my_user) { create(:user) }
  let(:my_sponsored_post) { create(:sponsored_post, topic: my_topic) }

  context "guest user" do
    describe "GET #show" do
      it "returns http success" do
        get :show, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
        expect(response).to have_http_status(:success)
      end
      
      it "renders the #show view" do
        get :show, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
        expect(response).to render_template(:show)
      end
      
      it "assigns my_sponsored_post to @sponsored_post" do
        get :show, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
        expect(assigns(:sponsored_post)).to eq(my_sponsored_post)
      end
    end
    
    describe "GET new" do
      it "returns http redirect" do
        get :new, params: { topic_id: my_topic.id }
        expect(response).to redirect_to(new_session_path)
      end
    end
    
    describe "POST create" do
      it "returns http redirect" do
        post :create, params: { topic_id: my_topic.id, sponsored_post: { title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_number } }
        expect(response).to redirect_to(new_session_path)
      end
    end
    
    describe "GET edit" do
      it "returns http redirect" do
        get :edit, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
        expect(response).to redirect_to(new_session_path)
      end
    end
    
    describe "PUT update" do
      it "returns http redirect" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        new_price = RandomData.random_number
        
        put :update, params: { topic_id: my_topic.id, id: my_sponsored_post.id, sponsored_post: { title: new_title, body: new_body, price: new_price } }
        expect(response).to redirect_to(new_session_path)
      end
    end
    
    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
        expect(response).to have_http_status(:redirect)
      end
    end
  end
  
  context "member user" do
    describe "GET #show" do
      it "returns http success" do
        get :show, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
        expect(response).to have_http_status(:success)
      end
      
      it "renders the #show view" do
        get :show, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
        expect(response).to render_template(:show)
      end
      
      it "assigns my_sponsored_post to @sponsored_post" do
        get :show, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
        expect(assigns(:sponsored_post)).to eq(my_sponsored_post)
      end
    end
    
    describe "GET new" do
      it "returns http redirect" do
        get :new, params: { topic_id: my_topic.id }
        expect(response).to redirect_to(my_topic)
      end
    end
    
    describe "POST create" do
      it "returns http redirect" do
        post :create, params: { topic_id: my_topic.id, sponsored_post: { title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_number } }
        expect(response).to redirect_to([my_topic, my_sponsored_post])
      end
    end
    
    describe "GET edit" do
      it "returns http redirect" do
        get :edit, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
        expect(response).to redirect_to([my_topic, my_sponsored_post])
      end
    end
    
    describe "PUT update" do
      it "returns http redirect" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        new_price = RandomData.random_number
        
        put :update, params: { topic_id: my_topic.id, id: my_sponsored_post.id, sponsored_post: { title: new_title, body: new_body, price: new_price } }
        expect(response).to redirect_to([my_topic, my_sponsored_post])
      end
    end
    
    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
        expect(response).to redirect_to([my_topic, my_sponsored_post])
      end
    end
  end
  
  context "admin user" do
    before do
      my_user.admin!
      create_session(my_user)
    end
    
    describe "GET show" do
      it "returns http success" do
        get :show, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
        expect(response).to render_template(:show)
      end

      it "assigns my_post to @post" do
        get :show, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
        expect(assigns(:sponsored_post)).to eq(my_sponsored_post)
      end
    end

    describe "GET new" do
      it "returns http success" do
        get :new, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
        expect(response).to render_template(:new)
      end

      it "instantiates @sponsored_post" do
        get :new, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
        expect(assigns(:sponsored_post)).not_to be_nil
      end
    end

    describe "POST create" do
      it "increases the number of SponsoredPost by 1" do
        expect{ post :create, params: { topic_id: my_topic.id, id: my_sponsored_post.id, sponsored_post: { title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_number } } }.to change(SponsoredPost, :count).by(1)
      end

      it "assigns the new sponsored post to @sponsored_post" do
        post :create, params: { topic_id: my_topic.id, id: my_sponsored_post.id, sponsored_post: { title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_number } }
        expect(assigns(:sponsored_post)).to eq(SponsoredPost.last)
      end

      it "redirects to the new sponsored post" do
        post :create, params: { topic_id: my_topic.id, id: my_sponsored_post.id, sponsored_post: { title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_number } }
        expect(response).to redirect_to([my_topic, SponsoredPost.last])
      end
    end

    describe "GET edit" do
      it "returns http success" do
        get :edit, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
        expect(response).to render_template(:edit)
      end

      it "assigns sponsored_post to be updated to @sponsored_post" do
        get :edit, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
        sponsored_post_instance = assigns(:sponsored_post)

        expect(sponsored_post_instance.id).to eq(my_sponsored_post.id)
        expect(sponsored_post_instance.title).to eq(my_sponsored_post.title)
        expect(sponsored_post_instance.body).to eq(my_sponsored_post.body)
        expect(sponsored_post_instance.price).to eq(my_sponsored_post.price)
      end
    end

    describe "PUT update" do
      it "updates sponsored post with expected attributes" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        new_price = RandomData.random_number

        put :update, params: { topic_id: my_topic.id, id: my_sponsored_post.id, sponsored_post: { title: new_title, body: new_body, price: new_price } }

        updated_sponsored_post = assigns(:sponsored_post)
        expect(updated_sponsored_post.id).to eq(my_sponsored_post.id)
        expect(updated_sponsored_post.title).to eq(new_title)
        expect(updated_sponsored_post.body).to eq(new_body)
        expect(updated_sponsored_post.price).to eq(new_price)
      end

      it "redirects to the updated sponsored post" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        new_price = RandomData.random_number

        put :update, params: { topic_id: my_topic.id, id: my_sponsored_post.id, sponsored_post: { title: new_title, body: new_body, price: new_price } }
        expect(response).to redirect_to([my_topic, my_sponsored_post])
      end
    end

    describe "DELETE destroy" do
      it "deletes the sponsored post" do
        delete :destroy, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
        count = SponsoredPost.where({ id: my_sponsored_post.id }).size
        expect(count).to eq(0)
      end

      it "redirects to posts index" do
        delete :destroy, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
        expect(response).to redirect_to(my_topic)
      end
    end
  end
end
