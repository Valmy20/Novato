require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'has colums post' do
    post = described_class.column_names
    expect(post).to include('title')
    expect(post).to include('body')
    expect(post).to include('thumb')
    expect(post).to include('slug')
    expect(post).to include('status')
    expect(post).to include('deleted')
    expect(post).to include('postable_type')
    expect(post).to include('postable_id')
  end
end
