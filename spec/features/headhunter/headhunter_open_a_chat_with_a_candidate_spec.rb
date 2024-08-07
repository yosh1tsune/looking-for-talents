require 'rails_helper'

feature 'Headhunter open a chat with a candidate', js: true do
  let(:headhunter) { create(:headhunter) }
  let(:candidate) { create(:candidate, :with_profile) }
  let(:opportunity) { create(:opportunity, headhunter: headhunter) }
  let!(:subscription) { create(:subscription, opportunity: opportunity, candidate: candidate) }

  it 'headhunter visualize a list with all candidates applied in his opportunities' do
    login_as(headhunter, scope: :headhunter)
    visit root_path
    find('#ChatListAccordion').click

    # expect(page).to have_content 'Mensagens'
    expect(page).to have_content opportunity.title
    expect(page).to have_content candidate.profile.name
  end

  context 'and open a chat window with a candidate' do
    it "and don't persist it if a message isn't sent" do
      login_as(headhunter, scope: :headhunter)
      visit root_path
      find('#ChatListAccordion').click
      click_on candidate.profile.name

      chat = Chat.find_by(headhunter: headhunter, candidate: candidate)

      expect(chat).to eq nil

      expect(page).to have_selector('span', text: candidate.profile.name, visible: true)
      expect(page).to have_selector('input#message_text')
      expect(page).to have_selector('button#message_send')
    end

    it 'and persist if sent' do
      login_as(headhunter, scope: :headhunter)
      visit root_path
      find('#ChatListAccordion').click
      click_on candidate.profile.name
      fill_in 'message_text', with: 'Olá!'
      click_on 'message_send'

      chat = Chat.find_by(headhunter: headhunter, candidate: candidate)

      expect(page).to have_selector('p', text: 'Olá!', visible: true)
      expect(chat.class).to eq Chat
      expect(chat.headhunter).to eq headhunter
      expect(chat.candidate).to eq candidate
    end
  end
end
