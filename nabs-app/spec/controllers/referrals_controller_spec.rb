require 'rails_helper'

RSpec.describe ReferralsController, type: :controller do
  let!(:referring_staff){FactoryBot.create(:user, :staff, :confirmed)}
  let!(:referring_doctor){FactoryBot.create(:user, :referring_doctor, :confirmed)}
  let!(:referred_staff){FactoryBot.create(:user, :referred_staff, :confirmed)}
  let!(:referred_doctor){FactoryBot.create(:user, :referred_doctor, :confirmed)}
  let!(:admin){FactoryBot.create(:user, :admin, :confirmed)}

  let(:current_user){ sign_in nil}

  let!(:referrals_staff){FactoryBot.create_list(:referral, 5, created_by: referring_staff)}
  let!(:ref_staff){referrals_staff[0]}
  let!(:referrals_doc){FactoryBot.create_list(:referral, 5, created_by: referring_doctor)}
  let!(:ref_doc){referrals_doc[0]}
  let!(:special){FactoryBot.create(:specialization)}

  describe '#index' do
    context 'as a non-signed in user' do
      it 'forbids access' do
        get :index
        expect(response).to redirect_to(home_index_path)
      end 
    end
    context 'as a referring staff user' do
      let!(:current_user){ sign_in referring_staff}
      it 'allows access' do
        get :index
        expect(assigns(:referrals)).to match_array(referrals_staff)
      end 
    end
    context 'as a referring doctor user' do
      let!(:current_user){ sign_in referring_doctor}
      it 'allows access' do
        get :index
        expect(assigns(:referrals)).to match_array(referrals_doc)
      end 
    end
    context 'as a referred staff user' do
      let!(:current_user){ sign_in referred_staff}
      it 'forbids access' do
        get :index
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'as a referred doctor user' do
      let!(:current_user){ sign_in referred_doctor}
      it 'forbids access' do
        get :index
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'as an admin' do
      let!(:current_user){ sign_in admin}
      it 'forbids access' do
        get :index
        expect(response).to redirect_to(home_index_path)
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
    context 'as a referring staff user' do
      let!(:current_user){ sign_in referring_staff}
      it 'allows access' do
        get :new
        expect(assigns(:referral)).to be_a_new(Referral)
      end 
    end
    context 'as a referring doctor user' do
      let!(:current_user){ sign_in referring_doctor}
      it 'allows access' do
        get :new
        expect(assigns(:referral)).to be_a_new(Referral)
      end 
    end
    context 'as a referred staff user' do
      let!(:current_user){ sign_in referred_staff}
      it 'forbids access' do
        get :new
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'as a referred doctor user' do
      let!(:current_user){ sign_in referred_doctor}
      it 'forbids access' do
        get :new
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'as an admin' do
      let!(:current_user){ sign_in admin}
      it 'forbids access' do
        get :new
        expect(response).to redirect_to(home_index_path)
      end 
    end
  end
  describe '#create' do
    context 'as a non-signed in user' do
      it 'forbids access' do
        post :create
        expect(response).to redirect_to(home_index_path)
      end 
    end
    context 'as a referring staff user' do
      let!(:current_user){ sign_in referring_staff}
      it 'allows access' do
        expect{ post :create, params: { referral: {specialization_id: special.id}} }.
          to change(Referral, :count).by(1)
      end 
    end
    context 'as a referring doctor user' do
      let!(:current_user){ sign_in referring_doctor}
      it 'allows access' do
        expect{ post :create, params: { referral: {specialization_id: special.id}} }.
          to change(Referral, :count).by(1)
      end 
    end
    context 'as a referred staff user' do
      let!(:current_user){ sign_in referred_staff}
      it 'forbids access' do
        post :create
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'as a referred doctor user' do
      let!(:current_user){ sign_in referred_doctor}
      it 'forbids access' do
        post :create
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'as an admin' do
      let!(:current_user){ sign_in admin}
      it 'forbids access' do
        post :create
        expect(response).to redirect_to(home_index_path)
      end 
    end
  end
  describe '#edit' do
    context 'as a non-signed in user' do
      it 'forbids access' do
        get :edit, params:{id: ref_staff.id}
        expect(response).to redirect_to(home_index_path)
      end 
    end
    context 'as a referring staff user' do
      let!(:current_user){ sign_in referring_staff}
      it 'allows access' do
        get :edit, params:{id: ref_staff.id}
        expect(assigns(:referral)).to eq(ref_staff)
      end 
    end
    context 'as a referring doctor user' do
      let!(:current_user){ sign_in referring_doctor}
      it 'allows access' do
        get :edit, params:{id: ref_doc.id}
        expect(assigns(:referral)).to eq(ref_doc)
      end 
    end
    context 'as a referred staff user' do
      let!(:current_user){ sign_in referred_staff}
      it 'forbids access' do
        get :edit, params:{id: ref_staff.id}
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'as a referred doctor user' do
      let!(:current_user){ sign_in referred_doctor}
      it 'forbids access' do
        get :edit, params:{id: ref_staff.id}
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'as an admin' do
      let!(:current_user){ sign_in admin}
      it 'forbids access' do
        get :edit, params:{id: ref_staff.id}
        expect(response).to redirect_to(home_index_path)
      end 
    end
  end
  describe '#update' do
    context 'as a non-signed in user' do
      it 'forbids access' do
        post :update, params: {id: ref_staff.id, referral: {specialization_id: special.id}}
        expect(response).to redirect_to(home_index_path)
      end 
    end
    context 'as a referring staff user' do
      let!(:current_user){ sign_in referring_staff}
      it 'allows access' do
        old_special = ref_staff.specialization
        post :update, params: {id: ref_staff.id, referral: {specialization_id: special.id}}
        expect(assigns(:referral).specialization).to eq(special)
        expect(assigns(:referral).specialization).to_not eq(old_special)
      end 
    end
    context 'as a referring doctor user' do
      let!(:current_user){ sign_in referring_doctor}
      it 'allows access' do
        old_special = ref_doc.specialization
        post :update, params: {id: ref_doc.id, referral: {specialization_id: special.id}}
        expect(assigns(:referral).specialization).to eq(special)
        expect(assigns(:referral).specialization).to_not eq(old_special)
      end 
    end
    context 'as a referred staff user' do
      let!(:current_user){ sign_in referred_staff}
      it 'forbids access' do
        post :update, params: {id: ref_staff.id, referral: {specialization_id: special.id}}
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'as a referred doctor user' do
      let!(:current_user){ sign_in referred_doctor}
      it 'forbids access' do
        post :update, params: {id: ref_staff.id, referral: {specialization_id: special.id}}
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'as an admin' do
      let!(:current_user){ sign_in admin}
      it 'forbids access' do
        post :update, params: {id: ref_staff.id, referral: {specialization_id: special.id}}
        expect(response).to redirect_to(home_index_path)
      end 
    end
  end
  describe '#destroy' do
    context 'as a non-signed in user' do
      it 'forbids access' do
        delete :destroy, params: {id: referrals_staff[0].id}
        expect(response).to redirect_to(home_index_path)
      end 
    end
    context 'as a referring staff user' do
      let!(:current_user){ sign_in referring_staff}
      it 'allows access' do
        expect{ delete :destroy, params: {id: referrals_staff[0].id} }.
          to change(Referral, :count).by(-1)
      end 
    end
    context 'as a referring doctor user' do
      let!(:current_user){ sign_in referring_doctor}
      it 'allows access' do
        expect{ delete :destroy, params: {id: referrals_doc[0].id} }.
          to change(Referral, :count).by(-1)
      end 
    end
    context 'as a referred staff user' do
      let!(:current_user){ sign_in referred_staff}
      it 'forbids access' do
        delete :destroy, params: {id: referrals_staff[0].id}
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'as a referred doctor user' do
      let!(:current_user){ sign_in referred_doctor}
      it 'forbids access' do
        delete :destroy, params: {id: referrals_staff[0].id}
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'as an admin' do
      let!(:current_user){ sign_in admin}
      it 'forbids access' do
        delete :destroy, params: {id: referrals_staff[0].id}
        expect(response).to redirect_to(home_index_path)
      end 
    end
  end
  describe '#assign_patient' do
    context 'as a non-signed in user' do
      it 'forbids access' do
        get :assign_patient, params: {id: ref_staff.patient.id}
        expect(response).to redirect_to(home_index_path)
      end 
    end
    context 'as a referring staff user' do
      let!(:current_user){ sign_in referring_staff}
      it 'allows access' do
        get :assign_patient, params: {id: ref_staff.patient.id}
        expect(assigns(:patient)).to eq(ref_staff.patient)
      end 
    end
    context 'as a referring doctor user' do
      let!(:current_user){ sign_in referring_doctor}
      it 'allows access' do
        get :assign_patient, params: {id: ref_doc.patient.id}
        expect(assigns(:patient)).to eq(ref_doc.patient)
      end 
    end
    context 'as a referred staff user' do
      let!(:current_user){ sign_in referred_staff}
      it 'forbids access' do
        get :assign_patient, params: {id: ref_staff.patient.id}
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'as a referred doctor user' do
      let!(:current_user){ sign_in referred_doctor}
      it 'forbids access' do
        get :assign_patient, params: {id: ref_staff.patient.id}
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'as an admin' do
      let!(:current_user){ sign_in admin}
      it 'forbids access' do
        get :assign_patient, params: {id: ref_staff.patient.id}
        expect(response).to redirect_to(home_index_path)
      end 
    end
  end
  describe '#send_referral' do
    context 'as a non-signed in user' do
      it 'forbids access' do
        patch :send_referral, params: {id: ref_staff.id, patient: {first_name: 'TESTNAME'}}
        expect(response).to redirect_to(home_index_path)
      end 
    end
    context 'as a referring staff user' do
      let!(:current_user){ sign_in referring_staff}
      it 'allows access' do
        patch :send_referral, params: {id: ref_staff.id, patient: {first_name: 'TESTNAME'}}
        expect(assigns(:referral).status).to eq(2)
      end 
    end
    context 'as a referring doctor user' do
      let!(:current_user){ sign_in referring_doctor}
      it 'allows access' do
        patch :send_referral, params: {id: ref_doc.id, patient: {first_name: 'TESTNAME'}}
        expect(assigns(:referral).status).to eq(2)
      end 
    end
    context 'as a referred staff user' do
      let!(:current_user){ sign_in referred_staff}
      it 'forbids access' do
        patch :send_referral, params: {id: ref_staff.id, patient: {first_name: 'TESTNAME'}}
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'as a referred doctor user' do
      let!(:current_user){ sign_in referred_doctor}
      it 'forbids access' do
        patch :send_referral, params: {id: ref_staff.id, patient: {first_name: 'TESTNAME'}}
        expect(response).to redirect_to(home_index_path)
      end
    end
    context 'as an admin' do
      let!(:current_user){ sign_in admin}
      it 'forbids access' do
        patch :send_referral, params: {id: ref_staff.id, patient: {first_name: 'TESTNAME'}}
        expect(response).to redirect_to(home_index_path)
      end 
    end
  end
end
