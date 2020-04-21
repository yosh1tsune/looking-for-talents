require 'rails_helper'

feature 'Visitor search opportunities' do
  scenario 'successfully match with title or required abilities' do
    create(:opportunity, title: 'Desenvolvedor Ruby',
                         required_abilities: 'Ruby on Rails, SQL')
    create(:opportunity, title: 'Desenvolvedor Full-stack',
                         required_abilities: 'Ruby on Rails, React')
    create(:opportunity, title: 'Desenvolvedor Java',
                         required_abilities: 'Java, SQL')

    visit root_path
    click_on 'Vagas'
    fill_in 'Insira o termo da pesquisa', with: 'Ruby'
    click_on 'Pesquisar'

    expect(page).to have_content('Desenvolvedor Ruby')
    expect(page).to have_content('Desenvolvedor Full-stack')
    expect(page).not_to have_content('Desenvolvedor Java')
  end
end
