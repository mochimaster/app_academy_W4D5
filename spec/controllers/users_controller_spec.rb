require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'Get #new' do 
    it 'renders user template' do 
      get :new 
      expect(response).to render_template(:new)
    end
  end
  
  describe 'post #create' do 
    context 'With valid params' do
      venom = User.create(username: 'venomz', password: 'starwars')
      it 'logs the user in' do 
        post :create, params: {user: {username: 'yourmum', password: 'starwars'}}
        user = User.find_by(username: 'yourmum')
        expect(session[:session_token]).to eq(user.session_token)
        # session token 
      end
      it 'has all the correct attributes' do
        expect(venom.username).to eq('venomz')
    
        expect(venom.password_digest).to eq(BCrypt::Password.new(starwars))

        
      end
    end 
  end

end
