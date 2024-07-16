require 'rails_helper'

feature 'Candidate answer a chat', js: true do
  let(:headhunter) { create(:headhunter) }
  let(:candidate) { create(:candidate, :with_profile) }
  let(:opportunity) { create(:opportunity, headhunter: headhunter) }
  let!(:subscription) { create(:subscription, opportunity: opportunity, candidate: candidate) }
  let!(:chat) { create(:chat, headhunter: headhunter, candidate: candidate) }

  it 'candidate see a list of messages received from headhunters' do
    login_as(candidate, scope: :candidate)
    visit root_path
    find('#ChatListAccordion').click

    # expect(page).to have_content 'Mensagens'
    expect(page).to have_content opportunity.title
    expect(page).to have_content headhunter.full_name
  end

  it 'and select a chat and send a message' do
    login_as(candidate, scope: :candidate)
    visit root_path
    find('#ChatListAccordion').click
    click_on headhunter.full_name
    fill_in 'message_text', with: 'Olá!'
    click_on 'message_send'

    expect(page).to have_selector('p', text: 'Olá!', visible: true)
  end
end
