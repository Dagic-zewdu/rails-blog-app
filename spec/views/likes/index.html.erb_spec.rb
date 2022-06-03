require 'rails_helper'

RSpec.describe 'likes/index', type: :view do
  before(:each) do
    assign(:likes, [
             Like.create!(
               author_id: 2
             ),
             Like.create!(
               author_id: 2
             )
           ])
  end

  it 'renders a list of likes' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
  end
end
