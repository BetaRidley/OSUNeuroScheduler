require 'rails_helper'

RSpec.describe ClinicsController, type: :controller do
  let!(:referring_staff){FactoryBot.create(:user, :staff, :confirmed)}
  let!(:referring_doctor){FactoryBot.create(:user, :referring_doctor, :confirmed)}
  let!(:referred_staff){FactoryBot.create(:user, :referred_staff, :confirmed)}
  let!(:referred_doctor){FactoryBot.create(:user, :referred_doctor, :confirmed)}
  let!(:admin){FactoryBot.create(:user, :admin, :confirmed)}
    
  let(:current_user){sign_in nil} 
  describe '#index' do
    context 'as a non-signed in user' do
      it 'forbids access' do
        get :index
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is referring staff' do
      let!(:current_user){ sign_in referring_staff}
      it 'forbids access' do
        get :index
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is referring doctor' do
      let!(:current_user){ sign_in referring_doctor}
      it 'forbids access' do
        get :index
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is referred staff' do
      let!(:current_user){ sign_in referred_staff}
      it 'forbids access' do
        get :index
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is referred doctor' do
      let!(:current_user){ sign_in referred_doctor } 
      it 'forbids access' do
        get :index
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is admin' do
      let!(:current_user){ sign_in admin}
      it 'allows access' do
        get :index
        expect(assigns(:clinics)).to eq(Clinic.all)
      end
    end
  end

  describe '#show' do
    context 'as a non-signed in user' do
      it 'forbids access' do
        get :show, params: {id: referring_staff.clinic.id}
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is referring staff' do
      let!(:current_user){ sign_in referring_staff}
      it 'forbids access' do
        get :show, params: {id: referring_staff.clinic.id}
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is referring doctor' do
      let!(:current_user){ sign_in referring_doctor}
      it 'forbids access' do
        get :show, params: {id: referring_staff.clinic.id}
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is referred staff' do
      let!(:current_user){ sign_in referred_staff}
      it 'forbids access' do
        get :show, params: {id: referring_staff.clinic.id}
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is referred doctor' do
      let!(:current_user){ sign_in referred_doctor } 
      it 'forbids access' do
        get :show, params: {id: referring_staff.clinic.id}
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is admin' do
      let!(:current_user){ sign_in admin}
      it 'allows access' do
        get :show, params: {id: referring_staff.clinic.id}
        expect(assigns(:clinic)).to eq(referring_staff.clinic)
      end
    end
  end
  describe '#new' do
    context 'as a non-signed in user' do
      it 'forbids access' do
        get :new
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is referring staff' do
      let!(:current_user){ sign_in referring_staff}
      it 'forbids access' do
        get :new
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is referring doctor' do
      let!(:current_user){ sign_in referring_doctor}
      it 'forbids access' do
        get :new
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is referred staff' do
      let!(:current_user){ sign_in referred_staff}
      it 'forbids access' do
        get :new
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is referred doctor' do
      let!(:current_user){ sign_in referred_doctor } 
      it 'forbids access' do
        get :new
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is admin' do
      let!(:current_user){ sign_in admin}
      it 'allows access' do
        get :new
        expect(assigns(:clinic)).to be_a_new(Clinic) 
      end
    end
  end
  describe '#edit' do
    context 'as a non-signed in user' do
      it 'forbids access' do
        get :edit, params: {id: referring_staff.clinic.id }
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is referring staff' do
      let!(:current_user){ sign_in referring_staff}
      it 'forbids access' do
        get :edit, params: {id: referring_staff.clinic.id }
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is referring doctor' do
      let!(:current_user){ sign_in referring_doctor}
      it 'forbids access' do
        get :edit, params: {id: referring_staff.clinic.id }
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is referred staff' do
      let!(:current_user){ sign_in referred_staff}
      it 'forbids access' do
        get :edit, params: {id: referring_staff.clinic.id }
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is referred doctor' do
      let!(:current_user){ sign_in referred_doctor } 
      it 'forbids access' do
        get :edit, params: {id: referring_staff.clinic.id }
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is admin' do
      let!(:current_user){ sign_in admin}
      it 'allows access' do
        get :edit, params: {id: referring_staff.clinic.id }
        expect(assigns(:clinic)).to eq(referring_staff.clinic) 
      end
    end
  end
  describe '#update' do
    context 'as a non-signed in user' do
      it 'forbids access' do
        post :update, params: {id: referring_staff.clinic.id, clinic: {name: "Test"}}
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is referring staff' do
      let!(:current_user){ sign_in referring_staff}
      it 'forbids access' do
        post :update, params: {id: referring_staff.clinic.id, clinic: {name: "Test"}}
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is referring doctor' do
      let!(:current_user){ sign_in referring_doctor}
      it 'forbids access' do
        post :update, params: {id: referring_staff.clinic.id, clinic: {name: "Test"}}
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is referred staff' do
      let!(:current_user){ sign_in referred_staff}
      it 'forbids access' do
        post :update, params: {id: referring_staff.clinic.id, clinic: {name: "Test"}}
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is referred doctor' do
      let!(:current_user){ sign_in referred_doctor } 
      it 'forbids access' do
        post :update, params: {id: referring_staff.clinic.id, clinic: {name: "Test"}}
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is admin' do
      let!(:current_user){ sign_in admin}
      it 'allows access' do
        old_name = referring_staff.clinic.name
        post :update, params: {id: referring_staff.clinic.id, clinic: {name: "Test"}}
        expect(assigns(:clinic).name).to eq('Test')
        expect(assigns(:clinic).name).to_not eq(old_name) 
      end
    end
  end
  describe '#create' do
    context 'as a non-signed in user' do
      it 'forbids access' do
        post :create, params: {clinic: {name: "Test"} }
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is referring staff' do
      let!(:current_user){ sign_in referring_staff}
      it 'forbids access' do
        post :create, params: {clinic: {name: "Test"} }
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is referring doctor' do
      let!(:current_user){ sign_in referring_doctor}
      it 'forbids access' do
        post :create, params: {clinic: {name: "Test"} }
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is referred staff' do
      let!(:current_user){ sign_in referred_staff}
      it 'forbids access' do
        post :create, params: {clinic: {name: "Test"} }
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is referred doctor' do
      let!(:current_user){ sign_in referred_doctor } 
      it 'forbids access' do
        post :create, params: {clinic: {name: "Test"} }
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is admin' do
      let!(:current_user){ sign_in admin}
      it 'allows access' do
        expect{ post :create, params: {clinic: {name: "Test"} }}.to change(Clinic, :count).by(1)
      end
    end
  end
  describe '#destroy' do
  let!(:clinic){FactoryBot.create(:clinic)}
    context 'as a non-signed in user' do
      it 'forbids access' do
        delete :destroy, params: {id: clinic.id}
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is referring staff' do
      let!(:current_user){ sign_in referring_staff}
      it 'forbids access' do
        delete :destroy, params: {id: clinic.id}
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is referring doctor' do
      let!(:current_user){ sign_in referring_doctor}
      it 'forbids access' do
        delete :destroy, params: {id: clinic.id}
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is referred staff' do
      let!(:current_user){ sign_in referred_staff}
      it 'forbids access' do
        delete :destroy, params: {id: clinic.id}
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is referred doctor' do
      let!(:current_user){ sign_in referred_doctor } 
      it 'forbids access' do
        delete :destroy, params: {id: clinic.id}
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is admin' do
      let!(:current_user){ sign_in admin}
      it 'allows access' do
        expect{delete :destroy, params: {id: clinic.id} }.to change(Clinic, :count).by(-1)
      end
    end
  end
end
