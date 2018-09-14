require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  
  it {should validate_presence_of(:username)}
  it {should validate_presence_of(:password_digest)}
  it {should validate_presence_of(:session_token)}
  it {should validate_length_of(:password).is_at_least(6)}
  
  # write association test after DB generation
  
  describe 'password_encryption' do
    it "does not save passwords to database as plain text" do
      user = User.create(username: 'Smith', password: 'starwars')
      # user1.save
      user1 = User.find_by(username: 'Smith')
      # debugger
      #Ask why are we using password ? Shouldnt it never be saved to DB ?
      # when we use .find_by, we are quering DB , user will never come out
      # with .password. It will only have password_digest
      # expect(user.password).not_to be('starwars')
      expect(user1).to eq(user)
      
    end
    
    it "encrpts password using BCrypt" do
      expect(BCrypt::Password).to receive(:create).with('starwars')
      User.new(username: 'Smith', password: 'starwars')
    end
  end
  
  describe 'find_by_credentials' do 
    user1 = User.create(username: 'Jon', password: 'starwars')
    it 'returns the correct user' do
      smith_user = User.find_by_credentials('Jon', 'starwars')
      expect(smith_user.username).to eq(user1.username)
    end
    
    it 'returns nil if user not found' do 
      smith_user = User.find_by_credentials('Philip', 'starwars')
      expect(smith_user).to be(nil)
    end
    
    it 'returns nil if password is wrong' do 
      smith_user = User.find_by_credentials('Jon', 'starwars1')
      expect(smith_user).to be(nil)
    end
  end
    
  describe 'ensure_session_token' do
    
    it 'returns a SecureRandom object when there is no session token'  
      # jen_user  = User.new(username: 'Jen', password: 'starwars')
      # expect(jen_user.session_token.class).to be(SecureRandom)
      # 
    
    # end
    
    it 'returns the current session_token if there is an existing session_token' 
      
    # end
  end
  
  
end
