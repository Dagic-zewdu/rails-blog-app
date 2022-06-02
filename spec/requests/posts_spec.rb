require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    it 'returns the correct response' do
      get '/users/user/posts'
      expect(response).to have_http_status(200)
      expect(response.body).to include('Posts')
      expect(response.body).to include('Lists all posts for a certain user')
    end
  end

  describe 'GET /show' do
    it 'returns the correct response' do
      get '/users/user/posts/post'
      expect(response).to have_http_status(200)
      expect(response.body).to include('Posts')
      expect(response.body).to include('Shows info for a specific post')
    end
  end
end
