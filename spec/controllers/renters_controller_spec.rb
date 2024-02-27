# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RentersController, type: :controller do
  let(:user) { create(:user) }
  let(:room) { create(:room, user:, electric_amount_old: 10, electric_amount_new: 20, water_amout_old: 30, water_amout_new: 40) }
  let(:renter) { create(:renter, room:) }
  let(:valid_params) { { renter: attributes_for(:renter), room_id: room.id } }

  before { sign_in(user) }

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #edit' do
    let(:renter) { create(:renter, room:) }

    it 'renders the edit template' do
      get :edit, params: { id: renter.id }, format: :turbo_stream
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    it 'creates a new renter' do
      expect do
        post :create, params: valid_params
      end.to change(Renter, :count).by(1)

      expect(response).to redirect_to(rooms_path)
    end
  end

  describe 'PATCH #update' do
    let(:renter) { create(:renter, room:) }
    let(:valid_params) { { id: renter.id, renter: { name: 'Updated Renter' } } }

    it 'updates the renter' do
      patch :update, params: valid_params
      renter.reload
      expect(renter.name).to eq('Updated Renter')
      expect(response).to redirect_to(renters_path)
    end
  end

  describe 'GET #show_renters' do
    it 'renders the show_renters template' do
      get :show_renters, params: { room_id: room.id }, format: :turbo_stream
      expect(response).to render_template(:show_renters)
    end
  end
end
