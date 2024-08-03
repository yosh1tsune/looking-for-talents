require 'rails_helper'

describe ChatChannel do
  it 'subscribes to the stream' do
    subscribe(id: 1)

    expect(subscription).to have_stream_from('chat_1')
  end
end
