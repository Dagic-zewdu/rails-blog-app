require 'rails_helper'

RSpec.describe 'likes/edit', type: :view do
  before(:each) do
    @like = assign(:like, Like.create!(
                            author_id: 1
                          ))
  end

  it 'renders the edit like form' do
    render

    assert_select 'form[action=?][method=?]', like_path(@like), 'post' do
      assert_select 'input[name=?]', 'like[author_id]'
    end
  end
end
