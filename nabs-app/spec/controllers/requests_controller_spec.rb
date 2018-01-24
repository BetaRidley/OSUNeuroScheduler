require 'rails_helper'

RSpec.describe RequestsController, type: :controller do
  let!(:referring_staff){FactoryBot.create(:user, :staff, :confirmed)}
  let!(:referring_doctor){FactoryBot.create(:user, :referring_doctor, :confirmed)}
  let!(:referred_staff){FactoryBot.create(:user, :referred_staff, :confirmed)}
  let!(:referred_doctor){FactoryBot.create(:user, :referred_doctor, :confirmed)}
  let!(:admin){FactoryBot.create(:user, :admin, :confirmed)}

  let(:current_user){ sign_in nil}
  describe '#index' do
    let!(:requests){FactoryBot.create_list(:referral, 5, :sent)}
    context 'as a non-signed in user' do
      it 'forbids access' do
        get :index
        expect(response).to redirect_to(home_index_path)
      end 
    end
    context 'as a referring staff user' do
      let!(:current_user){ sign_in referring_staff}
      it 'forbids access' do
        get :index
        expect(response).to redirect_to(home_index_path)
      end 
    end
    context 'as a referring doctor user' do
      let!(:current_user){ sign_in referring_doctor}
      it 'forbids access' do
        get :index
        expect(response).to redirect_to(home_index_path)
      end 
    end
    context 'as a referred staff user' do
      let!(:current_user){ sign_in referred_staff}
      it 'allows access' do
        get :index
        expect(assigns(:requests)).to eq(requests)
      end
    end
    context 'as a referred doctor user' do
      let!(:current_user){ sign_in referred_doctor}
      it 'allows access' do
        get :index
        expect(assigns(:requests)).to eq(requests)
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
  describe '#deny' do
    context 'as a non-signed in user' do
      let!(:request){ FactoryBot.create(:referral, :sent) }
      it 'forbids access' do
        patch :deny, params: { id: request.id}
        expect(response).to redirect_to(home_index_path)
      end 
    end
    context 'as a referring staff user' do
      let!(:request){ FactoryBot.create(:referral, :sent) }
      let!(:current_user){ sign_in referring_staff}
      it 'forbids access' do
        patch :deny, params: { id: request.id } 
        expect(response).to redirect_to(home_index_path)
      end 
    end
    context 'as a referring doctor user' do
      let!(:request){ FactoryBot.create(:referral, :sent) }
      let!(:current_user){ sign_in referring_doctor}
      it 'forbids access' do
        patch :deny, params: { id: request.id }
        expect(response).to redirect_to(home_index_path)
      end 
    end
    context 'as a referred staff user' do
      let!(:request){ FactoryBot.create(:referral, :sent) }
      let!(:current_user){ sign_in referred_staff}
      it 'allows denial of a referral' do
        patch :deny, params: { id: request.id } 
        expect(assigns(:request).status).to eq(4)
        expect(response).to redirect_to(requests_path)
      end
    end
    context 'as a referred doctor user' do
      let!(:request){ FactoryBot.create(:referral, :sent) }
      let!(:current_user){ sign_in referred_doctor}
      it 'allows denial of a referral' do
        patch :deny, params: { id: request.id } 
        expect(assigns(:request).status).to eq(4)
        expect(response).to redirect_to(requests_path)
      end
    end
    context 'as an admin' do
      let!(:request){ FactoryBot.create(:referral, :sent) }
      let!(:current_user){ sign_in admin}
      it 'forbids access' do
        patch :deny, params: { id: request.id } 
        expect(response).to redirect_to(home_index_path)
      end 
    end
  end
  describe '#accept' do
    context 'as a non-signed in user' do
      let!(:request){ FactoryBot.create(:referral, :sent) }
      it 'forbids access' do
        patch :accept, params: { id: request.id } 
        expect(response).to redirect_to(home_index_path)
      end 
    end
    context 'as a referring staff user' do
      let!(:request){ FactoryBot.create(:referral, :sent) }
      let!(:current_user){ sign_in referring_staff}
      it 'forbids access' do
        patch :accept, params: { id: request.id } 
        expect(response).to redirect_to(home_index_path)
      end 
    end
    context 'as a referring doctor user' do
      let!(:request){ FactoryBot.create(:referral, :sent) }
      let!(:current_user){ sign_in referring_doctor}
      it 'forbids access' do
        patch :accept, params: { id: request.id } 
        expect(response).to redirect_to(home_index_path)
      end 
    end
    context 'as a referred staff user' do
      let!(:request){ FactoryBot.create(:referral, :sent) }
      let!(:current_user){ sign_in referred_staff}
      it 'allows acceptance of a referral' do
        patch :accept, params: { id: request.id } 
        expect(assigns(:request).status).to eq(3)
        expect(response).to redirect_to(requests_path)
      end
    end
    context 'as a referred doctor user' do
      let!(:request){ FactoryBot.create(:referral, :sent) }
      let!(:current_user){ sign_in referred_doctor}
      it 'allows acceptance of a referral' do
        patch :accept, params: { id: request.id } 
        expect(assigns(:request).status).to eq(3)
        expect(response).to redirect_to(requests_path)
      end
    end
    context 'as an admin' do
      let!(:request){ FactoryBot.create(:referral, :sent) }
      let!(:current_user){ sign_in admin}
      it 'forbids access' do
        patch :accept, params: { id: request.id } 
        expect(response).to redirect_to(home_index_path)
      end 
    end
  end
end
