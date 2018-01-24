require 'rails_helper'

RSpec.describe DoctorsController, type: :controller do
  let!(:doctors){FactoryBot.create_list(:user, 5, :referred_doctor )}
  let!(:doctor) {doctors[0]}
  
  let!(:referring_staff){FactoryBot.create(:user, :staff, :confirmed)}
  let!(:referring_doctor){FactoryBot.create(:user, :referring_doctor, :confirmed)}
  let!(:referred_staff){FactoryBot.create(:user, :referred_staff, :confirmed)}
  let!(:referred_doctor){FactoryBot.create(:user, :referred_doctor, :confirmed)}
  let!(:admin){FactoryBot.create(:user, :admin, :confirmed)}
    
  let(:current_user){sign_in nil} 
  describe '#search' do
    context 'as a non-signed in user' do
      it 'forbids access' do
        get :search
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is referring staff' do
      let!(:current_user){ sign_in referring_staff}
      it 'permits access' do
        get :search
        expect(assigns(:clinics)).to include(referred_doctor.clinic)  
        expect(assigns(:clinics)).to_not include(referring_doctor.clinic)  
        expect(assigns(:doctors)).to  include(referred_doctor)
        expect(assigns(:doctors)).to_not include(referring_doctor) 
      end
    end
    context 'current user is referring doctor' do
      let!(:current_user){ sign_in referring_doctor}
      it 'permits access' do
        get :search
        expect(assigns(:clinics)).to include(referred_doctor.clinic)  
        expect(assigns(:clinics)).to_not include(referring_doctor.clinic)  
        expect(assigns(:doctors)).to  include(referred_doctor)
        expect(assigns(:doctors)).to_not include(referring_doctor) 
      end
    end
    context 'current user is referred staff' do
      let!(:current_user){ sign_in referred_staff}
      it 'forbids access' do
        get :search
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is referred doctor' do
      let!(:current_user){ sign_in referred_doctor } 
      it 'forbids access' do
        get :search
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is admin' do
      let!(:current_user){ sign_in admin}
      it 'forbids access' do
        get :search
        expect(response).to redirect_to(home_index_path)
      end
    end
  end

  describe '#select_doctor' do
    context 'current user is referring staff' do
      let!(:current_user){ sign_in referring_staff}
      it 'allows selecting a doctor' do
        post :select_doctor, params: {id: doctor.id} 
        expect(assigns(:doctor)).to eq(doctor)
        expect(response).to redirect_to(edit_referral_path(assigns(:referral).id))
      end
    end
    context 'current user is referring doctor' do
      let!(:current_user){ sign_in referring_doctor}
      it 'allows selecting a doctor' do
        post :select_doctor, params: {id: doctor.id} 
        expect(assigns(:doctor)).to eq(doctor)
        expect(response).to redirect_to(edit_referral_path(assigns(:referral).id))
      end
    end
    context 'current user is referred staff' do
      let!(:current_user){ sign_in referred_staff}
      it 'prevents doctor specific referral creation' do
        get :select_doctor, params: {id: doctor.id}
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is referred doctor' do
      let!(:current_user){ sign_in referred_doctor}
      it 'prevents doctor specific referral creation' do
        get :select_doctor, params: {id: doctor.id}
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'current user is admin' do
     let!(:current_user){ sign_in admin}
     it 'prevents doctor specific referral creation' do
        get :select_doctor, params: {id: doctor.id}
        expect(response).to redirect_to(home_index_path)
      end
   end
  end
end
