require 'spec_helper'
require 'pp'

describe PpostsController do

  describe 'GET index' do

    it 'returns @pposts' do
      ppost = Ppost.create
      get :index
      expect(assigns(:pposts)).to eq([ppost])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "respond with ok" do
      get :index
      is_expected.to respond_with :ok
    end

    it "respond with content_type" do
      get :index
      is_expected.to respond_with_content_type :html
    end

    it "render with layout" do
      get :index
      is_expected.to render_with_layout :application
    end
  end

  describe 'GET show' do

    before do
      @ppost1 = Ppost.create
      get :show, id: @ppost1
    end

    it 'returns the requested post' do
      expect(assigns(:ppost)).to eq(@ppost1)
    end

    it "renders the show template" do
      expect(response).to render_template("show")
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      with :user
      before {sign_in user}
      it "creates a new post" do
        expect{
          post :create, ppost: FactoryGirl.attributes_for(:ppost)
        }.to change(Ppost,:count).by(1)
      end

      it "redirects to the new post" do
        post :create, ppost: FactoryGirl.attributes_for(:ppost)
        expect(response).to redirect_to Ppost.last
      end
    end
  end

  describe 'GET #new' do
    with :user
    before {sign_in user}
    it 'assigns a new ppost to @ppost' do
      ppost = Ppost.new
      get :new
      expect(ppost).to be_a_new(Ppost)
    end
  end
end