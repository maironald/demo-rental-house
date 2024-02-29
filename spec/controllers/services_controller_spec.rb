# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ServicesController, type: :controller do
  # let(:user) { create(:user) }

  # before do
  #   allow(controller).to receive(:authenticate_user!).and_return(true)
  #   allow(controller).to receive(:current_user).and_return(user)
  # end

  # let(:service) { create(:service) }

  # describe 'GET #index' do
  #   let!(:services) { create_list(:service, 12, user:) } # Assuming there are at least 12 services

  #   before do
  #     sign_in user # Sign in the user before each example
  #   end

  #   it 'returns a success response' do
  #     get :index
  #     expect(response).to be_successful
  #   end

  #   it 'paginates the services' do
  #     get :index
  #     expect(assigns(:services)).to respond_to(:each)
  #     expect(assigns(:services)).to respond_to(:to_a)
  #     expect(assigns(:pagy)).to be_a(Pagy)
  #   end
  # end

  # describe 'GET #new' do
  #   it 'assigns a new service to @service' do
  #     get :new, format: :turbo_stream
  #     expect(assigns(:service)).to be_a_new(Service)
  #   end

  #   it 'renders the turbo_stream template' do
  #     get :new, format: :turbo_stream
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe 'POST #create' do
  #   context 'with valid parameters' do
  #     let(:valid_params) { { service: attributes_for(:service) } }

  #     it 'creates a new service' do
  #       expect do
  #         post :create, params: valid_params
  #       end.to change(Service, :count).by(1)
  #     end

  #     it 'redirects to services path with notice' do
  #       post :create, params: valid_params
  #       expect(response).to redirect_to(services_path)
  #       expect(flash[:notice]).to eq('Service was successfully created.')
  #     end

  #     it 'renders turbo_stream with service list' do
  #       post :create, params: valid_params, format: :turbo_stream
  #       expect(response).to have_http_status(:ok)
  #       expect(response.body).to include('turbo-stream')
  #       expect(response.body).to include('service-list')
  #     end
  #   end

  #   context 'with invalid parameters' do
  #     let(:invalid_params) { { service: attributes_for(:service, name: nil) } }

  #     it 'does not create a new service' do
  #       expect do
  #         post :create, params: invalid_params, format: :turbo_stream
  #       end.not_to change(Service, :count)
  #     end

  #     it 'renders the new template with status :unprocessable_entity' do
  #       post :create, params: invalid_params, format: :turbo_stream
  #       expect(response).to have_http_status(:unprocessable_entity)
  #     end
  #   end
  # end

  # describe 'PUT #update' do
  #   context 'with valid parameters' do
  #     let(:valid_params) { { id: service.id, service: { name: 'New Name' } } }

  #     it 'updates the service' do
  #       put :update, params: valid_params, format: :turbo_stream
  #       expect(service.reload.name).to eq('New Name')
  #     end

  #     it 'redirects to services path with notice' do
  #       put :update, params: valid_params
  #       expect(response).to redirect_to(services_path)
  #       expect(flash[:notice]).to eq('Service was successfully updated.')
  #     end

  #     it 'renders turbo_stream with service list' do
  #       put :update, params: valid_params, format: :turbo_stream
  #       expect(response).to have_http_status(:ok)
  #       expect(response.body).to include('turbo-stream')
  #     end
  #   end

  #   context 'with invalid parameters' do
  #     let(:invalid_params) { { id: service.id, service: { name: nil } } }

  #     it 'does not update the service' do
  #       expect do
  #         put :update, params: invalid_params, format: :turbo_stream
  #       end.not_to change { service.reload.name }
  #     end

  #     it 'renders the edit template with status :unprocessable_entity' do
  #       put :update, params: invalid_params, format: :turbo_stream
  #       expect(response).to have_http_status(:unprocessable_entity)
  #     end
  #   end
  # end

  # describe 'DELETE #destroy' do
  #   it 'destroys the service' do
  #     service # Ensure the service is created
  #     expect do
  #       delete :destroy, params: { id: service.id }
  #     end.to change(Service, :count).by(-1)
  #   end

  #   it 'redirects to services path with notice' do
  #     delete :destroy, params: { id: service.id }
  #     expect(response).to redirect_to(services_path)
  #     expect(flash[:notice]).to eq('Service was successfully deleted.')
  #   end
  # end

  let(:user) { create(:user) }
  let(:service) { create(:service, user:) }

  before { sign_in(user) }

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new, format: :turbo_stream
      expect(response).to render_template(:new, format: :turbo_stream)
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      get :edit, params: { id: service.id }, format: :turbo_stream
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    let(:valid_params) { { service: attributes_for(:service) } }

    it 'creates a new service' do
      expect do
        post :create, params: valid_params, format: :turbo_stream
      end.to change(Service, :count).by(1)

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the service' do
      service # Ensure the service is created
      expect do
        delete :destroy, params: { id: service.id }
      end.to change(Service, :count).by(-1)

      expect(response).to have_http_status(:found)
    end
  end
end
