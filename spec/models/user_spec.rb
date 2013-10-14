# == Schema Information
#
# Table name: users
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe User do

  # Create a global type variable that can be used with the merge function.
  # so that there isn't any uncessary repeats.
  before do
    @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  # The two describe blocks cover the case where @user and found_user should be the same (password match) and different 
  # (password mismatch); they use the “equals” eq test for object equality (which uses == to test equality, 
  # as seen in Section 4.3.1). Note that the tests in

# Test for a length validation on passwords, requiring that they be at least six characters long...
  describe "with a password that's too short" do
    before { @user.save }
  # RSpec’s let method provides a convenient way to create local variables inside tests.
# Let memoizes its value, so that the first nested describe block in Listing 6.28 invokes let to retrieve the user from 
# the database using find_by, but the second describe block doesn’t hit the database a second time.
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticates("invalid") }

      it {should_not eq user_for_invalid_password}
      specify {expect(user_for_invalid_password).to be_false}
    end
  end

  it { should_not be_valid }

  describe "when password is not present" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com", password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before {@user.password_confirmation = "mismatch"}
    it {should_not be_valid}
  end
end
