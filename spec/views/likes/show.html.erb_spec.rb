require 'rails_helper'

RSpec.describe 'likes/show', type: :view do
  before(:each) do
    @like = assign(:like, Like.create!(
                            author_id: 2
                          ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/2/)
  end
end
