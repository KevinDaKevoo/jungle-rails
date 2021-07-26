require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should save if user fields are valid' do
      @user = User.new({
        :first_name => 'Kevin',
        :last_name => 'Yu',
        :email => '123@example.com',
        :password => '123456',
        :password_confirmation => '123456'
        })
      @user.save
      expect(@user).to be_present
    end
    it 'should fail if password and confirmation do not match' do
      @user = User.new({
        :first_name => 'Kevin',
        :last_name => 'Yu',
        :email => '123@example.com',
        :password => '123456',
        :password_confirmation => '654321'
        })
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'should fail if first name is empty' do
      @user = User.new({
        :first_name => nil,
        :last_name => 'Yu',
        :email => '123@example.com',
        :password => '123456',
        :password_confirmation => '123456'
        })
      @user.save
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it 'should fail if last name is empty' do
      @user = User.new({
        :first_name => 'Kevin',
        :last_name => nil,
        :email => '123@example.com',
        :password => '123456',
        :password_confirmation => '123456'
        })
      @user.save
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    it 'should fail if email is empty' do
      @user = User.new({
        :first_name => 'Kevin',
        :last_name => 'Yu',
        :email => nil,
        :password => '123456',
        :password_confirmation => '123456'
        })
      @user.save
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'should fail if password is empty' do
      @user = User.new({
        :first_name => 'Kevin',
        :last_name => 'Yu',
        :email => '123@example.com',
        :password => nil,
        :password_confirmation => '123456'
        })
      @user.save
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'should fail if password is empty' do
      @user = User.new({
        :first_name => 'Kevin',
        :last_name => 'Yu',
        :email => '123@example.com',
        :password => '456',
        :password_confirmation => '456'
        })
      @user.save
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should log in user with correct credentials' do
      @user = User.new({
        :first_name => 'Kevin',
        :last_name => 'Yu',
        :email => '123@example.com',
        :password => '123456',
        :password_confirmation => '123456'
      })
      @user.save
      expect(User.authenticate_with_credentials(@user.email, @user.password)).to eq(@user)
    end
  end
  it 'should not log in user with incorrect email' do
    @user = User.new({
      :first_name => 'Kevin',
      :last_name => 'Yu',
      :email => '123@example.com',
      :password => '123456',
      :password_confirmation => '123456'
    })
    @user.save
    expect(User.authenticate_with_credentials('incorrect@email.com', @user.password)).to eq(nil)
  end
  it 'should not log in user with incorrect password' do
    @user = User.new({
      :first_name => 'Kevin',
      :last_name => 'Yu',
      :email => '123@example.com',
      :password => '123456',
      :password_confirmation => '123456'
    })
    @user.save
    expect(User.authenticate_with_credentials(@user.email, 'incorrectpassword')).to eq(nil)
  end
  it 'should log in user with correct credentials but with white spaces around email' do
    @user = User.new({
      :first_name => 'Kevin',
      :last_name => 'Yu',
      :email => '123@example.com',
      :password => '123456',
      :password_confirmation => '123456'
    })
    @user.save
    expect(User.authenticate_with_credentials('   123@example.com   ', @user.password)).to eq(@user)
  end
  it 'should log in user with correct credentials but varying cases in email' do
    @user = User.new({
      :first_name => 'Kevin',
      :last_name => 'Yu',
      :email => '123@example.com',
      :password => '123456',
      :password_confirmation => '123456'
    })
    @user.save
    expect(User.authenticate_with_credentials('123@example.COM', @user.password)).to eq(@user)
  end
end