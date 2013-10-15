require 'spec_helper'

describe "User Pages" do
  describe "signin page" do
    it "should have the content for 'signin'" do
    	visit signin_path
    	expect(page).to have_content('Sign In')
    	expect(page).to have_content('Email')
    	expect(page).to have_content('Password')

    	# expect to have 'Login' button
    	# expect to have link to 'Sign Up for Demo'
     
    end
  end

  describe "sign up page" do
    before { visit signup_path }

    it "should have the content for 'Sign Up'" do
      expect(page).to have_content('First name')
      expect(page).to have_content('Last name')
      expect(page).to have_content('Email')
      expect(page).to have_content('Phone')
      expect(page).to have_content('Company')
      expect(page).to have_content('Address')
      expect(page).to have_content('City')
      expect(page).to have_content('State')
      expect(page).to have_content('Zip')
      expect(page).to have_content('Password')
      expect(page).to have_content('Confirmation')
      
      # expect to have 'Create my account' button
      # expect to have some indication that this is for a 'demo' account
    end



    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
          expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "First name",   with: "Example"
        fill_in "Last name",    with: "User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Phone",        with: "555-867-5309"
        fill_in "Company",      with: "Acme Inc."
        fill_in "Address",      with: "123 Main St"
        fill_in "City",         with: "Any Town"
        fill_in "State",        with: "IL"
        fill_in "Zip",          with: "99999"
        fill_in "Password",     with: "123456"
        fill_in "Confirmation", with: "123456"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        #it { should have_title(user.name) }
        #it { should have_selector('div.alert.alert-success', text: 'Welcome to Gulch Solutions') }
      end
    end
  end

end
