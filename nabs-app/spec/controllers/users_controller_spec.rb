require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#index' do
    let!(:users){FactoryBot.create_list(:user, 5, :staff)}
    context 'current user is admin' do
      let(:current_user){FactoryBot.create(:user, :admin, :confirmed)}
      before do
        sign_in current_user
        get :index
      end
      it { expect(response).to be_ok }
      it { expect(response).to render_template(:index) }
      it { expect(assigns(:users)).to match (User.all) }
    end
    
    context 'current user is referring doctor' do
      let(:current_user){FactoryBot.create(:user, :referring_doctor, :confirmed)}
      before do
        sign_in current_user
        get :index
      end
      it { expect(response).to be_redirect }
      it { expect(response).to redirect_to(home_index_path) }
    end
    
    context 'current user is referred doctor' do
      let(:current_user){FactoryBot.create(:user, :referred_doctor, :confirmed)}
      before do
        sign_in current_user
        get :index
      end
      it { expect(response).to be_redirect }
      it { expect(response).to redirect_to(home_index_path) }
    end
    
    context 'current user is staff' do
      let(:current_user){FactoryBot.create(:user, :staff, :confirmed)}
      before do
        sign_in current_user
        get :index
      end
      it { expect(response).to be_redirect }
      it { expect(response).to redirect_to(home_index_path) }
    end
    
    context 'user is not signed in' do
      before do
        get :index
      end
      it { expect(response).to be_redirect }
      it { expect(response).to redirect_to("/u/sign_in") }
    end
  end
  describe '#new' do
    context 'current user is admin' do
      let(:current_user){FactoryBot.create(:user, :admin, :confirmed)}
      before do
        sign_in current_user
        get :new
      end
      it { expect(response).to be_ok }
      it { expect(response).to render_template(:new) }
    end
    
    context 'current user is referring doctor' do
      let(:current_user){FactoryBot.create(:user, :referring_doctor, :confirmed)}
      before do
        sign_in current_user
        get :new
      end
      it { expect(response).to be_ok }
      it { expect(response).to render_template(:new) }
    end
    
    context 'current user is referred doctor' do
      let(:current_user){FactoryBot.create(:user, :referred_doctor, :confirmed)}
      before do
        sign_in current_user
        get :new
      end
      it { expect(response).to be_ok }
      it { expect(response).to render_template(:new) }
    end
    
    context 'current user is staff' do
      let(:current_user){FactoryBot.create(:user, :staff, :confirmed)}
      before do
        sign_in current_user
        get :new
      end
      it { expect(response).to be_redirect }
      it { expect(response).to redirect_to(authenticated_root_path) }
    end
    
    context 'user is not signed in' do
      before do
        get :new
      end
      it { expect(response).to be_redirect }
      it { expect(response).to redirect_to("/u/sign_in") }
    end
  end
  describe '#create' do
    context 'current user is admin' do
      context 'creating an admin user' do
        let(:current_user){FactoryBot.create(:user, :admin, :confirmed)}
        before do
          sign_in current_user
          post :create, params: {user: FactoryBot.build(:user, :admin, :confirmed).attributes}
        end
        it { expect(response).to be_redirect }
        it { expect(response).to redirect_to(user_path(assigns[:user])) }
        it { expect(assigns[:user].role).to eq("admin") }
      end
      
      context 'creating a doctor user' do
        let(:current_user){FactoryBot.create(:user, :admin, :confirmed)}
        before do
          sign_in current_user
          post :create, params: {user: FactoryBot.build(:user, :referring_doctor, :confirmed).attributes}
        end
        it { expect(response).to be_redirect }
        it { expect(response).to redirect_to(user_path(assigns[:user])) }
        it { expect(assigns[:user].role).to eq("doctor") }
      end
      
      context 'creating a staff user' do
        let(:current_user){FactoryBot.create(:user, :admin, :confirmed)}
        before do
          sign_in current_user
          post :create, params: {user: FactoryBot.build(:user, :staff, :confirmed).attributes}
        end
        it { expect(response).to be_redirect }
        it { expect(response).to redirect_to(user_path(assigns[:user])) }
        it { expect(assigns[:user].role).to eq("staff") }
      end
    end
    
    context 'current user is referring doctor' do
      context 'creating an admin user' do
        let(:current_user){FactoryBot.create(:user, :referring_doctor, :confirmed)}
        before do
          sign_in current_user
          post :create, params: {user: FactoryBot.build(:user, :admin, :confirmed).attributes}
        end
        it { expect(response).to be_redirect }
        it { expect(response).to redirect_to(user_path(assigns[:user])) }
        it { expect(assigns[:user].role).to_not eq("admin") }
      end
      
      context 'creating a doctor user' do
        let(:current_user){FactoryBot.create(:user, :referring_doctor, :confirmed)}
        before do
          sign_in current_user
          post :create, params: {user: FactoryBot.build(:user, :referring_doctor, :confirmed).attributes}
        end
        it { expect(response).to be_redirect }
        it { expect(response).to redirect_to(user_path(assigns[:user])) }
        it { expect(assigns[:user].role).to eq("doctor") }
      end
      
      context 'creating a staff user' do
        let(:current_user){FactoryBot.create(:user, :referring_doctor, :confirmed)}
        before do
          sign_in current_user
          post :create, params: {user: FactoryBot.build(:user, :staff, :confirmed).attributes}
        end
        it { expect(response).to be_redirect }
        it { expect(response).to redirect_to(user_path(assigns[:user])) }
        it { expect(assigns[:user].role).to eq("staff") }
      end
    end
    
    context 'current user is referred doctor' do
      context 'creating an admin user' do
        let(:current_user){FactoryBot.create(:user, :referred_doctor, :confirmed)}
        before do
          sign_in current_user
          post :create, params: {user: FactoryBot.build(:user, :admin, :confirmed).attributes}
        end
        it { expect(response).to be_redirect }
        it { expect(response).to redirect_to(user_path(assigns[:user])) }
        it { expect(assigns[:user].role).to_not eq("admin") }
      end
      
      context 'creating a doctor user' do
        let(:current_user){FactoryBot.create(:user, :referred_doctor, :confirmed)}
        before do
          sign_in current_user
          post :create, params: {user: FactoryBot.build(:user, :referring_doctor, :confirmed).attributes}
        end
        it { expect(response).to be_redirect }
        it { expect(response).to redirect_to(user_path(assigns[:user])) }
        it { expect(assigns[:user].role).to eq("doctor") }
      end
      
      context 'creating a staff user' do
        let(:current_user){FactoryBot.create(:user, :referred_doctor, :confirmed)}
        before do
          sign_in current_user
          post :create, params: {user: FactoryBot.build(:user, :staff, :confirmed).attributes}
        end
        it { expect(response).to be_redirect }
        it { expect(response).to redirect_to(user_path(assigns[:user])) }
        it { expect(assigns[:user].role).to eq("staff") }
      end
    end
    
    context 'current user is staff' do
      context 'creating an admin user' do
        let(:current_user){FactoryBot.create(:user, :staff, :confirmed)}
        before do
          sign_in current_user
          post :create, params: {user: FactoryBot.build(:user, :admin, :confirmed).attributes}
        end
        it { expect(response).to be_redirect }
        it { expect(response).to redirect_to(authenticated_root_path) }
        it { expect(assigns[:user]).to eq(nil) }
      end
      
      context 'creating a doctor user' do
        let(:current_user){FactoryBot.create(:user, :staff, :confirmed)}
        before do
          sign_in current_user
          post :create, params: {user: FactoryBot.build(:user, :referring_doctor, :confirmed).attributes}
        end
        it { expect(response).to be_redirect }
        it { expect(response).to redirect_to(authenticated_root_path) }
        it { expect(assigns[:user]).to eq(nil) }
      end
      
      context 'creating a staff user' do
        let(:current_user){FactoryBot.create(:user, :staff, :confirmed)}
        before do
          sign_in current_user
          post :create, params: {user: FactoryBot.build(:user, :staff, :confirmed).attributes}
        end
        it { expect(response).to be_redirect }
        it { expect(response).to redirect_to(authenticated_root_path) }
        it { expect(assigns[:user]).to eq(nil) }
      end
    end
    
    context 'user is not signed in' do
      before do
        post :create, params: {user: FactoryBot.build(:user, :admin, :confirmed).attributes}
      end
      it { expect(response).to be_redirect }
      it { expect(response).to redirect_to("/u/sign_in") }
      it { expect(assigns[:user]).to eq(nil) }
    end
  end
  
  describe '#edit' do
    let!(:users){FactoryBot.create_list(:user, 5, :staff)}
    context 'current user is admin' do
      context 'editing current user' do
        let(:current_user){FactoryBot.create(:user, :admin, :confirmed)}
        before do
          sign_in current_user
          get :edit, params: { id: current_user.id }
        end
        it { expect(response).to be_ok }
        it { expect(response).to render_template(:edit) }
      end
      
      context 'editing another user' do
        let(:current_user){FactoryBot.create(:user, :admin, :confirmed)}
        before do
          sign_in current_user
          get :edit, params: { id: users.first.id }
        end
        it { expect(response).to be_ok }
        it { expect(response).to render_template(:edit) }
      end
    end
    
    context 'current user is doctor' do
      context 'editing current user' do
        let(:current_user){FactoryBot.create(:user, :referring_doctor, :confirmed)}
        before do
          sign_in current_user
          get :edit, params: { id: current_user.id }
        end
        it { expect(response).to be_ok }
        it { expect(response).to render_template(:edit) }
      end
      
      context 'editing another user' do
        let(:current_user){FactoryBot.create(:user, :referring_doctor, :confirmed)}
        before do
          sign_in current_user
          get :edit, params: { id: users.first.id }
        end
        it { expect(response).to be_redirect }
        it { expect(response).to redirect_to(authenticated_root_path) }
      end
    end
    
    context 'current user is staff' do
      context 'editing current user' do
        let(:current_user){FactoryBot.create(:user, :staff, :confirmed)}
        before do
          sign_in current_user
          get :edit, params: { id: current_user.id }
        end
        it { expect(response).to be_ok }
        it { expect(response).to render_template(:edit) }
      end
      
      context 'editing another user' do
        let(:current_user){FactoryBot.create(:user, :referring_doctor, :confirmed)}
        before do
          sign_in current_user
          get :edit, params: { id: users.first.id }
        end
        it { expect(response).to be_redirect }
        it { expect(response).to redirect_to(authenticated_root_path) }
      end
    end
    
    context 'user is not signed in' do
      before do
        get :edit, params: { id: users.first.id }
      end
      it { expect(response).to be_redirect }
      it { expect(response).to redirect_to("/u/sign_in") }
    end
  end
  describe '#show' do
    let!(:users){FactoryBot.create_list(:user, 5, :staff)}
    context 'current user is admin' do
      context 'showing current user' do
        let(:current_user){FactoryBot.create(:user, :admin, :confirmed)}
        before do
          sign_in current_user
          get :show, params: { id: current_user.id }
        end
        it { expect(response).to be_ok }
        it { expect(response).to render_template(:show) }
      end
      
      context 'showing another user' do
        let(:current_user){FactoryBot.create(:user, :admin, :confirmed)}
        before do
          sign_in current_user
          get :show, params: { id: users.first.id }
        end
        it { expect(response).to be_ok }
        it { expect(response).to render_template(:show) }
      end
    end
    
    context 'current user is doctor' do
      context 'showing current user' do
        let(:current_user){FactoryBot.create(:user, :referring_doctor, :confirmed)}
        before do
          sign_in current_user
          get :show, params: { id: current_user.id }
        end
        it { expect(response).to be_ok }
        it { expect(response).to render_template(:show) }
      end
      
      context 'showing another user' do
        let(:current_user){FactoryBot.create(:user, :referring_doctor, :confirmed)}
        before do
          sign_in current_user
          get :show, params: { id: users.first.id }
        end
        it { expect(response).to be_redirect }
        it { expect(response).to redirect_to(authenticated_root_path) }
      end
    end
    
    context 'current user is staff' do
      context 'showing current user' do
        let(:current_user){FactoryBot.create(:user, :staff, :confirmed)}
        before do
          sign_in current_user
          get :show, params: { id: current_user.id }
        end
        it { expect(response).to be_ok }
        it { expect(response).to render_template(:show) }
      end
      
      context 'showing another user' do
        let(:current_user){FactoryBot.create(:user, :referring_doctor, :confirmed)}
        before do
          sign_in current_user
          get :show, params: { id: users.first.id }
        end
        it { expect(response).to be_redirect }
        it { expect(response).to redirect_to(authenticated_root_path) }
      end
    end
    
    context 'user is not signed in' do
      before do
        get :show, params: { id: users.first.id }
      end
      it { expect(response).to be_redirect }
      it { expect(response).to redirect_to("/u/sign_in") }
    end
  end
  describe '#update' do
    let!(:users){FactoryBot.create_list(:user, 5, :staff)}
    let!(:new_attr) do
      { :first_name => "First", :last_name => "Last" }
    end
    context 'current user is admin' do
      context 'updating current user' do
        let(:current_user){FactoryBot.create(:user, :admin, :confirmed)}
        before do
          sign_in current_user
          put :update, params: {id: current_user.id, user: new_attr}
          current_user.reload
        end
        it { expect(response).to be_redirect }
        it { expect(response).to redirect_to(user_path(current_user)) }
        it { expect(current_user.first_name).to eq("First") }
        it { expect(current_user.last_name).to eq("Last") }
      end
      
      context 'updating another user' do
        let(:current_user){FactoryBot.create(:user, :admin, :confirmed)}
        before do
          sign_in current_user
          put :update, params: {id: users.first.id, user: new_attr}
          users.first.reload
        end
        it { expect(response).to be_redirect }
        it { expect(response).to redirect_to(user_path(users.first)) }
        it { expect(users.first.first_name).to eq("First") }
        it { expect(users.first.last_name).to eq("Last") }
      end
    end
    
    context 'current user is doctor' do
      context 'updating current user' do
        let(:current_user){FactoryBot.create(:user, :referring_doctor, :confirmed)}
        before do
          sign_in current_user
          put :update, params: {id: current_user.id, user: new_attr}
          current_user.reload
        end
        it { expect(response).to be_redirect }
        it { expect(response).to redirect_to(user_path(current_user)) }
        it { expect(current_user.first_name).to eq("First") }
        it { expect(current_user.last_name).to eq("Last") }
      end
      
      context 'updating another user' do
        let(:current_user){FactoryBot.create(:user, :referring_doctor, :confirmed)}
        before do
          sign_in current_user
          put :update, params: {id: users.first.id, user: new_attr}
          users.first.reload
        end
        it { expect(response).to be_redirect }
        it { expect(response).to redirect_to(authenticated_root_path) }
        it { expect(users.first.first_name).to_not eq("First") }
        it { expect(users.first.last_name).to_not eq("Last") }
      end
    end
    
    context 'current user is staff' do
      context 'updating current user' do
        let(:current_user){FactoryBot.create(:user, :staff, :confirmed)}
        before do
          sign_in current_user
          put :update, params: {id: current_user.id, user: new_attr}
          current_user.reload
        end
        it { expect(response).to be_redirect }
        it { expect(response).to redirect_to(user_path(current_user)) }
        it { expect(current_user.first_name).to eq("First") }
        it { expect(current_user.last_name).to eq("Last") }
      end
      
      context 'updating another user' do
        let(:current_user){FactoryBot.create(:user, :staff, :confirmed)}
        before do
          sign_in current_user
          put :update, params: {id: users.first.id, user: new_attr}
          users.first.reload
        end
        it { expect(response).to be_redirect }
        it { expect(response).to redirect_to(authenticated_root_path) }
        it { expect(users.first.first_name).to_not eq("First") }
        it { expect(users.first.last_name).to_not eq("Last") }
      end
    end
    
    context 'user is not signed in' do
      before do
        put :update, params: {id: users.first.id, user: new_attr}
        users.first.reload
      end
      it { expect(response).to be_redirect }
      it { expect(response).to redirect_to("/u/sign_in") }
      it { expect(users.first.first_name).to_not eq("First") }
      it { expect(users.first.last_name).to_not eq("Last") }
    end
  end
  describe '#destroy' do
    let!(:users){FactoryBot.create_list(:user, 5, :staff)}
    context 'current user is admin' do
      let(:current_user){FactoryBot.create(:user, :admin, :confirmed)}
      before do
        sign_in current_user
        delete :destroy, params: { id: users.first.id }
      end
        it { expect(User.count).to eq(5) }
    end
    
    context 'current user is doctor' do
      let(:current_user){FactoryBot.create(:user, :referring_doctor, :confirmed)}
      before do
        sign_in current_user
        delete :destroy, params: { id: users.first.id }
      end
        it { expect(User.count).to eq(6) }
    end
    
    context 'current user is staff' do
      let(:current_user){FactoryBot.create(:user, :staff, :confirmed)}
      before do
        sign_in current_user
        delete :destroy, params: { id: users.first.id }
      end
        it { expect(User.count).to eq(6) }
    end
    
    context 'user not signed in' do
      before do
        delete :destroy, params: { id: users.first.id }
      end
        it { expect(User.count).to eq(5) }
    end
  end
end
