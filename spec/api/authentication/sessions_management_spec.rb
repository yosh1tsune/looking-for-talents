require 'rails_helper'

describe 'Sessions Management' do
  context 'authenticate' do
    context 'as headhunter' do
      it 'sucessfully' do
        create(:headhunter, email: 'head@email.com', password: 'Head123')

        post api_v1_authentication_headhunter_path({
          email: 'head@email.com', password: 'Head123', class: 'headhunter'
        })

        json = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(:ok)
        expect(json[:token]).not_to be nil
      end

      context 'fail' do
        it 'if no user match the provided email' do
          post api_v1_authentication_headhunter_path({
            email: 'head@email.com', password: 'Head123', class: 'headhunter'
          })

          json = JSON.parse(response.body, symbolize_names: true)

          expect(response).to have_http_status(:not_found)
          expect(json[:message]).to eq 'Object Not Found'
        end

        it 'if provided password is incorrect' do
          create(:headhunter, email: 'head@email.com', password: 'Head123')

          post api_v1_authentication_headhunter_path({
            email: 'head@email.com', password: '123Head', class: 'headhunter'
          })

          json = JSON.parse(response.body, symbolize_names: true)

          expect(response).to have_http_status(:not_found)
          expect(json[:message]).to eq 'Invalid Password'
        end
      end
    end

    context 'as candidate' do
      it 'sucessfully' do
        create(:candidate, email: 'cand@email.com', password: 'Cand123')

        post api_v1_authentication_headhunter_path({
          email: 'cand@email.com', password: 'Cand123', class: 'candidate'
        })

        json = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(:ok)
        expect(json[:token]).not_to be nil
      end

      context 'fail' do
        it 'if no user match the provided email' do
          post api_v1_authentication_headhunter_path({
            email: 'cand@email.com', password: 'Cand123', class: 'candidate'
          })

          json = JSON.parse(response.body, symbolize_names: true)

          expect(response).to have_http_status(:not_found)
          expect(json[:message]).to eq 'Object Not Found'
        end

        it 'if provided password is incorrect' do
          create(:candidate, email: 'cand@email.com', password: 'Cand123')

          post api_v1_authentication_headhunter_path({
            email: 'cand@email.com', password: '123Cand', class: 'candidate'
          })

          json = JSON.parse(response.body, symbolize_names: true)

          expect(response).to have_http_status(:not_found)
          expect(json[:message]).to eq 'Invalid Password'
        end
      end
    end
  end
end
