


describe Session do
  describe 'user login' do
    it 'should return nil when an incorrect password is input' do
      session_token = Session.verify_login({:user_name => 'markus2', :password => '12345678' })
      expect(session_token).to eq(nil)
    end
    it 'should return nil when an incorrect username is input' do
      session_token = Session.verify_login({:user_name => 'notmarkus', :password => '1234' })
      expect(session_token).to eq(nil)
    end
    it 'should return the users session token when the correct ' do
      session_token = Session.verify_login({:user_name => 'markus2', :password => '1234'})
      expect(session_token).to eq('uPeNNGlmZGqLuAtISV7X6g==')
    end
end
end
