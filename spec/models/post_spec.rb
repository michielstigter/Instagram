require 'rails_helper'

RSpec.describe Post, :type => :model do
  describe '#tag_list=' do

    let(:post) { Post.create(title: 'Example post') }

    context 'no tags provided' do
      it 'gives 0 tags to the post' do
        post.tag_list = ''
        expect(post.tags).to be_empty
      end
    end

    context '1 tag provided' do
      it 'gives 1 tag to the post' do
        post.tag_list = '#nic-hola!'
        expect(post.tags.first.text).to eq '#nic-hola!'
      end
    end

    context 'multiple tags provided' do
      it 'gives multiple tags to the post' do
        post.tag_list = '#nic-hola!, #swag'
        expect(post.tags.count).to eq 2
      end
    end
  end
end
